#!/usr/bin/env coffee
# check_licences_in_github.coffee
# Script to check the existence of licences in ScraperWiki's
# github repos.
# Run from command line.

request = require 'request'
async = require 'async'

compliant = 0
total = 0

hub = "https://raw.github.com"
username = "tlevine"

print = (status, name) ->
  prefixes = ["\x1b[31m ✗ ", "\x1b[32m ✓ ", "\x1b[33m ✓ "]
  console.log prefixes[status] + name + "\x1b[0m"
  if status > 0
    compliant += 1

check_licence = (repo, callback) ->
  check_single = (fname, cb) ->
    # (Intended to be used in async.detect)
    # *fname* is the final part of the pathname to
    # check the existence of.
    # *cb* will be called with false if the file does not exist;
    # true otherwise.
    options =
      method: 'get'
      url: "#{hub}/#{username}/#{repo.name}/master/#{fname}",
      headers:
       'User-Agent': 'HTTPie/0.5.0'
    request.get options, (err, resp) -> cb(resp.statusCode == 200)
  async.detectSeries ['LICENCE', 'LICENSE', 'LICENSE.txt'],
    check_single,
    (name) ->
      if not name?
        print 0, repo.name
        callback null, 1
      else
        if name == 'LICENCE'
          print 1, repo.name
        else
          print 2, "#{repo.name} (#{name})"
        callback null, 1

request.get "https://api.github.com/users/#{username}/repos",
  (err, resp, body) ->
    repos = JSON.parse(body)
    console.log repos
    total = repos.length
    console.log "Scanning licences for #{total} repositories..."
    async.map repos, check_licence, ->
      percentage = Math.round(compliant*100/total)
      console.log "#{username} is #{percentage}% compliant"
