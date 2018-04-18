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
    write-host "PS $(Convert-Path $currentDirectory)" -NoNewline -ForegroundColor Gray
    if ($isGitBranch -eq $TRUE) {
        write-host " ($(GitBranch)" -NoNewline -ForegroundColor DarkYellow

        if ($hasUpstream -ne "") {
            write-host " => $hasUpstream)" -NoNewline -ForegroundColor DarkYellow
        } else {
            write-host " => n/a)" -NoNewline -ForegroundColor DarkRed
        }
    }
    
    return "`n> "
}