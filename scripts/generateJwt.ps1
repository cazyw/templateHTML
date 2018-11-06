function Generate-JWT (
    [Parameter(Mandatory = $True)]
    [ValidateSet("RS256")]
    $Algorithm = $null,
    [Parameter(Mandatory = $True)]
    $Kid = $null,
    [Parameter(Mandatory = $True)]
    [string]$Username = $null
    ){

    $iat = [int][double]::parse((Get-Date -Date $((Get-Date).ToUniversalTime()) -UFormat %s)) # Grab Unix Epoch Timestamp and add desired expiration.

    [hashtable]$header = @{alg = $Algorithm; kid = $kid}
    [hashtable]$payload = @{sub = $Username; iat = $iat}

    $headerjson = $header | ConvertTo-Json -Compress
    $payloadjson = $payload | ConvertTo-Json -Compress

    $headerjsonbase64 = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($headerjson)).Split('=')[0].Replace('+', '-').Replace('/', '_')
    $payloadjsonbase64 = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($payloadjson)).Split('=')[0].Replace('+', '-').Replace('/', '_')

    if(!(Test-Path "Keys\public_privatekey.pfx")){
      Write-Host "Error: Keys\privatekey.pem does not exist"
      Exit 0
    }

    $pwd = pwd

    # $jwt = $headerjsonbase64 + '.' + $encodedPayload # The first part of the JWT

    # $toSign = [System.Text.Encoding]::UTF8.GetBytes($jwt)

    # $cert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2("$pwd\Keys\public_privatekey.pfx")

    # $rsa = $cert.PrivateKey
    # if ($null -eq $rsa) { # Requiring the private key to be present; else cannot sign!
    #     throw "There's no private key in the supplied certificate - cannot sign"
    # }
    # else {
    #     # Overloads tested with RSACryptoServiceProvider, RSACng, RSAOpenSsl
    #     try { $sig = [Convert]::ToBase64String($rsa.SignData($toSign,[Security.Cryptography.HashAlgorithmName]::SHA256,[Security.Cryptography.RSASignaturePadding]::Pkcs1)) -replace '\+','-' -replace '/','_' -replace '=' }
    #     catch { throw "Signing with SHA256 and Pkcs1 padding failed using private key $rsa" }
    # }
    $token = "$headerjsonbase64.$payloadjsonbase64.$sig"
    $token | Out-File "$pwd\Keys\jwtToken.txt"
    Write-Host "Keys\jwtToken.txt created"


}

Generate-JWT -Algorithm 'RS256' -Kid '' -Username ''
