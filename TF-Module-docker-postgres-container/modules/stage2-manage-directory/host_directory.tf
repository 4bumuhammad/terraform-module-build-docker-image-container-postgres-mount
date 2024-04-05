terraform {
  required_providers {
    null = {
      source = "hashicorp/null"
    }
  }
}

resource "null_resource" "manage_directory" {
  triggers = {
    always_run = "${timestamp()}"
  }

}