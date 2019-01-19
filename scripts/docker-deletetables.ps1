# Create tables for local dynamodb tables
# Prerequisites: AWS Tools for Powershell
#   Install-Module -Name AWSPowerShell
# https://aws.amazon.com/blogs/developer/creating-amazon-dynamodb-tables-with-powershell/
# DynamoDB must be running

param([string]$tablename="TestTable")

$endpoint = "http://192.168.99.100:9000"
$localMasterTable = $tablename
$region = "ap-southeast-2"

Write-Host "Deleting local $localMasterTable" -ForegroundColor "Yellow"

try {
    $removeTableResp = Remove-DDBTable -TableName $localMasterTable `
                                      -EndpointUrl $endpoint `
                                      -Region $region `
                                      -Force

    Write-Host "Removed existing local dynamoDB table $localMasterTable" -ForegroundColor "Yellow"
} catch {
    Write-Host "Cannot remove local dynamoDB table $localMasterTable" -ForegroundColor "Yellow"
}


