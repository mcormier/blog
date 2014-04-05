#!/usr/bin/env fish

set -U hostname (hostname)

switch $hostname
  case '*veg*'
  case '*cocoa*'
    # Give Jekyll 10 seconds to load and then launch local site in browser
    fish -c "sleep 10 ; open -a Safari http://127.0.0.1:4000"&
    jekyll serve --watch --drafts --destination /Users/mcormier/Sites/weblog/
  case '*preen*'
    jekyll build --watch --drafts
end

