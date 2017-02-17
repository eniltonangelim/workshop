# Processo de desenvolvimento colaborativo com GIT
---

## O projeto X

~~$~~ git init

```text
Initialized empty Git repository in /tmp/projetoX/.git/
```

~~$~~ touch README.md && git add .

~~$~~ git commit -m "Initial commit" 

```text
[master (root-commit) d48fc88] Initial commit
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 README.md
```

~~$~~ git log

```
commit d48fc888bd8c9854036690177143f6e2b69e7b19
Author: Enilton Angelim <enilton@f13.com.br>
Date:   Fri Feb 17 13:02:05 2017 -0300

    Initial commit
```

~~$~~ git remote add origin ssh://git@gitlab.f13.com.br:7222/Angelim/projetoX.git  

~~$~~ git remote -v  
```text
origin	ssh://git@gitlab.f13.com.br:7222/Angelim/projetoX.git (fetch)
origin	ssh://git@gitlab.f13.com.br:7222/Angelim/projetoX.git (push)
```

~~$~~ git push -u origin master

```text
git push -u origin master
Counting objects: 3, done.
Writing objects: 100% (3/3), 215 bytes | 0 bytes/s, done.
Total 3 (delta 0), reused 0 (delta 0)
To ssh://git@gitlab.f13.com.br:7222/Angelim/projetoX.git
 * [new branch]      master -> master
Branch master set up to track remote branch master from origin.
```

### Os primeiros impedimentos

Duas linhas de trabalho modificam um componente na mesma versão

~~$~~ git push -u origin master

```text
To ssh://git@gitlab.f13.com.br:7222/Angelim/projetoX.git
 ! [rejected]        master -> master (fetch first)
error: failed to push some refs to 'ssh://git@gitlab.f13.com.br:7222/Angelim/projetoX.git'
dica: Updates were rejected because the remote contains work that you do
dica: not have locally. This is usually caused by another repository pushing
dica: to the same ref. You may want to first integrate the remote changes
dica: (e.g., 'git pull ...') before pushing again.
dica: See the 'Note about fast-forwards' in 'git push --help' for details.
```

~~$~~ git pull

```text
remote: Counting objects: 3, done.
remote: Compressing objects: 100% (2/2), done.
remote: Total 3 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
From ssh://gitlab.f13.com.br:7222/Angelim/projetoX
   d48fc88..727d6b0  master     -> origin/master
Updating d48fc88..727d6b0
error: Your local changes to the following files would be overwritten by merge:
	README.md
Please, commit your changes or stash them before you can merge.
Aborting
```

~~$~~ git stash

```text
Saved working directory and index state WIP on master: d48fc88 Initial commit
HEAD is now at d48fc88 Initial commit
```

~~$~~ git stash show

```text
README.md | 5 +++++
1 file changed, 5 insertions(+)
```

~~$~~ git pull

```text
Updating d48fc88..727d6b0
Fast-forward
 README.md | 79 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)
```

~~$~~ git stash list

```text
stash@{0}: WIP on master: 727d6b0 Update README.md
stash@{1}: WIP on master: d48fc88 Initial commit
```

~~$~~ git stash pop stash@{0}

```text
No ramo master
Your branch is up-to-date with 'origin/master'.
Changes not staged for commit:
  (utilize "git add <arquivo>..." para atualizar o que será submetido)
  (utilize "git checkout -- <arquivo>..." para descartar mudanças no diretório de trabalho)

	modified:   README.md

nenhuma modificação adicionada à submissão (utilize "git add" e/ou "git commit -a")
Dropped stash@{0} (a9aed02e7ce79f0b6b2ebf33bd86c280f31d8f86)
```

~~$~~  git commit -a -m "stash change

```text
[master d061c29] stash change
 1 file changed, 9 insertions(+), 1 deletion(-)
```

~~$~~ git push -u origin master

```text
Counting objects: 3, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (2/2), done.
Writing objects: 100% (3/3), 389 bytes | 0 bytes/s, done.
Total 3 (delta 1), reused 0 (delta 0)
To ssh://git@gitlab.f13.com.br:7222/Angelim/projetoX.git
   727d6b0..d061c29  master -> master
Branch master set up to track remote branch master from origin.
```

## Branches

Master:

~~$~~ git branch 

```text
* master
```

hotfix:

~~$~~ git branch hotfix

develop:

~~$~~ git branch develop

issues:

~~$~~ git checkout -b iss#1 develop



## Workflow

```text
             Release v1.0.0                                      Release v1.1.0                             Release v1.1.1 
            º--------------                                     º--------------                            º---------------
master:  --(*)-------------------------------------------------[*]-----------------(-)-------------------[*]---->
            \                                                  /                    \                    /
             \                                                /                      \                  / 
hotfix:  -----\----------------------------------------------/-----------------------(o)--------------(o)
               \                                            /                                           \
develop:  º----[*]-------(o)---------[o]------------[o]----(o)------------------------------------------(*)----------------> 
                 \ Is#1   \          /              /                                                    |
issues:           º--------\-------(o)-------------/---------->                                          |
                            \ Is#2                /                                                      |
                             º------------------(o)----------->                                          |
                                                                                                        /º\
                                                                                                      .-m-m-.
                                                                                                      : ??? :
                                                                                                      .......
```

Master:

~~$~~ git tag -a -m 'version 1.0.0' v1.0.0  
~~$~~ git commit -a -m 'release 1.0.0'  
~~$~~ git push origin master

```text
Counting objects: 1520, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (1302/1302), done.
Writing objects: 100% (1520/1520), 48.38 MiB | 5.42 MiB/s, done.
Total 1520 (delta 234), reused 0 (delta 0)
To ssh://git@gitlab.f13.com.br:7222/Angelim/projetoX.git
   d061c29..a0b137d  master -> master
```

~~$~~ git push --tags origin master

```text
Counting objects: 1, done.
Writing objects: 100% (1/1), 165 bytes | 0 bytes/s, done.
Total 1 (delta 0), reused 0 (delta 0)
To ssh://git@gitlab.f13.com.br:7222/Angelim/projetoX.git
 * [new tag]         v1.0.0 -> v1.0.0
```


Master -> develop

~~$~~ git pull

```text
Already up-to-date.
```

~~$~~ git checkout -b develop master

git branch

```text
 git branch
  develop
  hotfix
  iss#1
* master
```

git checkout develop

```text
Switched to branch 'develop'
```

git merge --no-ff master

```text
Merge made by the 'recursive' strategy.
 bin/2to3                                            |    1 +
 bin/2to3-2.7                                        |    5 +
 bin/2to3-3.5                                        |    5 +
 bin/411toppm                                        |  Bin 0 -> 10392 bytes
 bin/GET                                             |    1 +
 create mode 120000 bin/2to3
 create mode 100755 bin/2to3-2.7
 create mode 100755 bin/2to3-3.5
 create mode 100755 bin/411toppm
 create mode 120000 bin/GET
```
