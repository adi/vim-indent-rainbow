
	
		
			
				
					
						
							
								
									
										
											
												
													
														
															
																

hi GroupRed ctermbg=233
hi GroupYellow ctermbg=234
hi GroupGreen ctermbg=235
hi GroupCyan ctermbg=236
hi GroupBlue ctermbg=237
hi GroupMagenta ctermbg=238

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
	let level = 0
	let maxlevel = 40
	let pat = "\\zs\t\\ze"
	let tabseq = ""
	while level <= maxlevel
		let gridx = level % g:rainbow_maxcolors
		" echom s:grs[gridx] . "   ^" . tabseq . pat
		let m = matchadd( s:grs[gridx], "^" . tabseq . pat )
		call add(w:ms, m)
		let tabseq = tabseq . "\t"
		let level = level + 1
	endwhile
endfunction

function rainbow#disable() abort
	if !exists("w:ms")
		let w:ms=[]
	endif
	for m in w:ms
		call matchdelete(m)
	endfor
	let w:ms = []
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
augroup END

nnoremap <Plug>RainbowToogle :call rainbow#toogle()<CR>

nmap <silent><leader><TAB> <Plug>RainbowToogle

