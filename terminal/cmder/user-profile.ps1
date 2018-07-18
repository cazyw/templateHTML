
#############################################################
# This is the modification script for Powershell in Cmder
# Place the file (user-profile.ps1) in the \config folder
#
# This willdisplay the git branch status
#
############################################################


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
        if ($hasUpstream -ne "") {
            if(git status --porcelain){
                # not clean
                write-host " ($(GitBranch)" -NoNewline -ForegroundColor Red
                write-host " => $hasUpstream)" -NoNewline -ForegroundColor Red
            }
            else {
                # tree is clean
                write-host " ($(GitBranch)" -NoNewline -ForegroundColor Cyan
                write-host " => $hasUpstream)" -NoNewline -ForegroundColor Cyan
            }
        } else {
            write-host " ($(GitBranch)" -NoNewline -ForegroundColor Cyan
            write-host " => n/a)" -NoNewline -ForegroundColor Red
        }
    }
}


[ScriptBlock]$PrePrompt = {}

[ScriptBlock]$CmderPrompt = {
    Microsoft.PowerShell.Utility\Write-Host
    promptCheck
    return " "
}

[ScriptBlock]$PostPrompt = {}
