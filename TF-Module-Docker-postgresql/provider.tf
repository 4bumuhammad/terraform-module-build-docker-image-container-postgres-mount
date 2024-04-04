terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
    null = {
      source = "hashicorp/null"
    }    
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}