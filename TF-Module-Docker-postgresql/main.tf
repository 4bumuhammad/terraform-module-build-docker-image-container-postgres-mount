# Stages 1:
resource "docker_image" "postgres" {
  name         = "postgres:16.2"
  keep_locally = false
}


# Stages 2:
resource "null_resource" "manage_directory" {
  triggers = {
    always_run = "${timestamp()}"
  }

  # Mengecek apakah direktori kosong atau mengandung folder pg_*
  provisioner "local-exec" {
    command = <<-EOT
      if [ -n "$(find ${local.full_datatest_directory} -mindepth 1 -maxdepth 1 -type d -name 'pg_*' -print -quit)" ]; then
        echo "Direktori mengandung setidaknya satu folder yang dimulai dengan 'pg_' sehingga tidak diperlukan perlakukan apapun terhadap direktori tersebut."
      else
        rm -rf ${local.full_datatest_directory} && mkdir -p ${local.full_datatest_directory}
      fi
    EOT
  }
}



# Stages 3:
resource "docker_container" "postgres" {
  image    = docker_image.postgres.name
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
    "POSTGRES_PASSWORD=${var.postgres_password}",
  ]
  volumes {
    # volume_name    = "postgres_data"
    host_path      = local.full_datatest_directory
    container_path = "/var/lib/postgresql/data"
  }
}