# data "template_file" "buildspec" {
#   template = file("./template/buildspec.yaml")

#   vars = {
#     app_name     = var.service_name
#     service_port = var.container_port
#     aws_account_id = "020046395185"
#     memory_reserv = var.memory_reserv
#     image_name = "020046395185.dkr.ecr.us-east-1.amazonaws.com/nginx:latest"
#   }
# }

module "alb" {
  source                = "./modules/alb"
  alb_security_group_id = module.security_groups.alb_security_group_id
  service_name          = var.service_name
  settings              = var.vpc

}

module "autoscaling_group" {
  source                     = "./modules/autoscaling_group"
  instance_security_group_id = module.security_groups.instance_security_group_id
  key_pair_name              = var.key_pair_name
  service_name               = var.service_name
  settings                   = var.vpc
}



module "codepipeline" {
  source                     = "./modules/codepipeline"
  service_name               = var.service_name
  cluster_name               = module.ecs_cluster.ecs_cluster_name
  settings                   = var.github
  aws_account_id = var.aws_account_id
  aws_region     = var.aws_region
  container_port = var.container_port
  memory_reserv  = var.memory_reserv
  task_definition = module.task_definition.task_definition_arn
  #buildspec = data.template_file.buildspec.rendered
}

# module "service" {
#   source = "./modules/service"
#   target_groups = module.alb.target_groups
#   container_port = var.container_port
#   ecs_cluster_arn = module.ecs_cluster.ecs_cluster_arn
#   service_name = var.service_name
#   task_definition_id = module.task_definition.task_definition_id
#   private_subnet_ids = var.vpc.private_subnet_ids
#   instance_security_group_id = module.security_groups.instance_security_group_id
# }


module "ecs_cluster" {
  source                = "./modules/ecs_cluster"
  alb_security_group_id = module.security_groups.alb_security_group_id
  service_name          = var.service_name
  settings              = var.vpc

}

module "security_groups" {
  source       = "./modules/security_groups"
  settings     = var.vpc
  service_name = var.service_name
}

module "task_definition" {
  source         = "./modules/task_definition"
  container_port = var.container_port
  execution_role = module.ecs_cluster.execution_role
  service_name   = var.service_name
  task_role      = module.ecs_cluster.task_role
}


# module "code_build" {
#   source         = "./modules/code_build"
#   service_name   = var.service_name
#   settings       = var.github
#   aws_account_id = var.aws_account_id
#   aws_region     = var.aws_region
#   container_port = var.container_port
#   memory_reserv  = var.memory_reserv
# }

# module "code_deploy" {
#   source           = "./modules/code_deploy"
#   service_name     = var.service_name
#   ecs_cluster_name = module.ecs_cluster.ecs_cluster_name
#   ecs_service_name = module.service.ecs_service_name
#   alb_listener_1   = module.alb.alb_listener_1
#   alb_listener_2   = module.alb.alb_listener_2
#   target_group_1   = module.alb.target_groups[0]
#   target_group_2   = module.alb.target_groups[1]
#   task_role        = module.ecs_cluster.task_role
#   execution_role   = module.ecs_cluster.execution_role
# }