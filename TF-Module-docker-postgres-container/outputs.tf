output "stage1_docker_postgresql_filtered_docker_images_output" {
  value = module.stage1_docker_postgresql.filtered_docker_images_output
}

output "stage2_manage_directory_full_datatest_directory_output" {
  value = module.stage2_manage_directory.manage_directory_output
}

output "stage3_docker_container_filtered_docker_container_output" {
  value = module.stage3_docker_container.filtered_docker_container_output
}