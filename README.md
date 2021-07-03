# vcpkg-repo

My custom vcpkg repository of ports not present officially

## Preparation

0. Install [NodeJS + NPM](https://nodejs.org/)
1. Run these commands:
```sh
$ git clone https://github.com/julianxhokaxhiu/vcpkg-repo.git
$ npm i
```

## How to operate

0. Add your own port in `ports/`
1. Run the following commands
```sh
# First we need to commit the new port
$ git add ports/
# We create a temporary commit os we can put it in the registry correctly
$ git commit -m 'temporary'
# This script will take care of updating your versions folder reflecting any change made in ports
$ npm run postinstall
# The add the new versions changes and amend the previous commit
$ git add versions
$ git commit --amend
# Release the update
$ git push
```
