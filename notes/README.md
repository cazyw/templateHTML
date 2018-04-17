# Helpful tips and code



## Git

Useful commands:
* `git rebase -i` to edit / squash commits
* `git branch -d <branch>` to delete a local branch
* `git push --set-upstream origin <branch name>` to set upstream branch once branch created
* `git remote prune origin --dry-run` (remove `--dry-run` to action) remove reference to remote if branch no longer exists on the remote
* `git fetch --prune` remove any remote-tracking references that no longer exist on the remote
 

Accidentally started working on something whilst on the master branch? (workflow below not using stash)

1. checkout and switch to a feature branch
1. commit the changes in the feature branch
1. switch back to master
1. pull from remote to get the latest version
1. switch to the feature branch
1. merge master into the feature branch
1. continue working on the feature branch

[Github Blog](https://blog.github.com/)
[Atlassian Git Tutorial](https://www.atlassian.com/git/tutorials)
[Github Blog on Undo](https://blog.github.com/2015-06-08-how-to-undo-almost-anything-with-git/)


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

## Javascript

[You Don't Know Series](https://github.com/getify/You-Dont-Know-JS)

## Markdown

[Markdown Cheatsheet](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet#links)

## Powershell

[Microsoft Docs](https://docs.microsoft.com/en-us/powershell/scripting/powershell-scripting?view=powershell-6)

## Sitecore

[Official Docs](http://learnsitecore.cmsuniverse.net/en/globalnavigation/sitecore-beginners-guide.aspx)

## Vim

Helpful when editing git commits in the terminal
* `i` to insert (edit)
* ```Ctrl + V``` to select the whole line
* ```d``` to yank (cut) the line
* ```:wq``` to save and exit
