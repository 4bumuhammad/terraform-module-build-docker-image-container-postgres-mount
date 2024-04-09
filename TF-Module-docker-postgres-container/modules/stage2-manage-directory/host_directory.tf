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

  # provisioner "local-exec" {
  #   command = <<-EOT
  #     if [ -n "$(find ${local.full_datatest_directory} -mindepth 1 -maxdepth 1 -type d -name 'pg_*' -print -quit)" ]; then
  #       echo "Direktori mengandung setidaknya satu folder yang dimulai dengan 'pg_' sehingga tidak diperlukan perlakukan apapun terhadap direktori tersebut."
  #     else
  #       rm -rf ${local.full_datatest_directory} && mkdir -p ${local.full_datatest_directory}
  #     fi
  #   EOT
  # }  

}