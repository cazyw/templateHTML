$settings = Get-Content ".\_Settings.json" | ConvertFrom-Json
$username = $settings.username
$endpoint = $settings.endpoint

Write-Host "Get User ID using $endpoint"
$authToken = & ".\01-GetAuthToken.ps1"

$response = Invoke-WebRequest -Method GET -Headers @{'Authorization' = $authToken } -Uri "https://$endpoint/user?username=$username"
$json = ConvertFrom-Json $response
Write-Output $authToken
Write-Output $json.response.users.id