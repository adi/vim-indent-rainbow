
	
		
			
				
					
						
							
								
									
										
											
												
													
														
															
																


let g:rainbow_colors={
	\ 'red':234,
	\ 'yellow':235,
	\ 'green':236,
	\ 'cyan':237,
	\ 'blue':238,
	\ 'magenta':239,
\ }

function! rainbow#enable() abort
	if !exists("w:ms")
		let w:ms=[]
	endif
	if len(w:ms) == 0
		let colorNames = keys(g:rainbow_colors)
		for colorName in colorNames
			execute "hi ".colorName."_group ctermbg=".g:rainbow_colors[colorName]
		endfor
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
			let gridx = level % len(colorNames)
			" echom s:grs[gridx] . "   ^" . tabseq . pat
			let mtab = matchadd( colorNames[gridx]."_group" , "^" . tab_seq . tab_pat )
			call add(w:ms, mtab)
			let mspc = matchadd( colorNames[gridx]."_group" , "^" . spc_seq . spc_pat )
			call add(w:ms, mspc)
			let tab_seq = tab_seq . "\t"
			let spc_seq = spc_seq . spc_in_tab
			let level = level + 1
		endwhile
	endif
endfunction

function! rainbow#disable() abort
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

function! rainbow#toogle() abort
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

