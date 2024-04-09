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

resource "docker_image" "postgres" {
  name         = "postgres:16.2"
  keep_locally = false
}

resource "null_resource" "docker_images" {
  triggers = {
    always_run   = "${timestamp()}"
    trigger_name = "trigger-docker-images"
  }

  provisioner "local-exec" {
    command = <<EOT
      echo "REPORTS" > ${path.module}/docker_image_results.txt
      echo "  Trigger Name: ${self.triggers.trigger_name}" >> ${path.module}/docker_image_results.txt
      echo "  Result docker image filter : "| tr '\n' ' ' >> ${path.module}/docker_image_results.txt && docker images --format '{{.Repository}}\t{{.Tag}}\t{{.ID}}\t{{.CreatedAt}}\t{{.Size}}' | grep -E 'postgres|16.2' >> ${path.module}/docker_image_results.txt
      echo "  Timestamp: $(date)" >> ${path.module}/docker_image_results.txt
    EOT

    # command = "docker images --format '{{.Repository}}\t{{.Tag}}\t{{.ID}}\t{{.CreatedAt}}\t{{.Size}}' | grep -E 'postgres|16.2' > ${path.module}/docker_image_results.txt"
  }
  depends_on = [docker_image.postgres]
}

data "local_file" "docker_images_result" {
  depends_on = [null_resource.docker_images]
  filename   = "${path.module}/docker_image_results.txt"
}

output "filtered_docker_images_output" {
  value = data.local_file.docker_images_result.content
}

resource "null_resource" "delete_file" {
  triggers = {
    always_run   = "${timestamp()}"
    trigger_name = "trigger-delete-file"
  }

  depends_on = [data.local_file.docker_images_result]

  provisioner "local-exec" {
    command = "rm -f ${path.module}/docker_image_results.txt"
    interpreter = ["bash", "-c"]
  }
}