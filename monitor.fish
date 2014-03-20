#!/usr/bin/env fish

set -U hostname (hostname)

switch $hostname
  case '*veg*'
    echo "TODO -- what port ..."
    jekyll serve --watch --drafts --destination /Users/mcormier/Sites/weblog/
  case '*preen*'
    jekyll build --watch --drafts
end

