function! GetSessId()
   let passedString = v:this_session
   if strlen(passedString) > 0
       let sessFileComponents = split(passedString, '/')
       return join(sessFileComponents[-2: -1], '/')
   endif
   return 'No Session'
endfunction
