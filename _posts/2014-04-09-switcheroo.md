---
layout: post
title: "The Old Switcheroo"

---

Switching between branches when developing can be a nuissance, especially if you're using a branch inconvenient source control system (i.e. Subversion).  Traditionally a developer will create a new workspace environment for every branch. This article describes how to avoid creating a new workspace for every branch.

I am currently working on a large Java project and am using my own custom configuration in IntelliJ.  The architecture style of the project is to create many fine-grained projects.  Too fine-grained for my taste in fact, that I've created my own personal meta projects that make navigating the information overload more manageable.

Everything was hunky dory until our project hit it's first milestone and we created a release branch.  Being too lazy to create two workspaces with exactly the same configuration I decided to do some work to avoid this.

## The Solution ##

1. **Add [path variables][pathVar]** for all your content roots in IntelliJ. (i.e. PROJECT\_X\_ROOT) 

2. Make copies of **path.macros.xml**.  One for each branch. (i.e. path.macros.xml.trunk and path.macros.release.1)

3. Write a script called  to switch between these two files.  I called mine **switchBranch** and used [PPCurses][PPCurses] to add a little flair.


<img src="/images/switchBranch.jpg">


## The Switcheroo ##

1. Shutdown IntelliJ

2. Run **switchBranch** 

3. Restart IntelliJ


The advantage of this is that if I make a configuration change to my workspace I only have to make it in one place.  Switching between three branches simply requires creating another path.macros.xml.branchname file.

Here is what the current version of my switchBranch script looks like.

{% highlight ruby %}
#!/usr/bin/env ruby

require 'ppcurses'

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


def replace_path_macro_file( file )
  root_dir = '/cygdrive/c/Dev/IntelliJ/.IdeaIC/config/options/'
  cmd = 'cp ' + root_dir + file + ' ' + root_dir +'path.macros.xml' 

  puts 'replacing path.macros.xml with ' + file
  system cmd
end


def switch_macro_file( choice )

  case choice
  when 'Trunk'
    replace_path_macro_file('path.macros.xml.trunk')
  when 'Release 1'
    replace_path_macro_file('path.macros.xml.release.1')
  else
    puts "INDEX not implemented !!!"
    return
  end
end



def display_menu
  @branch_list = ["Trunk", "Release 1" ] 

  @branch_menu = ScriptMenu.new( @branch_list, nil )
  @branch_menu.show()
  @branch_menu.menu_selection()
end

screen = PPCurses::Screen.new()
screen.run { display_menu() }


if @branch_menu.pressed_enter then
  switch_macro_file( @branch_menu.selected_menu_name )
end




{% endhighlight %}


[PPCurses]: https://github.com/mcormier/ppcurses
[pathVar]: https://www.jetbrains.com/idea/webhelp/path-variables.html
