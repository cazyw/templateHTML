# Useful Git Commands

To view all branches including remotes

```
git branch -a
```

To view commits on a remote branch compared to the local master

```
git log --oneline master..origin/master
git log --oneline master..origin/<remote branch>
```
