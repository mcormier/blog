#!/usr/bin/env ruby

gem 'ppcurses', '=0.0.25'
require 'ppcurses'

require 'highline/import'

class ScriptMenu < PPCurses::Menu
  attr_reader :selection
  attr_reader :pressed_enter

  def menu_selection
      while 1
        c = @win.getch

        if c == 27  # ESCAPE 
          @pressed_enter = false
          self.hide()
          break
        end

        if c == 10 # ENTER
          @pressed_enter = true
          self.hide()
          break
        end

        self.handle_menu_selection(c)

      end
  end

end

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

  @task_menu = ScriptMenu.new( @task_list, nil )
  @task_menu.show()
  @task_menu.menu_selection()
end

screen = PPCurses::Screen.new()
screen.run { display_menu() }

if @task_menu.pressed_enter then
  handle_option( @task_menu.selected_menu_name )
end

