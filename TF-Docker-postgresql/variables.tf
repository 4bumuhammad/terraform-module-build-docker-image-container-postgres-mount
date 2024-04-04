variable "postgres_password" {
  type        = string
  description = "Password for PostgreSQL database"
  sensitive   = true
}

data "external" "get_home_path" {
  program = ["sh", "${path.module}/get_home.sh"]
}

variable "datatest_directory" {
  description = "Path to the datatest directory"
  default     =  "/Documents/test/docker-mount/postgres-test/"
}

locals {
  full_datatest_directory = "${data.external.get_home_path.result["path"]}${var.datatest_directory}"
}
