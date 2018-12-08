$settings = Get-Content ".\_Settings.json" | ConvertFrom-Json
$username = $settings.username
$password = $settings.password
$endpoint = $settings.endpoint

$body =  '{"auth":{"username":"' + $username + '","password":"' + $password + '"}}'

Write-Host "Get auth token using username and password using $endpoint"
$response = Invoke-WebRequest -Method POST -Uri "https://$endpoint/auth" -Body $body
$token = ConvertFrom-Json $response
Write-Output $token.response.token
