--- 
layout: post
title: Switch between .m and .h file in VI
categories: 
- Mondo Kode
tags: []

status: publish
type: post
published: true
meta: 
  _edit_last: "1"
---
If you are working on Objective-C kode in VI the following functions and key mapping will allow you to quickly switch between the header and implementation file.

<pre lang="vim" >
" Switch editing between
" *.c and *.h files  (C)
" or
" *.m and *.h files  (ObjC)
function! Flip_Extension()

  if match(expand("%"),'\.m') > 0
    let s:flipname = substitute(expand("%"),'\.m\(.*\)','.h\1',"")
    call LoadFile(s:flipname)
  elseif match(expand("%"),"\\.h") > 0
    let s:flipname = substitute(expand("%"),'\.h\(.*\)','.m\1',"")
    if (filereadable(s:flipname)) > 0
      call LoadFile(s:flipname)
    else
      let s:flipname = substitute(expand("%"),'\.h\(.*\)','.c\1',"")
      call LoadFile(s:flipname)
    endif
  elseif match(expand("%"),"\\.c") > 0
    let s:flipname = substitute(expand("%"),'\.c\(.*\)','.h\1',"")
    call LoadFile(s:flipname)
  endif

endfun

" Find the filename in an existing buffer
" if it exists open that buffer so you don't
" lose your file position.
function! LoadFile(filename)
  let s:bufname = bufname(a:filename)
  if (strlen(s:bufname)) > 0
    exe ":buffer" s:bufname
  else
    exe ":find " a:filename
  endif
endfun

map <f4> :call Flip_Extension()<cr>
</pre>

Kode on!

Reference:
<a href="http://vim.wikia.com/wiki/Easily_switch_between_source_and_header_file">Easily switch between source and header file</a>
