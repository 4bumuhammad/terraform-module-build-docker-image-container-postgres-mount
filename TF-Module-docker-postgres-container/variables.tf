variable "docker_host" {
  description = "Docker host address"
  default     = "unix:///var/run/docker.sock"
}

variable "docker_image_name" {
  default = "postgres"
}

variable "docker_image_tag" {
  default = "16.2"
}