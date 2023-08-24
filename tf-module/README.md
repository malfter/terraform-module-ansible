<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.2 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 3.2 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_null"></a> [null](#provider\_null) | 3.2.1 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.5.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [null_resource.apply_ansible_playbook](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.prepare_host_to_run_ansible](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [random_id.ansible_play_id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ansible_host"></a> [ansible\_host](#input\_ansible\_host) | (Required) Host on which the playbook is to be run. | `string` | n/a | yes |
| <a name="input_ansible_host_label"></a> [ansible\_host\_label](#input\_ansible\_host\_label) | (Required) Label used for assigning the variables to the `ansible_host` | `string` | n/a | yes |
| <a name="input_ansible_playbook_extra_vars"></a> [ansible\_playbook\_extra\_vars](#input\_ansible\_playbook\_extra\_vars) | (Optional) Pass extra variables to the ansible playbook (`--extra-vars='KEY=VALUE'`). | `map(string)` | `{}` | no |
| <a name="input_ansible_playbook_options"></a> [ansible\_playbook\_options](#input\_ansible\_playbook\_options) | (Optional) Set options to pass to ansible-playbook command, such as `--tags=install,config`. | `string` | `""` | no |
| <a name="input_ansible_playbook_path"></a> [ansible\_playbook\_path](#input\_ansible\_playbook\_path) | (Required) Path to the ansible playbook to run | `string` | n/a | yes |
| <a name="input_ansible_ssh_private_key"></a> [ansible\_ssh\_private\_key](#input\_ansible\_ssh\_private\_key) | (Required) Ansible SSH Private Key of `ansible_ssh_user` | `string` | n/a | yes |
| <a name="input_ansible_ssh_user"></a> [ansible\_ssh\_user](#input\_ansible\_ssh\_user) | (Required) Ansible SSH User | `string` | n/a | yes |
| <a name="input_triggers"></a> [triggers](#input\_triggers) | (Optional) Triggers for the re-execution of the playbook, if the content of the triggers changes, the playbook is executed again. | `map(string)` | <pre>{<br>  "rerun": "once"<br>}</pre> | no |
| <a name="input_waiting_time_in_secs"></a> [waiting\_time\_in\_secs](#input\_waiting\_time\_in\_secs) | (Optional) Waiting time before running the playbook | `number` | `5` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ansible_play_id"></a> [ansible\_play\_id](#output\_ansible\_play\_id) | New id each time the triggers switchs and the ansible playbook is executed. |
| <a name="output_null_resource_ids"></a> [null\_resource\_ids](#output\_null\_resource\_ids) | List of all null\_resource ids created in this module. |
<!-- END_TF_DOCS -->