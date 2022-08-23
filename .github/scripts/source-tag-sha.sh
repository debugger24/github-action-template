#!/bin/bash

repo=$1
tag_name=$2
token=$3

sha=$(
    curl -s \
        -H "Accept: application/vnd.github+json" \
        -H "Authorization: Bearer ${token}" \
        https://api.github.com/repos/${repo}/git/ref/tags/${tag_name} |
        jq '.object.sha' --raw-output
)
echo "::set-output name=sha::$sha"
