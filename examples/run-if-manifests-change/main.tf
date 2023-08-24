# Create (and display) a SSH key
resource "tls_private_key" "ansible_ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Ansible ssh user
locals {
  ansible_ssh_user        = "ansible"
  ansible_ssh_private_key = tls_private_key.ansible_ssh.private_key_pem
  ansible_ssh_public_key  = tls_private_key.ansible_ssh.public_key_openssh
  ansible_root_dir        = "./ansible"
  ansible_playbook_path   = "${local.ansible_root_dir}/my-playbook.yml"
}

module "run_ansible_playbook" {
  # source = "github.com/malfter/terraform-module-ansible" # TODO GitHub Release
  # version = "1.0.0"
  source = "../../tf-module"

  ansible_host            = "my-vm"
  ansible_host_label      = "my-hostgroup"
  ansible_playbook_path   = local.ansible_playbook_path
  ansible_ssh_user        = local.ansible_ssh_user
  ansible_ssh_private_key = local.ansible_ssh_private_key

  # Run only if something changed in the directory
  triggers = {
    run_if_manifests_changes = sha256(join("", [for f in fileset(local.ansible_root_dir, "**") : filesha256("${local.ansible_root_dir}/${f}")]))
  }
}

output "debug" {
  value = module.run_ansible_playbook.null_resource_ids
}
