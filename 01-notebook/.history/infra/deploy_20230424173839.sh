#!/bin/bash
# Put your deployment kick off script actions here

if [! aws sts get-caller-identity]; then
    echo >&2 "aws creds not working"
    exit 2
fi
