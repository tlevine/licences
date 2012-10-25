# ScraperWiki Box: scraperwiki/licences #

https://box.scraperwiki.com/scraperwiki/licences

This box contains scripts to check ScraperWiki repositories on Github have explicit licences.

## How to install (on a new server) ##

    $ git clone scraperwiki.licences@box.scraperwiki.com:. licences
    $ cd licences
    $ npm install
    $ echo "export PATH=$PATH:~/node_modules/.bin" >> ~/.profile

## How to use ##

    $ cd licences
    $ ./check_licences_in_github.coffee