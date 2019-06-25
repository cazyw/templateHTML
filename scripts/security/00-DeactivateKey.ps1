$settings = Get-Content ".\_Settings.json" | ConvertFrom-Json
$endpoint = $settings.endpoint

Write-Host "Deactivate a Public Key Registered with AppNexus using $endpoint"

$publicKeyId = '226'
$authTokenUserId = & ".\02-GetUserId.ps1"
$authToken = $authTokenUserId[0]
$userId = $authTokenUserId[1]

$deactivationJsonString = Get-Content ".\_DeactivateAPublicKey.json" | Out-String

$response = Invoke-WebRequest -Method PUT -Headers @{'Authorization' = $authToken } -ContentType 'application/json' -Body $deactivationJsonString -Uri "https://$endpoint/public-key?key_id=$publicKeyId&user_id=$userId"
Write-Host $response


