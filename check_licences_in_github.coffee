#!/usr/bin/env coffee

request = require 'request'
async = require 'async'
compliant = 0
total = 0

check_licence = (repo, callback) ->
  request.get "https://raw.github.com/scraperwiki/" + repo.name + '/master/LICENCE', (err, resp, body) ->
    if resp.statusCode == 200
      console.log '\x1b[32m', '✓', repo.name, '\x1b[0m'
      compliant = compliant + 1
    else
      console.log '\x1b[31m', '✗', repo.name, '\x1b[0m'
    callback(null, 1)

request.get "https://api.github.com/orgs/scraperwiki/repos", (err, resp, body) ->
  repos = JSON.parse(body)
  total = repos.length
  console.log "Scanning licences for " + total + " repositories..."
  async.map repos, check_licence, (err, results) ->
    console.log "ScraperWiki is " + Math.round(compliant*100/total) + "% compliant"