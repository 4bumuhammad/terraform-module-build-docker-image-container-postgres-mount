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
            - stage2_manage_directory in modules/stage2-manage-directory

            Initializing provider plugins...
            - Finding latest version of hashicorp/external...
            - Reusing previous version of kreuzwerker/docker from the dependency lock file
            - Finding latest version of hashicorp/null...
            - Installing hashicorp/external v2.3.3...
            - Installed hashicorp/external v2.3.3 (signed by HashiCorp)
            - Using previously-installed kreuzwerker/docker v3.0.2
            - Installing hashicorp/null v3.2.2...
            - Installed hashicorp/null v3.2.2 (signed by HashiCorp)

            Terraform has made some changes to the provider dependency selections recorded
            in the .terraform.lock.hcl file. Review those changes and commit them to your
            version control system if they represent changes you intended to make.

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
    ❯ terraform -chdir=./TF-Module-docker-postgres-container plan



            module.stage2_manage_directory.data.external.get_home_path: Reading...
            module.stage2_manage_directory.data.external.get_home_path: Read complete after 0s [id=-]

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

            # module.stage2_manage_directory.null_resource.manage_directory will be created
            + resource "null_resource" "manage_directory" {
                + id       = (known after apply)
                + triggers = {
                    + "always_run" = (known after apply)
                    }
                }

            Plan: 2 to add, 0 to change, 0 to destroy.

            ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

            Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
</pre>

&nbsp;

<pre>
    ❯ terraform -chdir=./TF-Module-docker-postgres-container apply -auto-approve


            module.stage2_manage_directory.data.external.get_home_path: Reading...
            module.stage2_manage_directory.data.external.get_home_path: Read complete after 0s [id=-]

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

            # module.stage2_manage_directory.null_resource.manage_directory will be created
            + resource "null_resource" "manage_directory" {
                + id       = (known after apply)
                + triggers = {
                    + "always_run" = (known after apply)
                    }
                }

            Plan: 2 to add, 0 to change, 0 to destroy.
            module.stage2_manage_directory.null_resource.manage_directory: Creating...
            module.stage2_manage_directory.null_resource.manage_directory: Creation complete after 0s [id=763768975835620873]
            module.stage1_docker_postgresql.docker_image.postgres: Creating...
            module.stage1_docker_postgresql.docker_image.postgres: Still creating... [10s elapsed]
            module.stage1_docker_postgresql.docker_image.postgres: Still creating... [20s elapsed]
            module.stage1_docker_postgresql.docker_image.postgres: Still creating... [30s elapsed]
            module.stage1_docker_postgresql.docker_image.postgres: Still creating... [40s elapsed]
            module.stage1_docker_postgresql.docker_image.postgres: Still creating... [50s elapsed]
            module.stage1_docker_postgresql.docker_image.postgres: Creation complete after 1m0s [id=sha256:eae233f106f633adc0f551b7bfb6766149fddec54458520cafa6ac849ae1b00cpostgres:16.2]

            Apply complete! Resources: 2 added, 0 changed, 0 destroyed.
</pre>

&nbsp;

---



&nbsp;

&#x1F534; If you want to display the `trace log`, you can use the following command in the apply stage of this terraform &#x1F3C3;.
<pre>
    ❯ TF_LOG_CORE=trace terraform -chdir=./TF-Module-docker-postgres-container apply
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
    ❯ terraform -chdir=./TF-Module-docker-postgres-container destroy


            module.stage2_manage_directory.null_resource.manage_directory: Refreshing state... [id=763768975835620873]
            module.stage2_manage_directory.data.external.get_home_path: Reading...
            module.stage1_docker_postgresql.docker_image.postgres: Refreshing state... [id=sha256:eae233f106f633adc0f551b7bfb6766149fddec54458520cafa6ac849ae1b00cpostgres:16.2]
            module.stage2_manage_directory.data.external.get_home_path: Read complete after 0s [id=-]

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

            # module.stage2_manage_directory.null_resource.manage_directory will be destroyed
            - resource "null_resource" "manage_directory" {
                - id       = "763768975835620873" -> null
                - triggers = {
                    - "always_run" = "2024-04-05T01:15:22Z"
                    } -> null
                }

            Plan: 0 to add, 0 to change, 2 to destroy.

            Do you really want to destroy all resources?
            Terraform will destroy all your managed infrastructure, as shown above.
            There is no undo. Only 'yes' will be accepted to confirm.

            Enter a value: yes

            module.stage2_manage_directory.null_resource.manage_directory: Destroying... [id=763768975835620873]
            module.stage2_manage_directory.null_resource.manage_directory: Destruction complete after 0s
            module.stage1_docker_postgresql.docker_image.postgres: Destroying... [id=sha256:eae233f106f633adc0f551b7bfb6766149fddec54458520cafa6ac849ae1b00cpostgres:16.2]
            module.stage1_docker_postgresql.docker_image.postgres: Destruction complete after 1s

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
