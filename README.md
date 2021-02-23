## How to deploy

Setup:
* [Install Terraform](https://www.terraform.io/intro/getting-started/install.html)
* Setup your credentials via [AWS Provider](https://www.terraform.io/docs/providers/aws/index.html#access_key)
* [Run Three Tier Init with the corresponding env value to setup terraform backend with s3 bucket ]


Run commands to deploy:
* ```export env=dev (or prod)```
* ```terraform get -update=true```
* ```terraform init -backend-config=config/backend-${env}.conf -backend=true```
* ```terraform apply -var-file=config/${env}.tfvars -var password=<db password> -lock=true```

