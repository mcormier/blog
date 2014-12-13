#!/usr/bin/env ruby

gem 'ppcurses', '=0.1.0'
require 'ppcurses'

require 'highline/import'

def processCommand( todo  )
  cmd =  todo
  system cmd
end

def create_new_draft_file ( title )
  # get current date and put in front of filename (i.e. 2008-04-22)
  now = DateTime.now
  day_str = now.strftime("%F") 
  file_name = '_drafts/' + day_str + '-' + title.gsub(/\s/,'-') + '.md'

  isBlurbVal = ask "Blurb (Y/N)?"

  isBlurb = isBlurbVal.casecmp("Y") == 0
 
  File.open(file_name, "w") { |f|
    f.write("---\n") 
    f.write("title: " + title + "\n") 
    if isBlurb 
      f.write("layout: blurb\n") 
    else
      f.write("layout: post\n") 
      f.write("type: post\n") 
    end
    f.write("\n---\n") 
  } 

  return file_name
end

def handle_option( choice )

  case choice
  when 'Write'
    title = ask "Post Title: "
    rel_file_path = create_new_draft_file (title)
    puts "Filename is " + rel_file_path
    processCommand('vi ' + rel_file_path )
  when 'Tweak'
    processCommand('vi css/main.css index.html')
  else
    puts "INDEX not implemented !!!"
    return
  end
end

def display_menu
  @task_list = ["Write", "Tweak" ] 

  @task_menu = PPCurses::ChoiceMenu.new( @task_list )
  @task_menu.show()
  @task_menu.menu_selection()
end

screen = PPCurses::Screen.new()
screen.run { display_menu() }

if @task_menu.pressed_enter then
  handle_option( @task_menu.selected_menu_name )
end

