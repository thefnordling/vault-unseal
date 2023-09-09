#!/bin/bash

if [[ -z "$VAULT_ADDR" ]]; then
    echo "VAULT_ADDR env var is not set, cannot unseal"
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
    status = $(curl -s ${VAULT_ADDR}/v1/sys/seal-status | jq '.sealed')
    if [true = "$status"]
    then
        echo "Unsealing $VAULT_ADDR";
        curl -s --requst PUT --data '{"key": "'"${UNSEAL_KEY}"'"}' ${VAULT_ADDR}/v1/sys/unseal
    fi
    sleep 30
done