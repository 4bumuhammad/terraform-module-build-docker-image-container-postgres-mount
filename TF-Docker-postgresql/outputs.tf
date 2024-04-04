output "docker_container_name" {
  value = "HI, INI OUTPUT KU = ${docker_container.postgres.name}"
}

output "datatest_directory_output" {
  value = "${local.full_datatest_directory}"
}