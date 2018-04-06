# Helpful tips and code

## Vim

* `i` to insert (edit)
* ```Ctrl + V``` to select the whole line
* ```d``` to yank (cut) the line
* ```:wq``` to save and exit

## Git

* `git rebase -i` to edit / squash commits
* `git branch -d <branch>` to delete a local branch

## IIS (Internet Information Services)

This is very useful in order to create a web server / website hosted locally 

1. Start IIS Manager with `inetmgr`
1. Add a website
1. Add site name and host and path to physical file
1. Set bindings to 127.0.0.1
1. Running a local static site:
    * .NET CLR version: No Managed Code
    * Managed Pipeline mode: Classic
    * Advanced Settings (Identity): LocalSystem
1. Running a networked .NET site:
     * .NET CLR version: .NET CLR v4.0
    * Managed Pipeline mode: Integrated
    * Advanced Settings (Identity): NetworkService   
1. Update the hosts file (C:\Windows\System32\drivers\etc) to include the IP address and host domain