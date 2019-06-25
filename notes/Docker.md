# Docker

## Docker for Windows

- https://blog.ipswitch.com/creating-your-first-windows-container-with-docker-for-windows
- https://social.technet.microsoft.com/wiki/contents/articles/38652.nano-server-getting-started-in-container-with-docker.aspx
- https://docs.microsoft.com/en-us/virtualization/windowscontainers/manage-docker/manage-windows-dockerfile#powershell-in-dockerfile

Docker for Windows (_requires Windows 10 Pro or Enterprise 64-bit_) runs both Windows and Linux Containers. If the system requirements are not met, then you can only use Docker Toolbox. Docker Toolbox only has Linux Containers.

There are two flavours, Community Edition and Enterprise Edition.

- **Images** are like a template of what programs you want run inside your container. You can create images based on an existing template.
- **Containers** are created with an image.

### Images

- create inside a `Dockerfile`
- build (`docker build`)
- run (`docker run`)

There are two base windows images: `microsoft/windowsservercore` and `microsoft/nanoserver`.

To pull an existing image to use without modification:

```Powershell
$ docker pull microsoft/nanoserver
```

Otherwise to create a docker image in a Dockerfile based on a template:

```Dockerfile
FROM openjdk:nanoserver # based on Java built on the nanoserver

# copy a script from the build machine into the container using the ADD instruction. This script is then run using the RUN instruction.

ADD script.ps1 /windows/temp/script.ps1
RUN powershell.exe -executionpolicy bypass c:\windows\temp\script.ps1

ENV chocolateyUseWindowsCompression false

RUN powershell -Command \
    iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1')); \
    choco feature disable --name showDownloadProgress

RUN powershell -NoProfile -ExecutionPolicy Bypass -Command "$env:ChocolateyUseWindowsCompression='false'; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

RUN choco install -y ie11

```

Build the docker image, giving it the friendly name `windowsimage` using the files in the current directory. The flag `-t` means name and optionally include a tag in the `name:tag` format (no tag included below).

```Powershell
$ docker build -t windowsimage .
```

This runs the docker container using the `windowsimage` image, in an interactive session, using Powershell. The flag `-it` means allocate a pseudo-TTY connected to the container’s stdin (-t) and keep stdin open and interactive (-i).

```Powershell
$ docker run -it windowsimage powershell
```

You can also mount a directory into a docker image. This is used to run files inside this sandboxed docker container. The image sets up the 'base' programs/environment (like an OS) and the volume contains the files to manipulate/run.

```Powershell
$ docker run -it -v /path/to/local/directory:/path/in/image -w /workingdirectoryincontainer nameofimage

# for windows, use windows paths
$ docker run -it -v c:\foo:d:\somedir -w d:\somedir nameofimage

```

To copy the PowerShell script `HelloWorld.ps1` created previously into the NanoServer container:

```Powershell
docker cp -a C:\Temp\HelloWorld.ps1 HelloNanoServerWorld:/HelloWorld.ps1
```

## Docker on Bash for Windows (Ubuntu)

Docker by itself cannot be run on its own in Windows Bash. It can however be run in conjunction with Docker on Windows. In this way, the docker engine is running on Windows and you are connecting to it via bash.

### On Windows 10:

1. Install docker on Windows 10
1. Switch to Linux Containers
1. Expose the daemon

- select `expose daemon on tcp://localhost:2375 without TLS` or if not using Docker for Windows, configure the docker daemon with `-H tcp://0.0.0.0:2375 and --tlsverify=false` (also see https://docs.docker.com/config/daemon/#configure-the-docker-daemon)

### On WSL (Ubuntu)

Install docker with these commands. Make sure to install via this link and install docker-ce otherwise you may run into tls oversized issues

```
# Install packages to allow apt to use a repository over HTTPS
$ sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
# Add Docker's official GPG key
$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# Set up the repository
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
# Update source lists
sudo apt-get update
# Install Docker
sudo apt-get install docker-ce
```

Ensure Volume Mounts Work

When using WSL, Docker for Windows expects you to supply your volume paths in a format that matches this: `/c/something/…`.

However WSL mounts the file system as `/mnt/c/something/…`

In order to change the behaviour, you can configure it to mount on `/` instead of `/mnt`

Using Windows 18.03, modify the configuration file

```
sudo nano /etc/wsl.conf
# Now make it look like this and save the file when you're done:
[automount]
root = /
options = "metadata"
```

Reboot your computer.

Now you're ready to use docker in WSL

## Docker Issues

Windows 10 with docker-toolbox installed.

Running `docker ps` or trying to pull any images results in the following error:

_error during connect: Get https://192.168.99.100:2376/v1.37/containers/json: dial tcp 192.168.99.100:2376: connectex: A connection attempt failed because the connected party did not properly respond after a period of time, or established connection failed because connected host has failed to respond._

Running `docker-machine ls` shows the machine is stopped (confirmed in Oracle VM VirtualBox).

Run

```powershell
docker-machine start default
```
