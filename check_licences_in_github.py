#!/usr/bin/env python
# -*- coding: utf-8 -*-

import requests
import json

repos = json.loads(requests.get("https://api.github.com/orgs/scraperwiki/repos").text)
total = len(repos)
print "Scanning licences for %d repositories..." % total
done = 0
for repo in repos:
    resp = requests.get("https://raw.github.com/scraperwiki/%s/master/LICENCE" % repo['name'])
    if resp.status_code == 200:
        print '\033[32m', u'✓', repo['name'], '\033[0m'
        done = done + 1
    elif resp.status_code == 404:
        print '\033[31m', u'✗', repo['name'], '\033[0m'
    else:
        assert False

print "ScraperWiki is %d%% compliant" % (float(done)*100.0/float(total))

