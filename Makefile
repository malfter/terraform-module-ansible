TF_ROOT_MODULE = "tf-module"

.DEFAULT_GOAL := help

.PHONE: help
help:  ## 💬 This help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

.PHONE: install-tools
install-tools: ## ⚙️  Install necessary tools
	brew install terraform-docs
	brew install tflint
	pip3 install checkov && pip3 install -U checkov

.PHONE: init
init:  ## 🌱 Run terraform init
	cd $(TF_ROOT_MODULE) && terraform version
	cd $(TF_ROOT_MODULE) && terraform init

.PHONE: validate
validate: ## 👁️  Run terraform validate and fmt
	cd $(TF_ROOT_MODULE) && terraform validate
	cd $(TF_ROOT_MODULE) && terraform fmt -list=true -write=false -diff=true -check=true -recursive

.PHONE: tflint
tflint:  ## 👁️  Run tflint
	cd $(TF_ROOT_MODULE) && tflint -c .tflint.hcl --init
	cd $(TF_ROOT_MODULE) && tflint -v
	cd $(TF_ROOT_MODULE) && tflint -c .tflint.hcl

.PHONE: checkov
checkov:  ## 👁️  Run checkov
	checkov -d $(TF_ROOT_MODULE)

.PHONE: lint
lint: validate tflint checkov  ## 🔍 Lint terraform manifests

.PHONE: validate-examples
validate-examples: ## 👁️  Validate the modules examples
	./bin/validateExamples.sh

.PHONE: gen-tf-docs
gen-tf-docs: ## 🌱 Generate terraform docs
	cd $(TF_ROOT_MODULE) && terraform-docs markdown table --output-file README.md --output-mode inject .
