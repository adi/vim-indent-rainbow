
	
		
			
				
					
						
							
								
									
										
											
												
													
														
															
																
																	
																		

hi GroupRed ctermbg=Red
hi GroupYellow ctermbg=Yellow
hi GroupGreen ctermbg=Green
hi GroupCyan ctermbg=Cyan
hi GroupBlue ctermbg=Blue
hi GroupMagenta ctermbg=Magenta

let s:grs = [
	\ "GroupRed",
	\ "GroupYellow",
	\ "GroupGreen",
	\ "GroupCyan",
	\ "GroupBlue",
	\ "GroupMagenta",
	\ ]

let s:ms = []

function rainbow#enable() abort
	let level = 0
	let maxlevel = 40
	let pat = "\\zs\t\\ze"
	let tabseq = ""
	while level <= maxlevel
		let gridx = level % len(s:grs)
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

nmap <leader><TAB> <Plug>RainbowToogle

