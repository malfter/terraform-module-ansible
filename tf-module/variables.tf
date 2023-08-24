variable "ansible_host" {
  type        = string
  description = "(Required) Host on which the playbook is to be run."
}

variable "ansible_host_label" {
  type        = string
  description = "(Required) Label used for assigning the variables to the `ansible_host`"
}

variable "ansible_ssh_user" {
  type        = string
  description = "(Required) Ansible SSH User"
}

variable "ansible_ssh_private_key" {
  type        = string
  sensitive   = true
  description = "(Required) Ansible SSH Private Key of `ansible_ssh_user`"
}
variable "ansible_playbook_path" {
  type        = string
  description = "(Required) Path to the ansible playbook to run"
}

variable "ansible_playbook_options" {
  type        = string
  description = "(Optional) Set options to pass to ansible-playbook command, such as `--tags=install,config`."
  default     = ""
}

variable "ansible_playbook_extra_vars" {
  type        = map(string)
  description = "(Optional) Pass extra variables to the ansible playbook (`--extra-vars='KEY=VALUE'`)."
  default     = {}
}

variable "triggers" {
  type        = map(string)
  description = "(Optional) Triggers for the re-execution of the playbook, if the content of the triggers changes, the playbook is executed again."
  default = {
    rerun = "once"
  }
}

variable "waiting_time_in_secs" {
  type        = number
  description = "(Optional) Waiting time before running the playbook"
  default     = 5
}
