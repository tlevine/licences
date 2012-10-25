# ScraperWiki Box: scraperwiki/licences #

https://box.scraperwiki.com/scraperwiki/licences

This box contains scripts to check ScraperWiki repositories on Github have
explicit licences and to apply such licences.

## How to install (on a new server) ##

    $ git clone scraperwiki.licences@box.scraperwiki.com:. licences
    $ cd licences
    $ npm install
    $ echo "export PATH=$PATH:~/node_modules/.bin" >> ~/.profile

## How to use ##

Check licences.

    $ cd licences
    $ ./check_licences_in_github.coffee

Add licences to repositories that lack them.

    $ cd licences
    $ ./add_licence_to_repository.sh git@github.com:scraperwiki/licences.git
