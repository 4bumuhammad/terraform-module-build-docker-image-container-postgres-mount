&nbsp;

Reference :<br />
- Doc. | Docker Kreuzwerker Provider
  <pre>https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs</pre>

---

&nbsp;

&nbsp;

### &#127937; Start terraform infastructure exercise as code.

&nbsp;

<pre>
  ❯ tree -L 4 -a -I 'README.md|.DS_Store|.terraform|*.hcl|*.tfstate|*.tfstate.backup' ./TF-Module-docker-multi-image
      ├── main.tf
      ├── modules
      │   ├── stage1-docker-postgresql
      │   │   ├── docker_images.tf
      │   │   ├── outputs.tf
      │   │   └── variables.tf
      │   └── stage2-docker-nginx
      │       ├── docker_images.tf
      │       ├── outputs.tf
      │       └── variables.tf
      └── variables.tf

      3 directories, 8 files
</pre>

&nbsp;

### &#x1F530; TERRAFORM STAGES :

<pre>
    ❯ terraform -chdir=./TF-Module-docker-multi-image init


          Initializing the backend...
          Initializing modules...

          Initializing provider plugins...
          - Reusing previous version of kreuzwerker/docker from the dependency lock file
          - Using previously-installed kreuzwerker/docker v3.0.2

          Terraform has been successfully initialized!

          You may now begin working with Terraform. Try running "terraform plan" to see
          any changes that are required for your infrastructure. All Terraform commands
          should now work.

          If you ever set or change modules or backend configuration for Terraform,
          rerun this command to reinitialize your working directory. If you forget, other
          commands will detect it and remind you to do so if necessary.

</pre>

&nbsp;

<pre>
    ❯ terraform -chdir=./TF-Module-docker-multi-image fmt -recursive

    ❯ terraform -chdir=./TF-Module-docker-multi-image validate

            Success! The configuration is valid.
</pre>

&nbsp;

<pre>
    ❯ terraform -chdir=./TF-Module-docker-multi-image plan


          Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
            + create

          Terraform will perform the following actions:

            # module.stage1_docker_postgresql.docker_image.postgres will be created
            + resource "docker_image" "postgres" {
                + id           = (known after apply)
                + image_id     = (known after apply)
                + keep_locally = false
                + name         = "postgres:16.2"
                + repo_digest  = (known after apply)
              }

            # module.stage2_docker_nginx.docker_image.nginx will be created
            + resource "docker_image" "nginx" {
                + id           = (known after apply)
                + image_id     = (known after apply)
                + keep_locally = false
                + name         = "nginx:alpine3.18"
                + repo_digest  = (known after apply)
              }

          Plan: 2 to add, 0 to change, 0 to destroy.

          ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

          Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
</pre>

&nbsp;

<pre>
    ❯ terraform -chdir=./TF-Module-docker-multi-image apply -auto-approve



          Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
            + create

          Terraform will perform the following actions:

            # module.stage1_docker_postgresql.docker_image.postgres will be created
            + resource "docker_image" "postgres" {
                + id           = (known after apply)
                + image_id     = (known after apply)
                + keep_locally = false
                + name         = "postgres:16.2"
                + repo_digest  = (known after apply)
              }

            # module.stage2_docker_nginx.docker_image.nginx will be created
            + resource "docker_image" "nginx" {
                + id           = (known after apply)
                + image_id     = (known after apply)
                + keep_locally = false
                + name         = "nginx:alpine3.18"
                + repo_digest  = (known after apply)
              }

          Plan: 2 to add, 0 to change, 0 to destroy.
          module.stage1_docker_postgresql.docker_image.postgres: Creating...
          module.stage2_docker_nginx.docker_image.nginx: Creating...
          module.stage1_docker_postgresql.docker_image.postgres: Still creating... [10s elapsed]
          module.stage2_docker_nginx.docker_image.nginx: Still creating... [10s elapsed]
          module.stage2_docker_nginx.docker_image.nginx: Still creating... [20s elapsed]
          module.stage1_docker_postgresql.docker_image.postgres: Still creating... [20s elapsed]
          module.stage1_docker_postgresql.docker_image.postgres: Still creating... [30s elapsed]
          module.stage2_docker_nginx.docker_image.nginx: Still creating... [30s elapsed]
          module.stage2_docker_nginx.docker_image.nginx: Still creating... [40s elapsed]
          module.stage1_docker_postgresql.docker_image.postgres: Still creating... [40s elapsed]
          module.stage2_docker_nginx.docker_image.nginx: Creation complete after 41s [id=sha256:b8c82647e8a2586145e422943ae4c69c9b1600db636e1269efd256360eb396b0nginx:alpine3.18]
          module.stage1_docker_postgresql.docker_image.postgres: Still creating... [50s elapsed]
          module.stage1_docker_postgresql.docker_image.postgres: Still creating... [1m0s elapsed]
          module.stage1_docker_postgresql.docker_image.postgres: Creation complete after 1m5s [id=sha256:eae233f106f633adc0f551b7bfb6766149fddec54458520cafa6ac849ae1b00cpostgres:16.2]

          Apply complete! Resources: 2 added, 0 changed, 0 destroyed.
</pre>

&nbsp;

---



&nbsp;

&#x1F534; If you want to display the `trace log`, you can use the following command in the apply stage of this terraform &#x1F3C3;.
<pre>
    ❯ TF_LOG_CORE=trace terraform -chdir=./TF-Module-docker-multi-image apply
</pre>

---

&nbsp;

### &#x1F530; Result.

<pre>
    ❯ docker images

        REPOSITORY   TAG          IMAGE ID       CREATED       SIZE
        postgres     16.2         eae233f106f6   6 weeks ago   453MB
        nginx        alpine3.18   b8c82647e8a2   7 weeks ago   43.6MB


    ❯ docker container list

</pre>

&nbsp;

<pre>
    ❯ terraform -chdir=./TF-Module-docker-multi-image destroy


          module.stage2_docker_nginx.docker_image.nginx: Refreshing state... [id=sha256:b8c82647e8a2586145e422943ae4c69c9b1600db636e1269efd256360eb396b0nginx:alpine3.18]
          module.stage1_docker_postgresql.docker_image.postgres: Refreshing state... [id=sha256:eae233f106f633adc0f551b7bfb6766149fddec54458520cafa6ac849ae1b00cpostgres:16.2]

          Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
            - destroy

          Terraform will perform the following actions:

            # module.stage1_docker_postgresql.docker_image.postgres will be destroyed
            - resource "docker_image" "postgres" {
                - id           = "sha256:eae233f106f633adc0f551b7bfb6766149fddec54458520cafa6ac849ae1b00cpostgres:16.2" -> null
                - image_id     = "sha256:eae233f106f633adc0f551b7bfb6766149fddec54458520cafa6ac849ae1b00c" -> null
                - keep_locally = false -> null
                - name         = "postgres:16.2" -> null
                - repo_digest  = "postgres@sha256:6b841c8f6a819884207402f1209a8116844365df15fca8cf556fc54a24c70800" -> null
              }

            # module.stage2_docker_nginx.docker_image.nginx will be destroyed
            - resource "docker_image" "nginx" {
                - id           = "sha256:b8c82647e8a2586145e422943ae4c69c9b1600db636e1269efd256360eb396b0nginx:alpine3.18" -> null
                - image_id     = "sha256:b8c82647e8a2586145e422943ae4c69c9b1600db636e1269efd256360eb396b0" -> null
                - keep_locally = false -> null
                - name         = "nginx:alpine3.18" -> null
                - repo_digest  = "nginx@sha256:31bad00311cb5eeb8a6648beadcf67277a175da89989f14727420a80e2e76742" -> null
              }

          Plan: 0 to add, 0 to change, 2 to destroy.

          Do you really want to destroy all resources?
            Terraform will destroy all your managed infrastructure, as shown above.
            There is no undo. Only 'yes' will be accepted to confirm.

            Enter a value: yes

          module.stage1_docker_postgresql.docker_image.postgres: Destroying... [id=sha256:eae233f106f633adc0f551b7bfb6766149fddec54458520cafa6ac849ae1b00cpostgres:16.2]
          module.stage2_docker_nginx.docker_image.nginx: Destroying... [id=sha256:b8c82647e8a2586145e422943ae4c69c9b1600db636e1269efd256360eb396b0nginx:alpine3.18]
          module.stage1_docker_postgresql.docker_image.postgres: Destruction complete after 1s
          module.stage2_docker_nginx.docker_image.nginx: Destruction complete after 1s

          Destroy complete! Resources: 2 destroyed.
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
