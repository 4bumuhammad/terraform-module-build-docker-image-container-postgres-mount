module "stage1_docker_postgresql" {
  source                       = "./modules/stage1-docker-postgresql"
  docker_host                  = var.docker_host
  docker_image_name_transition = var.docker_image_name
  docker_image_tag_transition  = var.docker_image_tag
}

module "stage2_manage_directory" {
  source     = "./modules/stage2-manage-directory"
  depends_on = [module.stage1_docker_postgresql]
}


module "stage3_docker_container" {
  source                       = "./modules/stage3-docker-container"
  docker_image_name_transition = var.docker_image_name
  docker_image_tag_transition  = var.docker_image_tag
  datatest_directory           = module.stage2_manage_directory.full_datatest_directory_output
  postgres_password_transition = var.postgres_password
  depends_on                   = [module.stage2_manage_directory]
}