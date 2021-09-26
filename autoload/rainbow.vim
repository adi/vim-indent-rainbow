"_ demo with lookback to first color
							

"# use 256-colors.sh to pick, here we have shades of black + the usual rainbow
if !exists("g:rainbow_colors_black")
    let g:rainbow_colors_black= [ 234, 235, 236, 237, 238, 239 ]
endif
if !exists("g:rainbow_colors_color")
    let g:rainbow_colors_color= [ 226, 192, 195, 189, 225, 221 ]
endif

" the code follows
function! rainbow#enable() abort
	if !exists("w:ms")
		let w:ms=[]
	endif
        let g:rainbow_colors = ( &background == "dark"? g:rainbow_colors_black : g:rainbow_colors_color )
	if len(w:ms) == 0
		let groups = []
		for color in g:rainbow_colors
			let group = "colorgroup_".color
			execute "hi ".group." ctermbg=".color
			call add(groups, group)
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
			let gridx = level % len(groups)
			" echom s:grs[gridx] . "   ^" . tabseq . pat
			let mtab = matchadd( groups[gridx] , "^" . tab_seq . tab_pat )
			call add(w:ms, mtab)
			let mspc = matchadd( groups[gridx] , "^" . spc_seq . spc_pat )
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

function! rainbow#toggle() abort
	if !exists("w:ms")
		let w:ms=[]
	endif
	if len(w:ms) == 0
		call rainbow#enable()
	else
		call rainbow#disable()
	endif
endfunction

