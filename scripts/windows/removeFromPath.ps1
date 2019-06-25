# Note: Powershell must be restarted for the removal to take effect

function Remove-IEDriversFromPath()
{
  Write-Host "Checking if IE Drivers need to be removed from the path..."

  $path1 = "C:\"
  $path2 = "C:\"
  $path3 = "C:\"
  $paths = $path1, $path2, $path3

  Write-Host "Backing up current system path to C:\Temp\backup_system_path_Remove-IEDriversFromPath.txt"
  $env = [System.Environment]::GetEnvironmentVariable("Path", "Machine")
  if(!(Test-Path -Path "C:\Temp" )){ New-Item -ItemType directory -Path "C:\Temp" }
  $env > "C:\Temp\backup_system_path_Remove-IEDriversFromPath.txt"

  foreach($path in $paths) {
    Write-Host "Path to check: $path"

    if($env -like "*$path*") {
      Write-Host "=> The path must be removed from the System path"
      $env = ($env.Split(';') | Where-Object { $_ -ne $path }) -join ';'
    }
    else {
      Write-Host "=> The path is not in the System path"
    }
  }

  Write-Host "Updating system path..."
  [System.Environment]::SetEnvironmentVariable("PATH", $env, [System.EnvironmentVariableTarget]::Machine)

  Write-Host "Finished checking/removing IEDrivers from path."
}

Remove-IEDriversFromPath

