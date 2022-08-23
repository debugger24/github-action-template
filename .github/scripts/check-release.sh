#!/bin/bash

repo=$1
release_version="v$2"
token=$3

echo "Checking release version ${release_version} exists or not."

exists=$(
    curl -s \
        -H "Accept: application/vnd.github+json" \
        -H "Authorization: Bearer ${token}" \
        https://api.github.com/repos/${repo}/releases/tags/${release_version} |
        jq 'has("id")'
)

if [[ "$exists" == true ]]; then
    echo "::warning title=Skipping Release::Release ${release_version} already exists. If you want to create new release please update the version in package.json"
    echo '::set-output name=release_exists::true'
else
    echo '::set-output name=release_exists::false'
fi