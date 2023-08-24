resource "random_id" "ansible_play_id" {
  # Generate a new id each time the triggers switchs
  keepers     = var.triggers
  byte_length = 16
}

locals {
  tmp_dir_path         = "${path.root}/.terraform/tmp/${random_id.ansible_play_id.id}" # Ensure we create a new directory for each run! Workaround see also: https://github.com/hashicorp/terraform/issues/21308
  inventory_file_path  = "${local.tmp_dir_path}/hosts"
  ssh_private_key_path = "${local.tmp_dir_path}/ssh_private_key.pem"

  # Creates extra-vars string, such as: "-e key1=value1 -e key2=value2 -e key3=value3"
  extra_vars = length(var.ansible_playbook_extra_vars) > 0 ? format("-e %s", join(" -e ", [for key, value in var.ansible_playbook_extra_vars : format("%s=%s", key, value)])) : ""
}

resource "null_resource" "prepare_host_to_run_ansible" {

  triggers = var.triggers

  connection {
    type        = "ssh"
    user        = var.ansible_ssh_user
    host        = var.ansible_host
    private_key = var.ansible_ssh_private_key
  }

  # Install requirements to run ansible
  #
  # TODO Support different operating systems
  # Required packages are installed on the remote system with `apt`.
  # If other operating systems are to be supported that use a different
  # package manager, the module must be extended.
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -yy",
      "sudo apt-get install python3-setuptools python3-pip -yy",
      "sudo pip3 install httplib2"
    ]
  }
}

resource "null_resource" "apply_ansible_playbook" {

  triggers = var.triggers

  provisioner "local-exec" {
    # Create private key file
    command = <<-EOT
      set -e
      mkdir -p ${local.tmp_dir_path}
      echo "${var.ansible_ssh_private_key}" > ${local.ssh_private_key_path}
      chmod 600 ${local.ssh_private_key_path}
    EOT
  }
  provisioner "local-exec" {
    # Create ansible inventory for host
    command = <<-EOT
      set -e
      echo [${var.ansible_host_label}:vars] > ${local.inventory_file_path}
      echo ansible_ssh_user=${var.ansible_ssh_user} >> ${local.inventory_file_path}
      echo ansible_ssh_private_key_file=${local.ssh_private_key_path} >> ${local.inventory_file_path}
      echo [${var.ansible_host_label}] >> ${local.inventory_file_path}
      echo ${var.ansible_host} >> ${local.inventory_file_path}
    EOT
  }

  # Run ansible playbook (and deletes temp files after run)
  provisioner "local-exec" {
    environment = {
      ANSIBLE_HOST_KEY_CHECKING = "false"
    }
    command = <<-EOT
      set -e
      sleep ${var.waiting_time_in_secs}
      ansible-playbook -i ${local.inventory_file_path} ${var.ansible_playbook_options} ${local.extra_vars} ${var.ansible_playbook_path}
      rm "${local.inventory_file_path}" "${local.ssh_private_key_path}"
    EOT
  }

  depends_on = [null_resource.prepare_host_to_run_ansible]
}
