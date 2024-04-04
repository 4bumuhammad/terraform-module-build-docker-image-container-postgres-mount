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



</pre>

&nbsp;

<pre>
    ❯ terraform -chdir=./TF-Module-docker-multi-image apply -auto-approve


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


    ❯ docker container list


&nbsp;

<pre>
    ❯ terraform -chdir=./TF-Module-docker-multi-image destroy

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
