#!/usr/bin/env coffee

request = require 'request'
async = require 'async'
compliant = 0
total = 0

print = (status, name) ->
  prefixes = ["\x1b[31m ✗ ", "\x1b[32m ✓ ", "\x1b[33m ✓ "]
  console.log prefixes[status] + name + "\x1b[0m"
  if status > 0
    compliant = compliant + 1

check_licence = (repo, callback) ->
  request.get "https://raw.github.com/scraperwiki/" + repo.name + '/master/LICENCE', (err, resp, body) ->
    if resp.statusCode == 200
      print(1, repo.name)
      callback(null, 1)
    else
      request.get "https://raw.github.com/scraperwiki/" + repo.name + '/master/LICENSE', (err, resp, body) ->
        if resp.statusCode == 200
          print(2, repo.name + ' (LICENSE)')
          callback(null, 1)
        else
          request.get "https://raw.github.com/scraperwiki/" + repo.name + '/master/LICENSE.txt', (err, resp, body) ->
            if resp.statusCode == 200
              print(2, repo.name + ' (LICENSE.txt)')
            else
              print(0, repo.name)
            callback(null, 1)

request.get "https://api.github.com/orgs/scraperwiki/repos", (err, resp, body) ->
  repos = JSON.parse(body)
  total = repos.length
  console.log "Scanning licences for " + total + " repositories..."
  async.map repos, check_licence, (err, results) ->
    console.log "ScraperWiki is " + Math.round(compliant*100/total) + "% compliant"