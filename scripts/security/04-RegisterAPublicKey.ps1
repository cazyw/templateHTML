$settings = Get-Content ".\_Settings.json" | ConvertFrom-Json
$endpoint = $settings.endpoint

Write-Host "Register a public key with AppNexus using $endpoint"

# The relevant values in .\_RegisterPublicKey must already be filled out
$registerJsonString = Get-Content ".\_RegisterPublicKey.json" | Out-String

$authTokenUserId = & ".\02-GetUserId.ps1"
$authToken = $authTokenUserId[0]
$userId = $authTokenUserId[1]

$response = Invoke-WebRequest -Method POST -Headers @{'Authorization' = $authToken } -ContentType 'application/json' -Body $registerJsonString -Uri "https://$endpoint/public-key?&user_id=$userId"
Write-Host $response

