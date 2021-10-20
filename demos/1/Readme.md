# Demo 1

This spins up vault, and runs a second container to configure userpass auth, setup the coolcat user, and set the policy.

- docker-compose.yaml
- secret.hcl
- vault-job.dockerfile

## Docker commands

Run the compose:
`docker-compose.exe -f .\docker-compose.yaml up`

After stopping the stack run the following to clean up stopped containers:

`docker-compose.exe -f .\docker-compose.yaml down`

You may need to run the following to build the custom Jenkins and Vault images:

`docker-compose.exe -f .\docker-compose.yaml build --no-cache`

## Additional tools

Download these tools and ensure that they are in your `PATH` for easy execution

### vault

To interact with this instance of vault you will need a client on your local system. Hashicorp provides a binary that works on Windows, Mac, and Linux.
You can follow their instructions on [vaultproject.io](https://www.vaultproject.io/docs/install)

If you are on windows and have `chocolatey` or `scoop` or if you are on mac and have `brew` you can install the vault client using those tools.

`<tool> install vault`

### jq

jq is a C portable binary used for slicing and dicing json data. You can download it for your platform on [stedolan.github.io](https://stedolan.github.io/jq/download/). Most Linux package managers provide a version.

### Microsoft.PowerShell.SecretManagement

If you are using the cross platform [powershell](https://github.com/powershell/powershell) (or Windows PowerShell 5.1) you can install the Microsoft.PowerShell.SecretManagement module and the Vault Extension.

`Install-Module -Name Microsoft.PowerShell.SecretManagement`
`Install-Module -Name SecretManagement.Hashicorp.Vault.KV`

## Interacting with Vault

### Using vault & jq

Vault client provides built-in help for any command you need.

`vault`
`vault login -h`
`$env:VAULT_ADDR = 'http://127.0.0.1:8200'` or `export VAULT_ADDR='http://127.0.0.1:8200'`
`vault login -method=userpass username=coolcat`
`$API_KEY = Read-Host` or `set +o history; API_KEY='something'; set -o history`
`vault kv put secret/api_key token=$API_KEY`
`vault kv get secret/api_key | jq .data.data`

### Using Microsoft.PowerShell.SecretManagement

Registering a vault with SecretManagement requires the basic paramters:

`Register-SecretVault -ModuleName SecretManagement.Hashicorp.Vault.KV -Name secret -VaultParameters @{vaultServer='http://127.0.0.1:8200';VaultAuthType="userpass"} -Description 'CoolCat secrets'  -DefaultVault`
`$WarningPreference = 'SilentlyContinue'`
`$API_KEY = Read-Host` or `set +o history; API_KEY='something'; set -o history`
`Get-secretinfo` this will prompt you for credentials
`Set-Secret -name api_key -secret @{token=$API_KEY}`
`Get-Secret -name api_key`

## python

For the python script you will need to install the requests and hvac modules to execute the script

`pip install requests`
`pip install hvac`
