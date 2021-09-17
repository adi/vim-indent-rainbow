
	
		
			
				
					
						
							
								
									
										
											
												
													
														
															
																

hi GroupRed ctermbg=234
hi GroupYellow ctermbg=235
hi GroupGreen ctermbg=236
hi GroupCyan ctermbg=237
hi GroupBlue ctermbg=238
hi GroupMagenta ctermbg=239

let s:grs = [
	\ "GroupRed",
	\ "GroupYellow",
	\ "GroupGreen",
	\ "GroupCyan",
	\ "GroupBlue",
	\ "GroupMagenta",
	\ ]

" let g:rainbow_maxcolors = len(s:grs) " enable this if you want all the colors
let g:rainbow_maxcolors = 4

function rainbow#enable() abort
	if !exists("w:ms")
		let w:ms=[]
	endif
	if len(w:ms) == 0
		let level = 0
		let maxlevel = 40
		let tab_pat = "\\zs\t\\ze"
		let tab_seq = ""
		let spc_in_tab = ""
		let spc_left = &tabstop
		while spc_left > 0
			let spc_in_tab = spc_in_tab . " "
			let spc_left = spc_left - 1
		endwhile
		let spc_pat = "\\zs" . spc_in_tab . "\\ze"
		let spc_seq = ""
		while level <= maxlevel
			let gridx = level % g:rainbow_maxcolors
			" echom s:grs[gridx] . "   ^" . tabseq . pat
			let mtab = matchadd( s:grs[gridx], "^" . tab_seq . tab_pat )
			call add(w:ms, mtab)
			let mspc = matchadd( s:grs[gridx], "^" . spc_seq . spc_pat )
			call add(w:ms, mspc)
			let tab_seq = tab_seq . "\t"
			let spc_seq = spc_seq . spc_in_tab
			let level = level + 1
		endwhile
	endif
endfunction

function rainbow#disable() abort
	if !exists("w:ms")
		let w:ms=[]
	endif
	if len(w:ms) != 0
		for m in w:ms
			call matchdelete(m)
		endfor
		let w:ms = []
	endif
endfunction

function rainbow#toogle() abort
	if !exists("w:ms")
		let w:ms=[]
	endif
	if len(w:ms) == 0
		call rainbow#enable()
	else
		call rainbow#disable()
	endif
endfunction

augroup rainbowgroup
	au!
	au WinEnter * :call rainbow#enable()
	au VimEnter * :call rainbow#enable()
augroup END

nnoremap <Plug>RainbowToogle :call rainbow#toogle()<CR>

nmap <silent><leader><TAB> <Plug>RainbowToogle

