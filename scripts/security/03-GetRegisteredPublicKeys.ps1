$settings = Get-Content ".\_Settings.json" | ConvertFrom-Json
$endpoint = $settings.endpoint

Write-Host "Get public keys registered with AppNexus using $endpoint"

$authTokenUserId = & ".\02-GetUserId.ps1"
$authToken = $authTokenUserId[0]
$userId = $authTokenUserId[1]

$response = Invoke-WebRequest -Method GET -Headers @{'Authorization' = $authToken } -Uri "https://$endpoint/public-key?user_id=$userId"
$json = ConvertFrom-Json $response
Write-Host $json.response.'public-keys'
