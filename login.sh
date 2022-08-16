#!/bin/bash

function login {
    if [ -z "$FCLI_TLS_PATH" ]; then
        echo "Please define path to cert folder: export FCLI_TLS_PATH=\"/path/to/findy-wallet-pwa/tools/env/config/cert\""
        exit 1
    fi

    user="$1"
    bot_yaml="$2"
    issue="$3"

    echo "Login user $user"

    export FCLI_CONFIG="./config.yaml"

    register_res=$(findy-agent-cli authn register -u $user || "")
    if [ -z "$register_res" ]; then
        issue=
    fi
    export FCLI_JWT=$(findy-agent-cli authn login -u $user)

    cred_def_id=""
    if [ -z "$issue" ]; then
        echo "Skipping credential definition creation"
        cred_def_id=$(cat cred_def_id)
    else
        echo "Create schema"
        sch_id=$(findy-agent-cli agent create-schema \
            --name="degree" \
            --version=1.0 name date degree birthdate_dateint timestamp)

        # read schema - make sure it's found in ledger
        echo "Read schema $sch_id"
        schema=$(findy-agent-cli agent get-schema --schema-id $sch_id)

        # create cred def
        echo "Create cred def with schema id $sch_id"
        cred_def_id=$(findy-agent-cli agent create-cred-def \
            --id $sch_id --tag "$user")

        # read cred def - make sure it's found in ledger
        echo "Read cred def $cred_def_id"
        cred_def=$(findy-agent-cli agent get-cred-def --id $cred_def_id)

        echo $cred_def_id > "./cred_def_id"
    fi

    # replace cred def id in bot config
    sub_cmd='{sub("<CRED_DEF_ID>","'$cred_def_id'")}1'
    awk "$sub_cmd" "$bot_yaml.template.yaml" > $bot_yaml
}
