module "stage1_docker_postgresql" {
  source      = "./modules/stage1-docker-postgresql"
  docker_host = var.docker_host
}

module "stage2_manage_directory" {
  source = "./modules/stage2-manage-directory"

  depends_on = [ module.stage1_docker_postgresql ]
}

# module "stage3_docker_container" {
#   source = "./modules/stage3-docker-container"
#   datatest_directory  = module.stage2_manage_directory.full_datatest_directory_output
# }
