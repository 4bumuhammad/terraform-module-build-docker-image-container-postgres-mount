terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {
  alias = "main_docker"
  host  = var.docker_host
}

resource "docker_image" "nginx" {
  name         = "nginx:alpine3.18"
  keep_locally = false
}
