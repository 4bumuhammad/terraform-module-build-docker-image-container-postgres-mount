# TF-Module-docker-postgres-container

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
  ❯ tree -L 4 -a -I 'README.md|.DS_Store|.terraform|*.hcl|*.tfstate|*.tfstate.backup' ./TF-Module-docker-postgres-container

        ├── main.tf
        ├── modules
        │   ├── stage1-docker-postgresql
        │   │   ├── docker_images.tf
        │   │   └── variables.tf
        │   ├── stage2-manage-directory
        │   │   ├── get_home.sh
        │   │   ├── host_directory.tf
        │   │   ├── outputs.tf
        │   │   └── variables.tf
        │   └── stage3-docker-container
        │       └── variables.tf
        ├── outputs.tf
        └── variables.tf

        4 directories, 10 files
</pre>

&nbsp;

### &#x1F530; TERRAFORM STAGES :

&nbsp;

Check the response on the terraform registry endpoint so that the provider can be used.

<pre>GET https://registry.terraform.io/.well-known/terraform.json HTTP/1.1</pre>

Output :
<pre>
        HTTP/1.1 200 OK
        Content-Type: application/json
        Content-Length: 65
        Connection: close
        Date: Thu, 04 Apr 2024 23:56:27 GMT
        Accept-Ranges: bytes
        Cache-Control: public, max-age=3600, stale-if-error=31536000
        Content-Encoding: gzip
        Content-Security-Policy: default-src 'self'; script-src 'self' 'unsafe-inline' https://www.google-analytics.com https://cdn.segment.com https://unpkg.com/@segment/consent-manager@5.6.0/standalone/consent-manager.js https://www.googletagmanager.com https://a.optnmstr.com; style-src 'self' 'unsafe-inline' https://maxcdn.bootstrapcdn.com https://fonts.googleapis.com https://p.typekit.net https://use.typekit.net; img-src 'self' data: https: https://www.google-analytics.com; font-src 'self' https://maxcdn.bootstrapcdn.com https://fonts.googleapis.com https://fonts.gstatic.com https://use.typekit.net; connect-src 'self' https://www.google-analytics.com https://*.launchdarkly.com https://api.segment.io https://cdn.segment.com https://sentry.io https://api.omappapi.com https://api.opmnstr.com https://api.optmnstr.com https://*.algolia.net https://*.algolianet.com https://app.terraform.io https://app.staging.terraform.io https://api.github.com/emojis
        Feature-Policy: 
        Last-Modified: Thu, 04 Apr 2024 15:15:08 GMT
        Referrer-Policy: no-referrer-when-downgrade
        Server: terraform-registry/1f8d7856cc0fb21a3d6f922c7332a9c4c708fc4a
        Strict-Transport-Security: max-age=31536000; includeSubDomains; preload
        X-Content-Type-Options: nosniff
        X-Frame-Options: DENY
        X-Xss-Protection: 1; mode=block
        Vary: Accept-Encoding
        X-Cache: Hit from cloudfront
        Via: 1.1 8890f821f2766635a0bf9c35769eb6d6.cloudfront.net (CloudFront)
        X-Amz-Cf-Pop: MAA50-P1
        X-Amz-Cf-Id: 6hH2ldLbKGM0kif8TnxPiSMIPqPzkAwxk32F2XLad3nWm4D6OwGqQQ==
        Age: 2851

        {
        "modules.v1": "/v1/modules/",
        "providers.v1": "/v1/providers/"
        }
</pre>

&nbsp;

If the endpoint does not get a 200 response, it will certainly get the following error message :

<pre>
    could not retrieve the list of available versions for provider kreuzwerker/docker: 
    could not connect to registry.terraform.io: failed to request discovery  document: 
    get "https://registry.terraform.io/.well-known/terraform.json": net/http: request canceled while waiting for connection (client.timeout exceeded while awaiting headers)
</pre>

&nbsp;

&nbsp;

&nbsp;

Continue the stage :

<pre>
    ❯ terraform -chdir=./TF-Module-docker-postgres-container init



            Initializing the backend...
            Initializing modules...

            Initializing provider plugins...
            - Reusing previous version of kreuzwerker/docker from the dependency lock file
            - Reusing previous version of hashicorp/null from the dependency lock file
            - Reusing previous version of hashicorp/local from the dependency lock file
            - Reusing previous version of hashicorp/external from the dependency lock file
            - Using previously-installed hashicorp/local v2.5.1
            - Using previously-installed hashicorp/external v2.3.3
            - Using previously-installed kreuzwerker/docker v3.0.2
            - Using previously-installed hashicorp/null v3.2.2

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
    ❯ terraform -chdir=./TF-Module-docker-postgres-container fmt -recursive

    ❯ terraform -chdir=./TF-Module-docker-postgres-container validate

            Success! The configuration is valid.
</pre>

&nbsp;

<pre>
    ❯ terraform -chdir=./TF-Module-docker-postgres-container plan -var-file=./secret.tfvars


            module.stage1_docker_postgresql.docker_image.postgres: Refreshing state... [id=sha256:eae233f106f633adc0f551b7bfb6766149fddec54458520cafa6ac849ae1b00cpostgres:16.2]
            module.stage1_docker_postgresql.null_resource.docker_images: Refreshing state... [id=5454064902483260768]
            module.stage1_docker_postgresql.null_resource.delete_file: Refreshing state... [id=3147859060886429459]
            module.stage2_manage_directory.null_resource.manage_directory: Refreshing state... [id=8975305476001092292]
            module.stage2_manage_directory.null_resource.delete_file: Refreshing state... [id=5588112569879045775]
            module.stage3_docker_container.docker_container.postgres: Refreshing state... [id=37d2b7e9a447588e3aa7cefa1b4f8c1d80cbdf0c66af0511f459291fd847b58f]
            module.stage3_docker_container.null_resource.docker_container: Refreshing state... [id=5102093903259329118]
            module.stage3_docker_container.null_resource.delete_file: Refreshing state... [id=7902632343668636758]

            Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
            + create
            -/+ destroy and then create replacement
            <= read (data resources)

            Terraform will perform the following actions:

            # module.stage1_docker_postgresql.data.local_file.docker_images_result will be read during apply
            # (depends on a resource or a module with changes pending)
            <= data "local_file" "docker_images_result" {
                + content              = (known after apply)
                + content_base64       = (known after apply)
                + content_base64sha256 = (known after apply)
                + content_base64sha512 = (known after apply)
                + content_md5          = (known after apply)
                + content_sha1         = (known after apply)
                + content_sha256       = (known after apply)
                + content_sha512       = (known after apply)
                + filename             = "modules/stage1-docker-postgresql/docker_image_results.txt"
                + id                   = (known after apply)
                }

            # module.stage1_docker_postgresql.docker_image.postgres will be created
            + resource "docker_image" "postgres" {
                + id           = (known after apply)
                + image_id     = (known after apply)
                + keep_locally = false
                + name         = "postgres:16.2"
                + repo_digest  = (known after apply)
                }

            # module.stage1_docker_postgresql.null_resource.delete_file must be replaced
            -/+ resource "null_resource" "delete_file" {
                ~ id       = "3147859060886429459" -> (known after apply)
                ~ triggers = { # forces replacement
                    ~ "always_run"   = "2024-04-09T15:34:07Z" -> (known after apply)
                        # (1 unchanged element hidden)
                    }
                }

            # module.stage1_docker_postgresql.null_resource.docker_images must be replaced
            -/+ resource "null_resource" "docker_images" {
                ~ id       = "5454064902483260768" -> (known after apply)
                ~ triggers = { # forces replacement
                    ~ "always_run"   = "2024-04-09T15:34:07Z" -> (known after apply)
                        # (1 unchanged element hidden)
                    }
                }

            # module.stage2_manage_directory.data.external.get_home_path will be read during apply
            # (depends on a resource or a module with changes pending)
            <= data "external" "get_home_path" {
                + id      = (known after apply)
                + program = [
                    + "sh",
                    + "modules/stage2-manage-directory/get_home.sh",
                    ]
                + result  = (known after apply)
                }

            # module.stage2_manage_directory.data.local_file.manage_directory_result will be read during apply
            # (depends on a resource or a module with changes pending)
            <= data "local_file" "manage_directory_result" {
                + content              = (known after apply)
                + content_base64       = (known after apply)
                + content_base64sha256 = (known after apply)
                + content_base64sha512 = (known after apply)
                + content_md5          = (known after apply)
                + content_sha1         = (known after apply)
                + content_sha256       = (known after apply)
                + content_sha512       = (known after apply)
                + filename             = "modules/stage2-manage-directory/manage_directory_results.txt"
                + id                   = (known after apply)
                }

            # module.stage2_manage_directory.null_resource.delete_file must be replaced
            -/+ resource "null_resource" "delete_file" {
                ~ id       = "5588112569879045775" -> (known after apply)
                ~ triggers = { # forces replacement
                    ~ "always_run"   = "2024-04-09T15:34:07Z" -> (known after apply)
                        # (1 unchanged element hidden)
                    }
                }

            # module.stage2_manage_directory.null_resource.manage_directory must be replaced
            -/+ resource "null_resource" "manage_directory" {
                ~ id       = "8975305476001092292" -> (known after apply)
                ~ triggers = { # forces replacement
                    ~ "always_run"   = "2024-04-09T15:34:07Z" -> (known after apply)
                        # (1 unchanged element hidden)
                    }
                }

            # module.stage3_docker_container.data.local_file.docker_container_result will be read during apply
            # (depends on a resource or a module with changes pending)
            <= data "local_file" "docker_container_result" {
                + content              = (known after apply)
                + content_base64       = (known after apply)
                + content_base64sha256 = (known after apply)
                + content_base64sha512 = (known after apply)
                + content_md5          = (known after apply)
                + content_sha1         = (known after apply)
                + content_sha256       = (known after apply)
                + content_sha512       = (known after apply)
                + filename             = "modules/stage3-docker-container/docker_container_results.txt"
                + id                   = (known after apply)
                }

            # module.stage3_docker_container.docker_container.postgres will be created
            + resource "docker_container" "postgres" {
                + attach                                      = false
                + bridge                                      = (known after apply)
                + command                                     = (known after apply)
                + container_logs                              = (known after apply)
                + container_read_refresh_timeout_milliseconds = 15000
                + entrypoint                                  = (known after apply)
                + env                                         = (sensitive value)
                + exit_code                                   = (known after apply)
                + hostname                                    = (known after apply)
                + id                                          = (known after apply)
                + image                                       = "postgres:16.2"
                + init                                        = (known after apply)
                + ipc_mode                                    = (known after apply)
                + log_driver                                  = (known after apply)
                + logs                                        = false
                + memory                                      = 512
                + must_run                                    = true
                + name                                        = "Terraform-postgres"
                + network_data                                = (known after apply)
                + read_only                                   = false
                + remove_volumes                              = true
                + restart                                     = "no"
                + rm                                          = false
                + runtime                                     = (known after apply)
                + security_opts                               = (known after apply)
                + shm_size                                    = (known after apply)
                + start                                       = true
                + stdin_open                                  = false
                + stop_signal                                 = (known after apply)
                + stop_timeout                                = (known after apply)
                + tty                                         = false
                + wait                                        = false
                + wait_timeout                                = 60

                + ports {
                    + external = 5432
                    + internal = 5432
                    + ip       = "0.0.0.0"
                    + protocol = "tcp"
                    }

                + volumes {
                    + container_path = "/var/lib/postgresql/data"
                    + host_path      = (known after apply)
                    }
                }

            # module.stage3_docker_container.null_resource.delete_file must be replaced
            -/+ resource "null_resource" "delete_file" {
                ~ id       = "7902632343668636758" -> (known after apply)
                ~ triggers = { # forces replacement
                    ~ "always_run"   = "2024-04-09T15:34:08Z" -> (known after apply)
                        # (1 unchanged element hidden)
                    }
                }

            # module.stage3_docker_container.null_resource.docker_container must be replaced
            -/+ resource "null_resource" "docker_container" {
                ~ id       = "5102093903259329118" -> (known after apply)
                ~ triggers = { # forces replacement
                    ~ "always_run"   = "2024-04-09T15:34:07Z" -> (known after apply)
                        # (1 unchanged element hidden)
                    }
                }

            Plan: 8 to add, 0 to change, 6 to destroy.

            Changes to Outputs:
            ~ stage1_docker_postgresql_filtered_docker_images_output   = &lt;&lt;-EOT
                    REPORTS
                    Trigger Name: trigger-docker-images
                    Result docker image filter :  postgres        16.2    eae233f106f6    2024-02-21 07:46:13 +0700 WIB   453MB
                    Timestamp: Tue Apr  9 22:34:07 WIB 2024
                EOT -> (known after apply)
            ~ stage2_manage_directory_full_datatest_directory_output   = &lt;&lt;-EOT
                    REPORTS
                    Trigger Name: trigger-manage-directory
                    Directory info: The directory contains at least one folder starting with 'pg_' so no treatment of the directory is required.
                    Path Directory: /Users/powercommerce/Documents/test/docker-mount/postgres-test/
                    Size Directory:  38M
                    Timestamp: Tue Apr  9 22:34:07 WIB 2024
                EOT -> (known after apply)
            ~ stage3_docker_container_filtered_docker_container_output = &lt;&lt;-EOT
                    REPORTS
                    Trigger Name: trigger-docker-container
                    Data directory: /Users/powercommerce/Documents/test/docker-mount/postgres-test/
                    Timestamp: Tue Apr  9 22:34:08 WIB 2024
                EOT -> (known after apply)

            ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

            Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
</pre>

&nbsp;

<pre>
    ❯ terraform -chdir=./TF-Module-docker-postgres-container apply -auto-approve -var-file=./secret.tfvars



                module.stage1_docker_postgresql.docker_image.postgres: Refreshing state... [id=sha256:eae233f106f633adc0f551b7bfb6766149fddec54458520cafa6ac849ae1b00cpostgres:16.2]
                module.stage1_docker_postgresql.null_resource.docker_images: Refreshing state... [id=5454064902483260768]
                module.stage1_docker_postgresql.null_resource.delete_file: Refreshing state... [id=3147859060886429459]
                module.stage2_manage_directory.null_resource.manage_directory: Refreshing state... [id=8975305476001092292]
                module.stage2_manage_directory.null_resource.delete_file: Refreshing state... [id=5588112569879045775]
                module.stage3_docker_container.docker_container.postgres: Refreshing state... [id=37d2b7e9a447588e3aa7cefa1b4f8c1d80cbdf0c66af0511f459291fd847b58f]
                module.stage3_docker_container.null_resource.docker_container: Refreshing state... [id=5102093903259329118]
                module.stage3_docker_container.null_resource.delete_file: Refreshing state... [id=7902632343668636758]

                Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
                + create
                -/+ destroy and then create replacement
                <= read (data resources)

                Terraform will perform the following actions:

                # module.stage1_docker_postgresql.data.local_file.docker_images_result will be read during apply
                # (depends on a resource or a module with changes pending)
                <= data "local_file" "docker_images_result" {
                    + content              = (known after apply)
                    + content_base64       = (known after apply)
                    + content_base64sha256 = (known after apply)
                    + content_base64sha512 = (known after apply)
                    + content_md5          = (known after apply)
                    + content_sha1         = (known after apply)
                    + content_sha256       = (known after apply)
                    + content_sha512       = (known after apply)
                    + filename             = "modules/stage1-docker-postgresql/docker_image_results.txt"
                    + id                   = (known after apply)
                    }

                # module.stage1_docker_postgresql.docker_image.postgres will be created
                + resource "docker_image" "postgres" {
                    + id           = (known after apply)
                    + image_id     = (known after apply)
                    + keep_locally = false
                    + name         = "postgres:16.2"
                    + repo_digest  = (known after apply)
                    }

                # module.stage1_docker_postgresql.null_resource.delete_file must be replaced
                -/+ resource "null_resource" "delete_file" {
                    ~ id       = "3147859060886429459" -> (known after apply)
                    ~ triggers = { # forces replacement
                        ~ "always_run"   = "2024-04-09T15:34:07Z" -> (known after apply)
                            # (1 unchanged element hidden)
                        }
                    }

                # module.stage1_docker_postgresql.null_resource.docker_images must be replaced
                -/+ resource "null_resource" "docker_images" {
                    ~ id       = "5454064902483260768" -> (known after apply)
                    ~ triggers = { # forces replacement
                        ~ "always_run"   = "2024-04-09T15:34:07Z" -> (known after apply)
                            # (1 unchanged element hidden)
                        }
                    }

                # module.stage2_manage_directory.data.external.get_home_path will be read during apply
                # (depends on a resource or a module with changes pending)
                <= data "external" "get_home_path" {
                    + id      = (known after apply)
                    + program = [
                        + "sh",
                        + "modules/stage2-manage-directory/get_home.sh",
                        ]
                    + result  = (known after apply)
                    }

                # module.stage2_manage_directory.data.local_file.manage_directory_result will be read during apply
                # (depends on a resource or a module with changes pending)
                <= data "local_file" "manage_directory_result" {
                    + content              = (known after apply)
                    + content_base64       = (known after apply)
                    + content_base64sha256 = (known after apply)
                    + content_base64sha512 = (known after apply)
                    + content_md5          = (known after apply)
                    + content_sha1         = (known after apply)
                    + content_sha256       = (known after apply)
                    + content_sha512       = (known after apply)
                    + filename             = "modules/stage2-manage-directory/manage_directory_results.txt"
                    + id                   = (known after apply)
                    }

                # module.stage2_manage_directory.null_resource.delete_file must be replaced
                -/+ resource "null_resource" "delete_file" {
                    ~ id       = "5588112569879045775" -> (known after apply)
                    ~ triggers = { # forces replacement
                        ~ "always_run"   = "2024-04-09T15:34:07Z" -> (known after apply)
                            # (1 unchanged element hidden)
                        }
                    }

                # module.stage2_manage_directory.null_resource.manage_directory must be replaced
                -/+ resource "null_resource" "manage_directory" {
                    ~ id       = "8975305476001092292" -> (known after apply)
                    ~ triggers = { # forces replacement
                        ~ "always_run"   = "2024-04-09T15:34:07Z" -> (known after apply)
                            # (1 unchanged element hidden)
                        }
                    }

                # module.stage3_docker_container.data.local_file.docker_container_result will be read during apply
                # (depends on a resource or a module with changes pending)
                <= data "local_file" "docker_container_result" {
                    + content              = (known after apply)
                    + content_base64       = (known after apply)
                    + content_base64sha256 = (known after apply)
                    + content_base64sha512 = (known after apply)
                    + content_md5          = (known after apply)
                    + content_sha1         = (known after apply)
                    + content_sha256       = (known after apply)
                    + content_sha512       = (known after apply)
                    + filename             = "modules/stage3-docker-container/docker_container_results.txt"
                    + id                   = (known after apply)
                    }

                # module.stage3_docker_container.docker_container.postgres will be created
                + resource "docker_container" "postgres" {
                    + attach                                      = false
                    + bridge                                      = (known after apply)
                    + command                                     = (known after apply)
                    + container_logs                              = (known after apply)
                    + container_read_refresh_timeout_milliseconds = 15000
                    + entrypoint                                  = (known after apply)
                    + env                                         = (sensitive value)
                    + exit_code                                   = (known after apply)
                    + hostname                                    = (known after apply)
                    + id                                          = (known after apply)
                    + image                                       = "postgres:16.2"
                    + init                                        = (known after apply)
                    + ipc_mode                                    = (known after apply)
                    + log_driver                                  = (known after apply)
                    + logs                                        = false
                    + memory                                      = 512
                    + must_run                                    = true
                    + name                                        = "Terraform-postgres"
                    + network_data                                = (known after apply)
                    + read_only                                   = false
                    + remove_volumes                              = true
                    + restart                                     = "no"
                    + rm                                          = false
                    + runtime                                     = (known after apply)
                    + security_opts                               = (known after apply)
                    + shm_size                                    = (known after apply)
                    + start                                       = true
                    + stdin_open                                  = false
                    + stop_signal                                 = (known after apply)
                    + stop_timeout                                = (known after apply)
                    + tty                                         = false
                    + wait                                        = false
                    + wait_timeout                                = 60

                    + ports {
                        + external = 5432
                        + internal = 5432
                        + ip       = "0.0.0.0"
                        + protocol = "tcp"
                        }

                    + volumes {
                        + container_path = "/var/lib/postgresql/data"
                        + host_path      = (known after apply)
                        }
                    }

                # module.stage3_docker_container.null_resource.delete_file must be replaced
                -/+ resource "null_resource" "delete_file" {
                    ~ id       = "7902632343668636758" -> (known after apply)
                    ~ triggers = { # forces replacement
                        ~ "always_run"   = "2024-04-09T15:34:08Z" -> (known after apply)
                            # (1 unchanged element hidden)
                        }
                    }

                # module.stage3_docker_container.null_resource.docker_container must be replaced
                -/+ resource "null_resource" "docker_container" {
                    ~ id       = "5102093903259329118" -> (known after apply)
                    ~ triggers = { # forces replacement
                        ~ "always_run"   = "2024-04-09T15:34:07Z" -> (known after apply)
                            # (1 unchanged element hidden)
                        }
                    }

                Plan: 8 to add, 0 to change, 6 to destroy.

                Changes to Outputs:
                ~ stage1_docker_postgresql_filtered_docker_images_output   = &lt;&lt;-EOT
                        REPORTS
                        Trigger Name: trigger-docker-images
                        Result docker image filter :  postgres        16.2    eae233f106f6    2024-02-21 07:46:13 +0700 WIB   453MB
                        Timestamp: Tue Apr  9 22:34:07 WIB 2024
                    EOT -> (known after apply)
                ~ stage2_manage_directory_full_datatest_directory_output   = &lt;&lt;-EOT
                        REPORTS
                        Trigger Name: trigger-manage-directory
                        Directory info: The directory contains at least one folder starting with 'pg_' so no treatment of the directory is required.
                        Path Directory: /Users/powercommerce/Documents/test/docker-mount/postgres-test/
                        Size Directory:  38M
                        Timestamp: Tue Apr  9 22:34:07 WIB 2024
                    EOT -> (known after apply)
                ~ stage3_docker_container_filtered_docker_container_output = &lt;&lt;-EOT
                        REPORTS
                        Trigger Name: trigger-docker-container
                        Data directory: /Users/powercommerce/Documents/test/docker-mount/postgres-test/
                        Timestamp: Tue Apr  9 22:34:08 WIB 2024
                    EOT -> (known after apply)
                module.stage3_docker_container.null_resource.delete_file: Destroying... [id=7902632343668636758]
                module.stage3_docker_container.null_resource.delete_file: Destruction complete after 0s
                module.stage3_docker_container.null_resource.docker_container: Destroying... [id=5102093903259329118]
                module.stage3_docker_container.null_resource.docker_container: Destruction complete after 0s
                module.stage2_manage_directory.null_resource.delete_file: Destroying... [id=5588112569879045775]
                module.stage2_manage_directory.null_resource.delete_file: Destruction complete after 0s
                module.stage2_manage_directory.null_resource.manage_directory: Destroying... [id=8975305476001092292]
                module.stage2_manage_directory.null_resource.manage_directory: Destruction complete after 0s
                module.stage1_docker_postgresql.null_resource.delete_file: Destroying... [id=3147859060886429459]
                module.stage1_docker_postgresql.null_resource.delete_file: Destruction complete after 0s
                module.stage1_docker_postgresql.null_resource.docker_images: Destroying... [id=5454064902483260768]
                module.stage1_docker_postgresql.null_resource.docker_images: Destruction complete after 0s
                module.stage1_docker_postgresql.docker_image.postgres: Creating...
                module.stage1_docker_postgresql.docker_image.postgres: Still creating... [10s elapsed]
                module.stage1_docker_postgresql.docker_image.postgres: Still creating... [20s elapsed]
                module.stage1_docker_postgresql.docker_image.postgres: Still creating... [30s elapsed]
                module.stage1_docker_postgresql.docker_image.postgres: Still creating... [40s elapsed]
                module.stage1_docker_postgresql.docker_image.postgres: Still creating... [50s elapsed]
                module.stage1_docker_postgresql.docker_image.postgres: Creation complete after 57s [id=sha256:d4ffc32b30ba1f80294a3aa127db06a7b3bbbd6024e338fc572bcaa94e8e5845postgres:16.2]
                module.stage1_docker_postgresql.null_resource.docker_images: Creating...
                module.stage1_docker_postgresql.null_resource.docker_images: Provisioning with 'local-exec'...
                module.stage1_docker_postgresql.null_resource.docker_images (local-exec): Executing: ["/bin/sh" "-c" "      echo \"REPORTS\" > modules/stage1-docker-postgresql/docker_image_results.txt\n      echo \"  Trigger Name: trigger-docker-images\" &gt;&gt; modules/stage1-docker-postgresql/docker_image_results.txt\n      echo \"  Result docker image filter : \"| tr '\\n' ' ' &gt;&gt; modules/stage1-docker-postgresql/docker_image_results.txt && docker images --format '{{.Repository}}\\t{{.Tag}}\\t{{.ID}}\\t{{.CreatedAt}}\\t{{.Size}}' | grep -E 'postgres|16.2' &gt;&gt; modules/stage1-docker-postgresql/docker_image_results.txt\n      echo \"  Timestamp: $(date)\" &gt;&gt; modules/stage1-docker-postgresql/docker_image_results.txt\n"]
                module.stage1_docker_postgresql.null_resource.docker_images: Creation complete after 0s [id=4272794329741421283]
                module.stage1_docker_postgresql.data.local_file.docker_images_result: Reading...
                module.stage1_docker_postgresql.data.local_file.docker_images_result: Read complete after 0s [id=4da35db96b3e446945578851a3c0e56b31dea6ed]
                module.stage1_docker_postgresql.null_resource.delete_file: Creating...
                module.stage1_docker_postgresql.null_resource.delete_file: Provisioning with 'local-exec'...
                module.stage1_docker_postgresql.null_resource.delete_file (local-exec): Executing: ["bash" "-c" "rm -f modules/stage1-docker-postgresql/docker_image_results.txt"]
                module.stage1_docker_postgresql.null_resource.delete_file: Creation complete after 0s [id=1709162432822607664]
                module.stage2_manage_directory.data.external.get_home_path: Reading...
                module.stage2_manage_directory.data.external.get_home_path: Read complete after 0s [id=-]
                module.stage2_manage_directory.null_resource.manage_directory: Creating...
                module.stage2_manage_directory.null_resource.manage_directory: Provisioning with 'local-exec'...
                module.stage2_manage_directory.null_resource.manage_directory (local-exec): Executing: ["/bin/sh" "-c" "echo \"REPORTS\" > modules/stage2-manage-directory/manage_directory_results.txt\necho \"  Trigger Name: trigger-manage-directory\" &gt;&gt; modules/stage2-manage-directory/manage_directory_results.txt\nif [ -n \"$(find /Users/powercommerce/Documents/test/docker-mount/postgres-test/ -mindepth 1 -maxdepth 1 -type d -name 'pg_*' -print -quit)\" ]; then\n  echo \"  Directory info: The directory contains at least one folder starting with 'pg_' so no treatment of the directory is required.\" &gt;&gt; modules/stage2-manage-directory/manage_directory_results.txt\nelse\n  rm -rf /Users/powercommerce/Documents/test/docker-mount/postgres-test/ && mkdir -p /Users/powercommerce/Documents/test/docker-mount/postgres-test/\n  echo \"  Directory info: A new directory is created to create the specified directory or replace the previous one.\" &gt;&gt; modules/stage2-manage-directory/manage_directory_results.txt\nfi\necho \"  Path Directory: /Users/powercommerce/Documents/test/docker-mount/postgres-test/\" &gt;&gt; modules/stage2-manage-directory/manage_directory_results.txt\necho \"  Size Directory: \"| tr '\\n' ' ' &gt;&gt; modules/stage2-manage-directory/manage_directory_results.txt && du -sh /Users/powercommerce/Documents/test/docker-mount/postgres-test/ | cut -f1 | awk '{$1=$1};1' &gt;&gt; modules/stage2-manage-directory/manage_directory_results.txt\necho \"  Timestamp: $(date)\" &gt;&gt; modules/stage2-manage-directory/manage_directory_results.txt\n"]
                module.stage2_manage_directory.null_resource.manage_directory: Creation complete after 0s [id=6494376074876062410]
                module.stage2_manage_directory.data.local_file.manage_directory_result: Reading...
                module.stage2_manage_directory.data.local_file.manage_directory_result: Read complete after 0s [id=95c5518a6556e7ebd4e92320796cb9a6ce92672a]
                module.stage2_manage_directory.null_resource.delete_file: Creating...
                module.stage2_manage_directory.null_resource.delete_file: Provisioning with 'local-exec'...
                module.stage2_manage_directory.null_resource.delete_file (local-exec): Executing: ["bash" "-c" "rm -f modules/stage2-manage-directory/manage_directory_results.txt"]
                module.stage2_manage_directory.null_resource.delete_file: Creation complete after 0s [id=1824161325513092477]
                module.stage3_docker_container.docker_container.postgres: Creating...
                module.stage3_docker_container.docker_container.postgres: Creation complete after 1s [id=f26cc78a59b30b56d8983a3c6ae8d25411f54305bb97e081bd3ba8c2d6752f5e]
                module.stage3_docker_container.null_resource.docker_container: Creating...
                module.stage3_docker_container.null_resource.docker_container: Provisioning with 'local-exec'...
                module.stage3_docker_container.null_resource.docker_container (local-exec): Executing: ["/bin/sh" "-c" "      echo \"REPORTS\" > modules/stage3-docker-container/docker_container_results.txt\n      echo \"  Trigger Name: trigger-docker-container\" &gt;&gt; modules/stage3-docker-container/docker_container_results.txt\n      echo \"  Data directory: /Users/powercommerce/Documents/test/docker-mount/postgres-test/\" &gt;&gt; modules/stage3-docker-container/docker_container_results.txt\n      echo \"  Timestamp: $(date)\" &gt;&gt; modules/stage3-docker-container/docker_container_results.txt\n"]
                module.stage3_docker_container.null_resource.docker_container: Creation complete after 0s [id=1322279308833061087]
                module.stage3_docker_container.data.local_file.docker_container_result: Reading...
                module.stage3_docker_container.data.local_file.docker_container_result: Read complete after 0s [id=fdec5aafc94f925d001e52e65feae833431a8b2c]
                module.stage3_docker_container.null_resource.delete_file: Creating...
                module.stage3_docker_container.null_resource.delete_file: Provisioning with 'local-exec'...
                module.stage3_docker_container.null_resource.delete_file (local-exec): Executing: ["bash" "-c" "rm -f modules/stage3-docker-container/docker_container_results.txt"]
                module.stage3_docker_container.null_resource.delete_file: Creation complete after 0s [id=3303924249606419232]

                Apply complete! Resources: 8 added, 0 changed, 6 destroyed.

                Outputs:

                stage1_docker_postgresql_filtered_docker_images_output = &lt;&lt;EOT
                REPORTS
                Trigger Name: trigger-docker-images
                Result docker image filter :  postgres        16.2    d4ffc32b30ba    2024-02-21 07:46:13 +0700 WIB   453MB
                Timestamp: Fri Apr 12 06:49:17 WIB 2024

                EOT
                stage2_manage_directory_full_datatest_directory_output = &lt;&lt;EOT
                REPORTS
                Trigger Name: trigger-manage-directory
                Directory info: The directory contains at least one folder starting with 'pg_' so no treatment of the directory is required.
                Path Directory: /Users/powercommerce/Documents/test/docker-mount/postgres-test/
                Size Directory:  38M
                Timestamp: Fri Apr 12 06:49:17 WIB 2024

                EOT
                stage3_docker_container_filtered_docker_container_output = &lt;&lt;EOT
                REPORTS
                Trigger Name: trigger-docker-container
                Data directory: /Users/powercommerce/Documents/test/docker-mount/postgres-test/
                Timestamp: Fri Apr 12 06:49:17 WIB 2024

                EOT
</pre>

&nbsp;

---



&nbsp;

&#x1F534; If you want to display the `trace log`, you can use the following command in the apply stage of this terraform &#x1F3C3;.
<pre>
    ❯ TF_LOG_CORE=trace terraform -chdir=./TF-Module-docker-postgres-container apply -var-file=./secret.tfvars

    # or 

    ❯ TF_LOG_CORE=trace terraform -chdir=./TF-Module-docker-postgres-container apply --auto-approve -var-file=./secret.tfvars
</pre>

---

&nbsp;

### &#x1F530; Result.

<pre>
    ❯ docker images

        REPOSITORY   TAG       IMAGE ID       CREATED       SIZE
        postgres     16.2      eae233f106f6   6 weeks ago   453MB


    ❯ docker container list

        CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
</pre>

&nbsp;

<pre>
    ❯ terraform -chdir=./TF-Module-docker-postgres-container destroy -auto-approve  -var-file=./secret.tfvars


                module.stage1_docker_postgresql.docker_image.postgres: Refreshing state... [id=sha256:d4ffc32b30ba1f80294a3aa127db06a7b3bbbd6024e338fc572bcaa94e8e5845postgres:16.2]
                module.stage1_docker_postgresql.null_resource.docker_images: Refreshing state... [id=4272794329741421283]
                module.stage1_docker_postgresql.null_resource.delete_file: Refreshing state... [id=1709162432822607664]
                module.stage2_manage_directory.null_resource.manage_directory: Refreshing state... [id=6494376074876062410]
                module.stage2_manage_directory.null_resource.delete_file: Refreshing state... [id=1824161325513092477]
                module.stage3_docker_container.docker_container.postgres: Refreshing state... [id=f26cc78a59b30b56d8983a3c6ae8d25411f54305bb97e081bd3ba8c2d6752f5e]
                module.stage3_docker_container.null_resource.docker_container: Refreshing state... [id=1322279308833061087]
                module.stage3_docker_container.null_resource.delete_file: Refreshing state... [id=3303924249606419232]

                Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
                - destroy

                Terraform will perform the following actions:

                # module.stage1_docker_postgresql.docker_image.postgres will be destroyed
                - resource "docker_image" "postgres" {
                    - id           = "sha256:d4ffc32b30ba1f80294a3aa127db06a7b3bbbd6024e338fc572bcaa94e8e5845postgres:16.2" -> null
                    - image_id     = "sha256:d4ffc32b30ba1f80294a3aa127db06a7b3bbbd6024e338fc572bcaa94e8e5845" -> null
                    - keep_locally = false -> null
                    - name         = "postgres:16.2" -> null
                    - repo_digest  = "postgres@sha256:37a21462f4b4efb16c41b53af4fd31898fa322332a044d730e65bcc0a1ae6a5f" -> null
                    }

                # module.stage1_docker_postgresql.null_resource.delete_file will be destroyed
                - resource "null_resource" "delete_file" {
                    - id       = "1709162432822607664" -> null
                    - triggers = {
                        - "always_run"   = "2024-04-11T23:49:17Z"
                        - "trigger_name" = "trigger-delete-file"
                        } -> null
                    }

                # module.stage1_docker_postgresql.null_resource.docker_images will be destroyed
                - resource "null_resource" "docker_images" {
                    - id       = "4272794329741421283" -> null
                    - triggers = {
                        - "always_run"   = "2024-04-11T23:49:17Z"
                        - "trigger_name" = "trigger-docker-images"
                        } -> null
                    }

                # module.stage2_manage_directory.null_resource.delete_file will be destroyed
                - resource "null_resource" "delete_file" {
                    - id       = "1824161325513092477" -> null
                    - triggers = {
                        - "always_run"   = "2024-04-11T23:49:17Z"
                        - "trigger_name" = "trigger-delete-file"
                        } -> null
                    }

                # module.stage2_manage_directory.null_resource.manage_directory will be destroyed
                - resource "null_resource" "manage_directory" {
                    - id       = "6494376074876062410" -> null
                    - triggers = {
                        - "always_run"   = "2024-04-11T23:49:17Z"
                        - "trigger_name" = "trigger-manage-directory"
                        } -> null
                    }

                # module.stage3_docker_container.docker_container.postgres will be destroyed
                - resource "docker_container" "postgres" {
                    - attach                                      = false -> null
                    - command                                     = [
                        - "postgres",
                        ] -> null
                    - container_read_refresh_timeout_milliseconds = 15000 -> null
                    - cpu_shares                                  = 0 -> null
                    - dns                                         = [] -> null
                    - dns_opts                                    = [] -> null
                    - dns_search                                  = [] -> null
                    - entrypoint                                  = [
                        - "docker-entrypoint.sh",
                        ] -> null
                    - env                                         = (sensitive value) -> null
                    - group_add                                   = [] -> null
                    - hostname                                    = "f26cc78a59b3" -> null
                    - id                                          = "f26cc78a59b30b56d8983a3c6ae8d25411f54305bb97e081bd3ba8c2d6752f5e" -> null
                    - image                                       = "sha256:d4ffc32b30ba1f80294a3aa127db06a7b3bbbd6024e338fc572bcaa94e8e5845" -> null
                    - init                                        = false -> null
                    - ipc_mode                                    = "private" -> null
                    - log_driver                                  = "json-file" -> null
                    - log_opts                                    = {} -> null
                    - logs                                        = false -> null
                    - max_retry_count                             = 0 -> null
                    - memory                                      = 512 -> null
                    - memory_swap                                 = 1024 -> null
                    - must_run                                    = true -> null
                    - name                                        = "Terraform-postgres" -> null
                    - network_data                                = [
                        - {
                            - gateway                   = "172.17.0.1"
                            - global_ipv6_address       = ""
                            - global_ipv6_prefix_length = 0
                            - ip_address                = "172.17.0.2"
                            - ip_prefix_length          = 16
                            - ipv6_gateway              = ""
                            - mac_address               = "02:42:ac:11:00:02"
                            - network_name              = "bridge"
                            },
                        ] -> null
                    - network_mode                                = "default" -> null
                    - privileged                                  = false -> null
                    - publish_all_ports                           = false -> null
                    - read_only                                   = false -> null
                    - remove_volumes                              = true -> null
                    - restart                                     = "no" -> null
                    - rm                                          = false -> null
                    - runtime                                     = "runc" -> null
                    - security_opts                               = [] -> null
                    - shm_size                                    = 64 -> null
                    - start                                       = true -> null
                    - stdin_open                                  = false -> null
                    - stop_signal                                 = "SIGINT" -> null
                    - stop_timeout                                = 0 -> null
                    - storage_opts                                = {} -> null
                    - sysctls                                     = {} -> null
                    - tmpfs                                       = {} -> null
                    - tty                                         = false -> null
                    - wait                                        = false -> null
                    - wait_timeout                                = 60 -> null

                    - ports {
                        - external = 5432 -> null
                        - internal = 5432 -> null
                        - ip       = "0.0.0.0" -> null
                        - protocol = "tcp" -> null
                        }

                    - volumes {
                        - container_path = "/var/lib/postgresql/data" -> null
                        - host_path      = "/Users/powercommerce/Documents/test/docker-mount/postgres-test/" -> null
                        - read_only      = false -> null
                        }
                    }

                # module.stage3_docker_container.null_resource.delete_file will be destroyed
                - resource "null_resource" "delete_file" {
                    - id       = "3303924249606419232" -> null
                    - triggers = {
                        - "always_run"   = "2024-04-11T23:49:17Z"
                        - "trigger_name" = "trigger-delete-file"
                        } -> null
                    }

                # module.stage3_docker_container.null_resource.docker_container will be destroyed
                - resource "null_resource" "docker_container" {
                    - id       = "1322279308833061087" -> null
                    - triggers = {
                        - "always_run"   = "2024-04-11T23:49:17Z"
                        - "trigger_name" = "trigger-docker-container"
                        } -> null
                    }

                Plan: 0 to add, 0 to change, 8 to destroy.

                Changes to Outputs:
                - stage1_docker_postgresql_filtered_docker_images_output   = <<-EOT
                        REPORTS
                        Trigger Name: trigger-docker-images
                        Result docker image filter :  postgres        16.2    d4ffc32b30ba    2024-02-21 07:46:13 +0700 WIB   453MB
                        Timestamp: Fri Apr 12 06:49:17 WIB 2024
                    EOT -> null
                - stage2_manage_directory_full_datatest_directory_output   = <<-EOT
                        REPORTS
                        Trigger Name: trigger-manage-directory
                        Directory info: The directory contains at least one folder starting with 'pg_' so no treatment of the directory is required.
                        Path Directory: /Users/powercommerce/Documents/test/docker-mount/postgres-test/
                        Size Directory:  38M
                        Timestamp: Fri Apr 12 06:49:17 WIB 2024
                    EOT -> null
                - stage3_docker_container_filtered_docker_container_output = <<-EOT
                        REPORTS
                        Trigger Name: trigger-docker-container
                        Data directory: /Users/powercommerce/Documents/test/docker-mount/postgres-test/
                        Timestamp: Fri Apr 12 06:49:17 WIB 2024
                    EOT -> null
                module.stage3_docker_container.null_resource.delete_file: Destroying... [id=3303924249606419232]
                module.stage3_docker_container.null_resource.delete_file: Destruction complete after 0s
                module.stage3_docker_container.null_resource.docker_container: Destroying... [id=1322279308833061087]
                module.stage3_docker_container.null_resource.docker_container: Destruction complete after 0s
                module.stage3_docker_container.docker_container.postgres: Destroying... [id=f26cc78a59b30b56d8983a3c6ae8d25411f54305bb97e081bd3ba8c2d6752f5e]
                module.stage3_docker_container.docker_container.postgres: Destruction complete after 0s
                module.stage2_manage_directory.null_resource.delete_file: Destroying... [id=1824161325513092477]
                module.stage2_manage_directory.null_resource.delete_file: Destruction complete after 0s
                module.stage2_manage_directory.null_resource.manage_directory: Destroying... [id=6494376074876062410]
                module.stage2_manage_directory.null_resource.manage_directory: Destruction complete after 0s
                module.stage1_docker_postgresql.null_resource.delete_file: Destroying... [id=1709162432822607664]
                module.stage1_docker_postgresql.null_resource.delete_file: Destruction complete after 0s
                module.stage1_docker_postgresql.null_resource.docker_images: Destroying... [id=4272794329741421283]
                module.stage1_docker_postgresql.null_resource.docker_images: Destruction complete after 0s
                module.stage1_docker_postgresql.docker_image.postgres: Destroying... [id=sha256:d4ffc32b30ba1f80294a3aa127db06a7b3bbbd6024e338fc572bcaa94e8e5845postgres:16.2]
                module.stage1_docker_postgresql.docker_image.postgres: Destruction complete after 0s

                Destroy complete! Resources: 8 destroyed.
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
