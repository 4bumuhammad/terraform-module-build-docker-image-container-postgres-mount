module "stage1_docker_postgresql" {
  source      = "./modules/stage1-docker-postgresql"
  docker_host = var.docker_host
}

module "stage2_docker_nginx" {
  source      = "./modules/stage2-docker-nginx"
  docker_host = var.docker_host
}