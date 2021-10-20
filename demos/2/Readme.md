# Demo 2

This spins up vault, runs a second container to setup policy, configure approle auth, and create a dummy secret, and spins up a Jenkins instance.

- docker-compose.yaml
- approle.hcl
- vault-job.dockerfile

## Docker commands

Run the compose:
`docker-compose.exe -f .\docker-compose.yaml up`

After stopping the stack run the following to clean up stopped containers:

`docker-compose.exe -f .\docker-compose.yaml down`

You may need to run the following to build the custom Jenkins and Vault images:

`docker-compose.exe -f .\docker-compose.yaml build --no-cache`

## Managing AppRoles

We are going to be using the Jenkins approle for this demo. Before we begin we will need to reauthenticate using the root token and store our secret.

`$env:VAULT_ADDR = 'http://127.0.0.1:8200'` or `export VAULT_ADDR='http://127.0.0.1:8200'`
`vault login`
`$API_KEY = Read-Host` or `set +o history; API_KEY='something'; set -o history`
`vault kv put secret/api_key token=$API_KEY`

Next we can inspect the Jenkins role and generate a secret-id

`vault read auth/approle/role/jenkins`
`vault read auth/approle/role/jenkins/role-id`
`vault write -force auth/approle/role/jenkins/secret-id`

Now we can go use that in the secret-id in our pipeline

## Further Reading

Hashicorp has an extensive library of material on best practices for setting up [CI/CD Pipelines](https://learn.hashicorp.com/tutorials/vault/approle-best-practices) and [Kubernetes](https://learn.hashicorp.com/tutorials/vault/agent-kubernetes?in=vault/auth-methods)

[Setting up Jenkins in Docker](https://dev.to/andresfmoya/install-jenkins-using-docker-compose-4cab)
[Automate Jenkins setup with Docker](https://www.digitalocean.com/community/tutorials/how-to-automate-jenkins-setup-with-docker-and-jenkins-configuration-as-code)
[Using Vault with Jenkins](https://austincloud.guru/2020/03/12/using-vault-with-jenkins/)
[Hashicorp Vault Jenkins Plugin](https://plugins.jenkins.io/hashicorp-vault-plugin/)
[PowerShell Jenkins Plugin](https://plugins.jenkins.io/powershell/)