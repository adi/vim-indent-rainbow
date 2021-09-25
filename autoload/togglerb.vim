" Toggle Rainbow

if exists("g:loaded_togglerb")
    finish
endif
let g:loaded_togglerb = 1

" noremap is a bit misleading here if you are unused to vim mapping.
" in fact, there is remapping, but only of script locally defined remaps, in 
" this case <SID>TogRB. The <script> argument modifies the noremap scope in 
" this regard (and the noremenu below).
nnoremap <unique> <script> <Plug>ToggleRainbow <SID>TogRB
inoremap <unique> <script> <Plug>ToggleRainbow <ESC><SID>TogRB<ESC>a
vnoremap <unique> <script> <Plug>ToggleRainbow <ESC><SID>TogRB<ESC>gv
nnoremenu <script> Window.Toggle\ Background <SID>TogRB
inoremenu <script> Window.Toggle\ Background <ESC><SID>TogRB<ESC>a
vnoremenu <script> Window.Toggle\ Background <ESC><SID>TogRB<ESC>gv
tmenu Window.Toggle\ Toggle rainbow indent modes
nnoremenu <script> ToolBar.togglerb <SID>TogRB
inoremenu <script> ToolBar.togglerb <ESC><SID>TogRB<ESC>a
vnoremenu <script> ToolBar.togglerb <ESC><SID>TogRB<ESC>gv
tmenu ToolBar.togglerb Toggle rainbow indent modes
noremap <SID>TogRB  :call <SID>TogRB()<CR>

" In case the solarized style was changed, the toggle does update accordingly
function! s:TogRB()
    call rainbow#toggle()
endfunction

if !exists(":ToggleRB")
    command ToggleRB :call s:TogRB()
endif

function! ToggleRainbow()
    echo "Please update your ToggleRainbow mapping."
endfunction

function! togglerb#map(mapActivation)
    try
        exe "silent! nmap <unique> ".a:mapActivation." <Plug>ToggleRainbow"
        exe "silent! imap <unique> ".a:mapActivation." <Plug>ToggleRainbow"
        exe "silent! vmap <unique> ".a:mapActivation." <Plug>ToggleRainbow"
    finally
        return 0
    endtry
endfunction

"if !exists("no_plugin_maps") && if !hasmapto('<Plug>ToggleRainbow')
"    call togglerb#map("<F8>")
"endif
