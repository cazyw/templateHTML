
#Import-Module 'C:\tools\poshgit\dahlbyk-posh-git-a4faccd\src\posh-git.psd1'
$ErrorActionPreference= 'continue'

$gitLoaded = $false
function Import-Git($Loaded){
    if($Loaded) { return }
    $GitModule = Get-Module -Name Posh-Git -ListAvailable
    if($GitModule | select version | where version -le ([version]"0.6.1.20160330")){
        Import-Module Posh-Git > $null
    }
    if(-not ($GitModule) ) {
        write-host ""
    }
    # Make sure we only run once by alawys returning true
    return $true
}


function InGitRepo($checkDir) {
    $checkGitFolder = $checkDir + "\.git"
    if ((Test-Path $checkGitFolder) -eq $TRUE) {
        return $TRUE
    }
    $parentDir = $(Get-Item $checkDir).parent.fullname
    if ($parentDir -eq $NULL) {
        return $FALSE
    }
    InGitRepo($parentDir)
}

function GitBranch {
    $currentBranch = ""
    git branch | foreach {
        if ($_ -match "^\* (.*)") {
            $currentBranch += $matches[1]
        }
    }
    return $currentBranch
}

function RemoteTracking {
    $remoteBranch = ""
    $remoteBranch += git for-each-ref --format='%(upstream:short)' $(git symbolic-ref -q HEAD)
    return $remoteBranch
}

function promptCheck {
    $currentDirectory = $(Get-Location)

    $isGitBranch = $(InGitRepo((Convert-Path $currentDirectory)))
    $hasUpstream = RemoteTracking

    # Convert-Path needed for pure UNC-locations
    write-host "$(Convert-Path $currentDirectory)" -NoNewline -ForegroundColor Yellow
    if ($isGitBranch -eq $TRUE) {
        write-host " ($(GitBranch)" -NoNewline -ForegroundColor Yellow

        if ($hasUpstream -ne "") {
            write-host " => $hasUpstream)" -NoNewline -ForegroundColor Yellow
        } else {
            write-host " => n/a)" -NoNewline -ForegroundColor Red
        }
    }

    return ""
}

[ScriptBlock]$Prompt = {
    $realLASTEXITCODE = $LASTEXITCODE
    $host.UI.RawUI.WindowTitle = Microsoft.PowerShell.Management\Split-Path $pwd.ProviderPath -Leaf
    Microsoft.PowerShell.Utility\Write-Host -NoNewline
    promptCheck
    Microsoft.PowerShell.Utility\Write-Host "`nλ " -NoNewLine -ForegroundColor "DarkGray"
    $global:LASTEXITCODE = $realLASTEXITCODE
    return " "
}
