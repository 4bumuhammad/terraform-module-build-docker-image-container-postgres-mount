data "external" "get_home_path" {
  program = ["sh", "${path.module}/modules/stage2-manage-directory/get_home.sh"]
}

variable "datatest_directory" {
  description = "Path to the datatest directory"
  default     =  "/Documents/test/docker-mount/postgres-test/"
}

locals {
  full_datatest_directory = "${data.external.get_home_path.result["path"]}${var.datatest_directory}"
}