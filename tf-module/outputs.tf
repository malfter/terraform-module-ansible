output "null_resource_ids" {
  value = [
    null_resource.prepare_host_to_run_ansible.id,
    null_resource.apply_ansible_playbook.id
  ]
  description = "List of all null_resource ids created in this module."
}

output "ansible_play_id" {
  value = random_id.ansible_play_id.id
  description = "New id each time the triggers switchs and the ansible playbook is executed."
}
