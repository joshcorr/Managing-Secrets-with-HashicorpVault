#Requires -Module Microsoft.PowerShell.SecretManagement
#Requires -Module SecretManagement.Hashicorp.Vault.KV

$params = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
$params.Add('access_key',"$((Get-Secret -Name api_key -AsPlainText -Verbose).token)")
#$params.Add('access_key',"$(vault kv get -format=json secret/api_key | jq .data.data.token)")
$params.Add('query', '36.1608014,-86.7833216')
$params.Add('forcast_days','1')
$params.Add('days', '1')
$params.Add('units', 'f')

$uri = [System.UriBuilder]'http://api.weatherstack.com/forecast'
$uri.Query = $params.ToString()
$query_uri = $uri.Uri.OriginalString

$headers = @{
    'Content-Type' ='application/json'
    'Accept'='application/json'
}

$api_result = Invoke-RestMethod -Method Get -Uri $query_uri -Headers $headers

$city = $api_result.location.name
$region = $api_result.location.region

$date = $api_result.forecast.psobject.Properties.name
$avg_temp = $api_result.forecast.$date.avgtemp
$min_temp = $api_result.forecast.$date.mintemp
$max_temp = $api_result.forecast.$date.maxtemp
$uv_index = $api_result.forecast.$date.uv_index


Write-Host "Forcast for $city, $region tomorrow is 
`taverage temp: $avg_temp F 
`tminimum temp: $min_temp F 
`tmaximum temp: $max_temp F 
`tUV index: $uv_index"
