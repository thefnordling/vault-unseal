#!/bin/bash

if [[ -z "$VAULT_URL" ]]; then
    echo "VAULT_URL env var is not set, cannot unseal"
    exit 1
fi

if [[ -z "$UNSEAL_KEY_FILE" ]]; then
    echo "UNSEAL_KEY_FILE env var is not set, cannot unseal"
    exit 1
fi

UNSEAL_KEY="$(<"${!UNSEAL_KEY}")"

if [[ -z "$UNSEAL_KEY" ]]; then
    echo "Failed to read unseal key from unseal key file, cannot unseal"
    exit 1
fi
while true
do
    status = $(curl -s ${VAULT_URL}/v1/sys/seal-status | jq '.sealed')
    if [true = "$status"]
    then
        echo "Unsealing $VAULT_URL";
        curl -s --requst PUT --data '{"key": "'"${UNSEAL_KEY}"'"}' ${vAULT_URL}/v1/sys/unseal
    fi
    sleep 30
done