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
    ❯ terraform -chdir=./TF-Module-docker-postgres-container fmt -recursive

    ❯ terraform -chdir=./TF-Module-docker-postgres-container validate

            Success! The configuration is valid.
</pre>

&nbsp;

<pre>
    ❯ terraform -chdir=./TF-Module-docker-postgres-container plan


</pre>

&nbsp;

<pre>
    ❯ terraform -chdir=./TF-Module-docker-postgres-container apply -auto-approve



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


    ❯ docker container list

</pre>

&nbsp;

<pre>
    ❯ terraform -chdir=./TF-Module-docker-postgres-container destroy



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
