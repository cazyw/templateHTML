# Script to:
# - generate a private key
# - generate a public key
# - generate th x509 certificate and export as pfx
# - generate the base64string version of the x509 certificate
# 
# Prompts will appear for details (can press enter to skip)


if(!(Test-Path "Keys")){
  New-Item -ItemType "Directory" -path "Keys"
}
$pwd = pwd

Set-Location "$pwd\Keys"
Write-Host " === Creating a private key 'privatekey.pem' === "
openssl genrsa -out privatekey.pem 2048

Write-Host " === Creating a X509 certificate === "
openssl req -new -x509 -key privatekey.pem -out publickey.cer -days 1825

Write-Host " === Export your x509 certificate and private key to a pfx file 'public_privatekey.pfx' === "
openssl pkcs12 -export -out public_privatekey.pfx -inkey privatekey.pem -in publickey.cer

Write-Host " === Create public key 'publickey.pub' === "
openssl rsa -in privatekey.pem -pubout > publickey.pub

Write-Host " === Generating base64 'base64_public_privatekey.txt' === "
$pwd = pwd
$file = Get-Item "$pwd\public_privatekey.pfx"
$bytes = [System.IO.File]::ReadAllBytes($file.FullName);
$base64String = [System.Convert]::ToBase64String($bytes);
[System.IO.File]::WriteAllText("$pwd\base64_public_privatekey.txt" ,$base64string);

Set-Location ".."
Write-Host " === Completed === "