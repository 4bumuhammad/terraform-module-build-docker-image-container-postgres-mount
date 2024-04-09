variable "docker_image_name_transition" {
  description = "image name"
}

variable "docker_image_tag_transition" {
  description = "image tag"
}
variable "datatest_directory" {
  description = "Path to the datatest directory"
  type        = string
}

variable "postgres_password" {
  type        = string
  description = "Password for PostgreSQL database"
  sensitive   = true
}