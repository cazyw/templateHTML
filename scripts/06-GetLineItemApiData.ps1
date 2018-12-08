$settings = Get-Content ".\_Settings.json" | ConvertFrom-Json
$endpoint = $settings.endpoint

Write-Host "Get data from Line Item API using $endpoint"
$authToken = & ".\01-GetAuthToken.ps1"

# $lineItemIds = '1234567,9876543'
$lineItemIds = '6339468'

$response = Invoke-WebRequest -Method GET -Headers @{'Authorization' = $authToken } -Uri "https://$endpoint/line-item?id=$lineItemIds"
Write-Host $response