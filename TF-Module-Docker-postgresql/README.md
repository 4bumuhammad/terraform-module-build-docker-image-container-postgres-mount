&nbsp;

Reference :<br />
- Doc. | Docker Kreuzwerker Provider
  <pre>https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs</pre>

- An example if done using the docker run command.
    <pre>
        ❯ docker run -d \
        --name postgres-container \
        -e POSTGRES_USER=postgres \
        -e POSTGRES_PASSWORD=postgres \
        -p 5432:5432 \
        -v ~/Documents/test/docker-mount/postgres-test:/var/lib/postgresql/data \
        postgres:16.2
    </pre>

---

&nbsp;


## &#x1F6A9; Terraform TF-Module-Docker-postgresql = docker postgresql:16.2

<div align="center">
    <img src="../gambar-petunjuk/ss_docker_registry_postgres.png" alt="ss_docker_registry_postgres" style="display: block; margin: 0 auto;">
    <p align="center">https://hub.docker.com/layers/library/postgres/16.2/images/sha256-fe5bab5720ec73a61209666d67c6ce5a20861a0a8f58115dd594c85a900e958a?context=explore</p>
</div>

&nbsp;

&nbsp;

### &#127937; Start terraform infastructure exercise as code.

<pre>
    ❯ vim TF-Module-Docker-postgresql/provider.tf
</pre>
<pre>
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
</pre>

&nbsp;

<pre>
    ❯ vim TF-Module-Docker-postgresql/main.tf
</pre>
<pre>
            resource "docker_image" "postgres" {
              name         = "postgres:16.2"
              keep_locally = false
            }
            
            resource "null_resource" "manage_directory" {
              triggers = {
                always_run = "${timestamp()}"
              }
            
              # Mengecek apakah direktori kosong atau mengandung folder pg_*
              provisioner "local-exec" {
                command = <<-EOT
                  if [ -n "$(find ${var.datatest_directory} -mindepth 1 -maxdepth 1 -type d -name 'pg_*' -print -quit)" ]; then
                    echo "Direktori mengandung setidaknya satu folder yang dimulai dengan 'pg_' sehingga tidak diperlukan perlakukan apapun terhadap direktori tersebut."
                  else
                    rm -rf ${var.datatest_directory} && mkdir -p ${var.datatest_directory}
                  fi
                EOT
              }
            }
            
            
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
                host_path      = var.datatest_directory
                container_path = "/var/lib/postgresql/data"
              }
            }
</pre>

&nbsp;

<pre>
    ❯ vim TF-Module-Docker-postgresql/variables.tf
</pre>
<pre>
        variable "postgres_password" {
            type        = string
            description = "Password for PostgreSQL database"
            sensitive   = true
        }


        variable "datatest_directory" {
            description = "Path to the datatest directory"
            default     = "~/Documents/test/docker-mount/postgres-test/"
        }
</pre>

&nbsp;

<pre>
    ❯ mkdir TF-Module-Docker-postgresql/secret

    ❯ vim TF-Module-Docker-postgresql/secret/terraform_postgres.tfvars

            postgres_password = "password123"
</pre>

&nbsp;

<pre>
    ❯ vim TF-Module-Docker-postgresql/outputs.tf
</pre>
<pre>
        output "docker_container_name" {
            value = "HI, INI OUTPUT KU = ${docker_container.postgres.name}"
        }
</pre>

&nbsp;

<pre>
    ❯ tree -L 2 -a -I 'README.md|.DS_Store|.terraform|*.hcl|*.tfstate|*.tfstate.backup' ./TF-Module-Docker-postgresql
        ├── main.tf
        ├── outputs.tf
        ├── provider.tf
        ├── secret
        │   └── terraform_postgres.tfvars
        └── variables.tf
        
        1 directory, 5 files
</pre>

&nbsp;

### &#x1F530; TERRAFORM STAGES :

<pre>
    ❯ terraform -chdir=./TF-Module-Docker-postgresql init



</pre>

&nbsp;

<pre>
    ❯ terraform -chdir=./TF-Module-Docker-postgresql fmt

    ❯ terraform -chdir=./TF-Module-Docker-postgresql validate

            Success! The configuration is valid.
</pre>

&nbsp;

<pre>
    ❯ terraform -chdir=./TF-Module-Docker-postgresql plan -var-file=./secret/terraform_postgres.tfvars



</pre>

&nbsp;

<pre>
    ❯ terraform -chdir=./TF-Module-Docker-postgresql apply -var-file=./secret/terraform_postgres.tfvars


</pre>

&nbsp;

---

If you want to run stage apply with auto approve on the confirmation.
<pre>
    ❯ terraform -chdir=./TF-Module-Docker-postgresql apply -var-file=./secret/terraform_postgres.tfvars -auto-approve
</pre>

&nbsp;

&#x1F534; If you want to display the `trace log`, you can use the following command in the apply stage of this terraform &#x1F3C3;.
<pre>
    ❯ TF_LOG_CORE=trace terraform -chdir=./TF-Module-Docker-postgresql apply -var-file=./secret/terraform_postgres.tfvars
</pre>

---

&nbsp;

### &#x1F530; Result.

<pre>
    ❯ docker images

        REPOSITORY   TAG          IMAGE ID       CREATED       SIZE
        nginx        alpine3.18   b8c82647e8a2   6 weeks ago   43.6MB


    ❯ docker container list

        CONTAINER ID   IMAGE           COMMAND                  CREATED         STATUS         PORTS                    NAMES
        141cf9f9bf55   postgres:16.2   "docker-entrypoint.s…"   5 minutes ago   Up 5 minutes   0.0.0.0:5432->5432/tcp   Terraform-postgres</pre>

<div align="center">
    <img src="../gambar-petunjuk/ss_docker_container_terraform_postgres.png" alt="ss_docker_container_terraform_postgres" style="display: block; margin: 0 auto;">
</div>

&nbsp;

State after which the directory is mounted with volumes.
<div align="center">
    <img src="../gambar-petunjuk/ss_list_dir_postgres-test-s900.png" alt="ss_list_dir_postgres-test-s900" style="display: block; margin: 0 auto;">
</div>

&nbsp;

&nbsp;

Implement a postgresql connection using DBEAVER to the Terraform-postgres container endpoint and test creating a database named 'db_test123'.

<div align="center">
    <img src="../gambar-petunjuk/ss_dbeaver_Terraform-postgres.png" alt="ss_dbeaver_Terraform-postgres" style="display: block; margin: 0 auto;">
</div>

<pre>
        postgres-# \l

                                                               List of databases
            Name    |  Owner   | Encoding | Locale Provider |  Collate   |   Ctype    | ICU Locale | ICU Rules |   Access privileges
        ------------+----------+----------+-----------------+------------+------------+------------+-----------+-----------------------
         db_test123 | postgres | UTF8     | libc            | en_US.utf8 | en_US.utf8 |            |           |
         postgres   | postgres | UTF8     | libc            | en_US.utf8 | en_US.utf8 |            |           |
</pre>

&nbsp;

<pre>
    ❯ terraform -chdir=./TF-Module-Docker-postgresql destroy -var-file=./secret/terraform_postgres.tfvars


</pre>

&nbsp;

<pre>
    ❯  docker images

            REPOSITORY   TAG       IMAGE ID   CREATED   SIZE


    ❯ docker ps -a

            CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
</pre>

&nbsp;

&nbsp;

---

&nbsp;


<div align="center">
    <img src="../gambar-petunjuk/well_done.png" alt="well_done" style="display: block; margin: 0 auto;">
</div>

&nbsp;
