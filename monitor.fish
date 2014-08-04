#!/usr/bin/env fish

function spawnTerminal --argument-names shellCommands
    osascript -e 'on run args
                    set script_command to (item 1 of args)
                    tell app "Terminal"
                      do script script_command
                    end tell
                  end run'  $shellCommands
end

set -U hostname (hostname)

switch $hostname
  case '*veg*'
  case '*cocoa*'
    spawnTerminal "cd Sites/jekyll; ./edit.rb"
    # Give Jekyll 10 seconds to load and then launch local site in browser
    fish -c "sleep 10 ; open -a Safari http://127.0.0.1:4000"&
    jekyll serve --watch --drafts --destination /Users/mcormier/Sites/weblog/
  case '*preen*'
    jekyll build --watch --drafts
end

