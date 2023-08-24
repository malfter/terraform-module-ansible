#!/usr/bin/env bash

set -e

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
EXAMPLES_DIR="${SCRIPT_DIR}/../examples"

OLD_PWD=$(pwd)
while IFS= read -r -d '' example
do
  echo "Validate example: $(basename $example)"
  cd "$example"
  terraform init > /dev/null
  terraform validate
  terraform fmt
  cd "$OLD_PWD"
done <   <(find "${EXAMPLES_DIR}" -type d -mindepth 1 -maxdepth 1 -print0)
