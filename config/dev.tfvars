aws_region = "us-east-1"
container_port = 80
key_pair_name = "nouman_pk"
service_name = "nginx"
memory_reserv = 128
aws_account_id = "020046395185"

github = {
    github_owner = "Nouman72884"
    github_repo = "ecs-codepipeline-terraform"
    github_branch = "master"
    github_token = "bb6dfa3e7a23a6cba2339a61d5b4e411a0ddff2b"
}
vpc = {
    vpc_id = "vpc-0f7c4b54536f31bf0"
    private_subnet_ids = ["subnet-070210f89076af71a","subnet-0d219a4b3748f9196"]
    public_subnet_ids = ["subnet-0650ec71993930458","subnet-06d5f8c536129a77b"]
    }


