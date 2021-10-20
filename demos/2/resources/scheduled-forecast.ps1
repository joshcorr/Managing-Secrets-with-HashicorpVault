
$params = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
$params.Add('access_key',"$($env:token)")
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

$city = $($api_result.location.name)
$region = $($api_result.location.region)

$temp = $($api_result.current.temperature)
$feel_like = $($api_result.current.feelslike)
$uv_index = $($api_result.current.uv_index)

Write-Host "Current temp for $city, $region is 
`ttemp: $temp F 
`tfeels like: $feel_like F  
`tUV index: $uv_index"
