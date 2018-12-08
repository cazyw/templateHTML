$settings = Get-Content ".\_Settings.json" | ConvertFrom-Json
$endpoint = $settings.endpoint

Write-Host "Get data from Creative API using $endpoint"
$authToken = & ".\01-GetAuthToken.ps1"

$creativeId = '117272854'

$response = Invoke-WebRequest -Method GET -Headers @{'Authorization' = $authToken } -Uri "https://$endpoint/creative?id=$creativeId"
Write-Host $response