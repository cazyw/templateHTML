# Note: Powershell must be restarted for the addition to take effect

function Add-IEDriversToPath()
{
  Write-Host "Checking if IE Drivers need to be added to path..."

  $path1 = "C:\path1"
  $path2 = "C:\path2"
  $path3 = "C:\path3"
  $paths = $path1, $path2, $path3
  $pathsToAdd = ""

  Write-Host "Backing up current system path to C:\Temp\backup_system_path_Add-IEDriversToPath.txt"
  $env = [System.Environment]::GetEnvironmentVariable("Path", "Machine")
  if(!(Test-Path -Path "C:\Temp" )){ New-Item -ItemType directory -Path "C:\Temp" }
  $env > "C:\Temp\backup_system_path_Add-IEDriversToPath.txt"

  foreach($path in $paths) {
    Write-Host "Path to check: $path"

    if(!(Test-Path -Path $path )) {
      Write-Host "=> Warning: the path $path does not exist"
      continue
    }

    if($env -like "*$path*") {
      Write-Host "=> The path already exists"
    }
    else {
      Write-Host "=> The path must be added to the System path"
      $pathsToAdd += ";$path"
    }
  }

  if(![string]::IsNullOrEmpty($pathsToAdd)){
    Write-Host "Adding paths..."
    [System.Environment]::SetEnvironmentVariable("PATH", $Env:Path + ";$pathsToAdd", [System.EnvironmentVariableTarget]::Machine)
  }

  Write-Host "Finished checking/adding IEDrivers to path."
}

Add-IEDriversToPath

