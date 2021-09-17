
	
		
			
				
					
						
							
								
									
										
											
												
													
														
															
																
																	
																		

hi GroupRed ctermbg=232
hi GroupYellow ctermbg=233
hi GroupGreen ctermbg=234
hi GroupCyan ctermbg=235
hi GroupBlue ctermbg=236
hi GroupMagenta ctermbg=237

let s:grs = [
	\ "GroupRed",
	\ "GroupYellow",
	\ "GroupGreen",
	\ "GroupCyan",
	\ "GroupBlue",
	\ "GroupMagenta",
	\ ]

let s:ms = []
" let s:maxcolors = len(s:grs)
let s:maxcolors = 4

function rainbow#enable() abort
	let level = 0
	let maxlevel = 40
	let pat = "\\zs\t\\ze"
	let tabseq = ""
	while level <= maxlevel
		let gridx = level % s:maxcolors
		" echom s:grs[gridx] . "   ^" . tabseq . pat
		let m = matchadd( s:grs[gridx], "^" . tabseq . pat )
		call add(s:ms, m)
		let tabseq = tabseq . "\t"
		let level = level + 1
	endwhile
endfunction

function rainbow#disable() abort
	for m in s:ms
		call matchdelete(m)
	endfor
	let s:ms = []
endfunction

function rainbow#toogle() abort
	if len(s:ms) == 0
		call rainbow#enable()
	else
		call rainbow#disable()
	endif
endfunction

call rainbow#enable()

nnoremap <Plug>RainbowToogle :call rainbow#toogle()<CR>

nmap <silent><leader><TAB> <Plug>RainbowToogle

