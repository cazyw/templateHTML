param([Parameter(Mandatory = $true)][string] $command)

if ($command -eq "build") {
  docker build  .
}

if ($command -eq "show-images") {
  docker images
}


if ($command -eq "up") {
  docker-compose up -d
}

if ($command -eq "down") {
  docker-compose down -v --remove-orphans --rmi all
}

if ($command -eq "rm-i") {
  docker image prune -a
}

else {
  Write-Host "Enter a command"
}