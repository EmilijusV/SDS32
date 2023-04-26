
#! /usr/bin/env bash
set -eo pipefail

if [[ -z "${STUDENT_NAME}" ]]; then
  echo "STUDENT_NAME is not set"
  exit 1
fi

# This script is used to deploy s3 bucket
STACK_NAME="${STUDENT_NAME}-s3-poems-bucket"
TEMPLATE_FILE="$(dirname "${BASH_SOURCE[0]}")/templates/s3.yml"
AWS_DEFAULT_REGION="eu-west-2"
POEMS_BUCKET_NAME="${STUDENT_NAME}-poems-bucket"

aws cloudformation deploy \
  --stack-name "${STACK_NAME}" \
  --template-file "${TEMPLATE_FILE}" \
  --capabilities CAPABILITY_IAM \
  --no-fail-on-empty-changeset \
  --tags "Project=Poems" "Environment=Dev" "StudentName=${STUDENT_NAME}"\
  --region "${AWS_DEFAULT_REGION}" \
  --parameter-overrides \
    "PoemsBucketName=${POEMS_BUCKET_NAME}" \
    "StudentName=${STUDENT_NAME}"