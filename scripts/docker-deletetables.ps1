param([string]$tablename="TestTable")

$endpoint = "http://192.168.99.100:9000"
$sitecoreReportingMasterTable = $tablename
$region = "ap-southeast-2"

Write-Host "Deleting local $sitecoreReportingMasterTable" -ForegroundColor "Yellow"

try {
    $removeTableResp = Remove-DDBTable -TableName $sitecoreReportingMasterTable `
                                      -EndpointUrl $endpoint `
                                      -Region $region `
                                      -Force

    Write-Host "Removed existing local dynamoDB table $sitecoreReportingMasterTable" -ForegroundColor "Yellow"
} catch {
    Write-Host "Cannot remove local dynamoDB table $sitecoreReportingMasterTable" -ForegroundColor "Yellow"
}


