path "secret/*" { 
  capabilities = ["read","list"] 
}
path "secret/data/api_key" { 
  capabilities = ["read"] 
}
path "auth/approle/role/jenkins/role-id" {
   capabilities = [ "read" ]
}
path "auth/approle/role/jenkins/secret-id" {
   capabilities = [ "update" ]
}


