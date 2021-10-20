path "secret/*" { 
  capabilities = ["read","list"] 
}
path "secret/data/api_key" { 
  capabilities = ["create","read","update","delete"] 
}