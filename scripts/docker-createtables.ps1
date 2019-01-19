# Create tables for local dynamodb tables
# Prerequisites: AWS Tools for Powershell
#   Install-Module -Name AWSPowerShell
# https://aws.amazon.com/blogs/developer/creating-amazon-dynamodb-tables-with-powershell/
# DynamoDB must be running

param([string]$tablename="TestTable")

$endpoint = "http://192.168.99.100:9000"
$localMasterTable = $tablename
$region = "ap-southeast-2"

Write-Host "Setting up local database table" -ForegroundColor "Yellow"

$tableSchema = New-DDBTableSchema `
            | Add-DDBKeySchema -KeyName "Id" -KeyType "HASH" -KeyDataType "S" `
            | Add-DDBKeySchema -KeyName "Name" -KeyType "RANGE" -KeyDataType "S" `
            | Add-DDBIndexSchema -Global `
                        -IndexName "NameId" `
                        -HashKeyName "Name" `
                        -RangeKeyName "Id" `
                        -HashKeyDataType "S" `
                        -ProjectionType "ALL" `
                        -ReadCapacity 5 `
                        -WriteCapacity 5
try {
    Write-Host "Removing existing local dynamoDB table $localMasterTable" -ForegroundColor "Yellow"
    $removeTableResp = Remove-DDBTable -TableName $localMasterTable `
                                      -EndpointUrl $endpoint `
                                      -Region $region `
                                      -Force

    Write-Host "Removed existing local dynamoDB table $localMasterTable" -ForegroundColor "Green"
} catch {
    Write-Host "Cannot remove local dynamoDB table $localMasterTable / Table doesn't exist" -ForegroundColor "Yellow"
}

Write-Host "Creating local dynamoDB table $localMasterTable" -ForegroundColor "Yellow"
$createTableResp = New-DDBTable -TableName $localMasterTable `
                                -Schema $tableSchema `
                                -ReadCapacity  5 `
                                -WriteCapacity 5 `
                                -EndpointUrl $endpoint `
                                -Region $region
                                Write-Host "Created local dynamoDB table $localMasterTable" -ForegroundColor "Green"

