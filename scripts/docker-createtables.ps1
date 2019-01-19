# https://aws.amazon.com/blogs/developer/creating-amazon-dynamodb-tables-with-powershell/

param([string]$tablename="TestTable")

$endpoint = "http://192.168.99.100:9000"
$sitecoreReportingMasterTable = $tablename
$region = "ap-southeast-2"

Write-Host "Setting up local database table" -ForegroundColor "Yellow"

$tableSchema = New-DDBTableSchema `
            | Add-DDBKeySchema -KeyName "PageViewMonthId" -KeyType "HASH" -KeyDataType "S" `
            | Add-DDBKeySchema -KeyName "SitecoreItemId" -KeyType "RANGE" -KeyDataType "S" `
            | Add-DDBIndexSchema -Global `
                        -IndexName "SitecoreItemIdPageViewMonthId" `
                        -HashKeyName "SitecoreItemId" `
                        -RangeKeyName "PageViewMonthId" `
                        -HashKeyDataType "S" `
                        -ProjectionType "ALL" `
                        -ReadCapacity 5 `
                        -WriteCapacity 5
try {
    Write-Host "Removing existing local dynamoDB table $sitecoreReportingMasterTable" -ForegroundColor "Yellow"
    $removeTableResp = Remove-DDBTable -TableName $sitecoreReportingMasterTable `
                                      -EndpointUrl $endpoint `
                                      -Region $region `
                                      -Force

    Write-Host "Removed existing local dynamoDB table $sitecoreReportingMasterTable" -ForegroundColor "Green"
} catch {
    Write-Host "Cannot remove local dynamoDB table $sitecoreReportingMasterTable / Table doesn't exist" -ForegroundColor "Yellow"
}

Write-Host "Creating local dynamoDB table $sitecoreReportingMasterTable" -ForegroundColor "Yellow"
$createTableResp = New-DDBTable -TableName $sitecoreReportingMasterTable `
                                -Schema $tableSchema `
                                -ReadCapacity  5 `
                                -WriteCapacity 5 `
                                -EndpointUrl $endpoint `
                                -Region $region
                                Write-Host "Created local dynamoDB table $sitecoreReportingMasterTable" -ForegroundColor "Green"

