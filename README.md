# terraform-module-ansible

Terraform module to execute an ansible playbook.

## Table of contents

- [terraform-module-ansible](#terraform-module-ansible)
  - [Table of contents](#table-of-contents)
  - [Important notes and requirements for using this module](#important-notes-and-requirements-for-using-this-module)
  - [How can this module be used?](#how-can-this-module-be-used)
  - [terraform module documentation](#terraform-module-documentation)
  - [Makefile](#makefile)

## Important notes and requirements for using this module

With this module it is possible to execute an Ansible playbook. For this it is necessary that terraform and ansible are available in the `PATH`.

In order to run Ansible, some required packages are installed on the remote system with `apt`. If other operating systems are to be supported that use a different package manager, the module must be extended.

## How can this module be used?

Examples of how the module can be used can be found in the `examples` directory, such as [examples/complete/main.tf](examples/complete/main.tf).

## terraform module documentation

The module documentation can be found in the [tf-module/README.md](tf-module/README.md)

**Attention** This documentation must currently still be updated manually with the command `make gen-tf-docs`!

## Makefile

    > make
    help                 💬 This help message
    install-tools        ⚙️  Install necessary tools
    init                 🌱 Run terraform init
    validate             👁️ Run terraform validate and fmt
    tflint               👁️ Run tflint
    checkov              👁️ Run checkov
    lint                 🔍 Lint terraform manifests
    validate-examples    👁️ Validate the modules examples
    gen-tf-docs          🌱 Generate terraform docs
