# Findy Agency Demo

## Prerequisities

1. Setup agency to localhost according to [instructions](https://github.com/findy-network/findy-wallet-pwa/tree/dev/tools/env#agency-setup-for-local-development).
Define following environment variables:

    ```bash
    export FCLI_TLS_PATH="/path/to/findy-wallet-pwa/tools/env/config/cert"
    ```

    **OR**

1. Use cloud installation for agency. Define following environment variables:

    ```bash
    export FCLI_SERVER="agency-api.example.com:50051"
    export FCLI_TLS_PATH="/path/to/cert"
    export FCLI_ORIGIN="https://agency.example.com"
    export FCLI_URL="https://agency.example.com"
    ```

2. [Install findy-agent-cli](https://github.com/findy-network/findy-agent-cli#Installation)
3. Install qrencode

    Mac:

    ```bash
    brew install qrencode
    ```

## Alice-Faber-Acme Demo

After completing her education at Faber College, Alice is going to apply for
a job at Acme Inc.
To do this she must provide proof of education.

1. Alice registers to web wallet
    * Open web wallet with browser: <http://localhost:3000> (or cloud installation)
    * Choose unique user name for Alice and register to web wallet.
2. Alice logs in to web wallet
    * Use chosen user name and log in to web wallet.
3. Alice connects with Faber
    * Start Faber bot by running script: `./faber/run.sh`
    * Read the QR code displayed by Faber bot with web wallet
    (or copy-paste the invitation to Add connection -dialog).
4. Faber issues credential to Alice
    * Accept the credential in web wallet view.
5. Alice connects with Acme
    * Open new terminal and start Acme bot by running script: `./acme/run.sh`
    * Read the QR code displayed by Acme bot with web wallet
    (or copy-paste the invitation to Add connection -dialog).
    * Accept the proof request in web wallet view.
6. Acme verifies Alice's degree credential.
    * All done, Alice can now continue the recruitment process.
