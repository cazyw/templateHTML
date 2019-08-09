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

Once I accidentally forgot to set my git email address and so none of the commits I made on the branch counted in my contributions! As I'd done some serious work on this branch this was extremely disappointing.

However I managed to add the email back with this command and these changes:

- THE_SHA - the commit to start making changes
- THE_AUTHOR_NAME
- THE_EMAIL_ADDRESS

```
git rebase -i THE_SHA_CODE -x "git commit --amend --author 'THE_AUTHOR_NAME <THE_EMAIL_ADDRESS>' -CHEAD"
```

This will open up vim where you can check the changes then save and exit `:wq`. This will then run through all the commits.
Then push up using `git push --force --tags origin 'refs/heads/*'`

Lifesaver!

I had looked at the Github site https://help.github.com/en/articles/changing-author-info but the commands sadly did not work for me.
