terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

resource "docker_container" "postgres" {
  image    = "${var.docker_image_name_transition}:${var.docker_image_tag_transition}"
  name     = "Terraform-postgres"
  must_run = true
  memory   = 512


  ports {
    internal = 5432
    external = 5432
    ip       = "0.0.0.0"
  }

  env = [
    "POSTGRES_USER=postgres",
    # "POSTGRES_PASSWORD=password12345",
    "POSTGRES_PASSWORD=${var.postgres_password_transition}",
  ]
  volumes {
    host_path      = var.datatest_directory
    container_path = "/var/lib/postgresql/data"
  }
}


resource "null_resource" "docker_container" {
  depends_on = [docker_container.postgres]

  triggers = {
    always_run   = "${timestamp()}"
    trigger_name = "trigger-docker-container"
  }

  provisioner "local-exec" {
    command = <<EOT
      echo "REPORTS" > ${path.module}/docker_container_results.txt
      echo "  Trigger Name: ${self.triggers.trigger_name}" >> ${path.module}/docker_container_results.txt
      echo "  Data directory: ${var.datatest_directory}" >> ${path.module}/docker_container_results.txt
      echo "  Timestamp: $(date)" >> ${path.module}/docker_container_results.txt
    EOT
  }
}

data "local_file" "docker_container_result" {
  depends_on = [null_resource.docker_container]
  filename   = "${path.module}/docker_container_results.txt"
}

output "filtered_docker_container_output" {
  value = data.local_file.docker_container_result.content
}

resource "null_resource" "delete_file" {
  triggers = {
    always_run   = "${timestamp()}"
    trigger_name = "trigger-delete-file"
  }

  depends_on = [data.local_file.docker_container_result]

  provisioner "local-exec" {
    command = "rm -f ${path.module}/docker_container_results.txt"
    interpreter = ["bash", "-c"]
  }
}