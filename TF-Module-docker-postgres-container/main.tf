module "stage1_docker_postgresql" {
  source      = "./modules/stage1-docker-postgresql"
  docker_host = var.docker_host
}

module "stage2_manage_directory" {
  source      = "./modules/stage2-manage-directory"
}