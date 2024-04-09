data "external" "get_home_path" {
  program = ["sh", "${path.module}/get_home.sh"]
}

variable "datatest_directory" {
  description = "Path to the datatest directory"
  default     = "/Documents/test/docker-mount/postgres-test/"
}

locals {
  full_datatest_directory = "${data.external.get_home_path.result["path"]}${var.datatest_directory}"
}

# SOLVED https://stackoverflow.com/questions/52503528/why-is-my-terraform-output-not-working-in-module