# C:\Users\<User>\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1

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

function prompt {
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

    return "`n>> "
}
# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
