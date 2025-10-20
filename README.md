# eks

## local macbook setup

- target aws account

- aws cli

    ```sh
    curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
    sudo installer -pkg AWSCLIV2.pkg -target /
    which aws
    aws --version
    ```

- create access keys to run tf bootstrap

    ```sh
    aws configure
    # access id and key
    # region: us-east-1 [cheapest]
    # default output: json

- test aws cli

    ```sh
    aws sts get-caller-identity --no-verify-ssl
    # --no-verify-ssl required if behind proxy
    ```

- install terraform 1.13.4

    ```sh
    curl https://releases.hashicorp.com/terraform/1.13.4/terraform_1.13.4_darwin_arm64.zip -o $HOME/Downloads/terraform_1.13.4_darwin_arm64.zip
    unzip $HOME/Downloads/terraform_1.13.4_darwin_arm64.zip
    sudo mv ./terraform /usr/local/bin/

- test terraform

    ```sh
    terraform version
    ```

## bootstrap tf setup

- tf commands

    ```sh
    cd /bootstrap
    terraform init
    




