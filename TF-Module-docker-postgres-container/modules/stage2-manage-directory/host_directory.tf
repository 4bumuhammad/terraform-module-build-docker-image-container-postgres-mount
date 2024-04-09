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
    trigger_name = "trigger-manage-directory"
  }
  provisioner "local-exec" {
    command = <<-EOT
      echo "REPORTS" > ${path.module}/manage_directory_results.txt
      echo "  Trigger Name: ${self.triggers.trigger_name}" >> ${path.module}/manage_directory_results.txt
      if [ -n "$(find ${local.full_datatest_directory} -mindepth 1 -maxdepth 1 -type d -name 'pg_*' -print -quit)" ]; then
        echo "  Directory info: The directory contains at least one folder starting with 'pg_' so no treatment of the directory is required." >> ${path.module}/manage_directory_results.txt
      else
        rm -rf ${local.full_datatest_directory} && mkdir -p ${local.full_datatest_directory}
        echo "  Directory info: A new directory is created to create the specified directory or replace the previous one." >> ${path.module}/manage_directory_results.txt
      fi
      echo "  Path Directory: ${local.full_datatest_directory}" >> ${path.module}/manage_directory_results.txt
      echo "  Size Directory: "| tr '\n' ' ' >> ${path.module}/manage_directory_results.txt && du -sh ${local.full_datatest_directory} | cut -f1 | awk '{$1=$1};1' >> ${path.module}/manage_directory_results.txt
      echo "  Timestamp: $(date)" >> ${path.module}/manage_directory_results.txt
    EOT
  }  

}

output "full_datatest_directory_output" {
  value = local.full_datatest_directory
}


data "local_file" "manage_directory_result" {
  depends_on = [null_resource.manage_directory]
  filename   = "${path.module}/manage_directory_results.txt"
}

output "manage_directory_output" {
  value = data.local_file.manage_directory_result.content
}

resource "null_resource" "delete_file" {
  triggers = {
    always_run   = "${timestamp()}"
    trigger_name = "trigger-delete-file"
  }

  depends_on = [data.local_file.manage_directory_result]

  provisioner "local-exec" {
    command = "rm -f ${path.module}/manage_directory_results.txt"
    interpreter = ["bash", "-c"]
  }
}
