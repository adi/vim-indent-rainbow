> An indent-rainbow plugin for Vim, to colorize tab indented source code like Pycharm or Visual Studio Code index-rainbow plugins

## License

Copyright (C) 2021, CSVRX - a data consultant who prefers to remain pseudonymous :)

Copyright (C) 2021, Adrian Punga

The code is released under the Apache-2.0 License, a permissive license whose main conditions require preservation of copyright and license notices.

Contributors provide an express grant of patent rights. Licensed works, modifications, and larger works may be distributed under different terms and without source code

## Example

![static image in indent rainbow mode](https://raw.githubusercontent.com/csdvrx/indent-rainbow/main/vim-indent-rainbow.jpg)

Is this madness? No, this is python, where tabs are used by the interpreter, and not just reserved for code presentation...

I couldn't think of anything funny, so I just used True and False, but feel free to submit a nicer example :)

## Theme synchronization

The rainbow will automatically use pastel colors if you are using a light background, or shades of grey if you are using a dark background:

![demo of the indent rainbow theme synchronization](https://raw.githubusercontent.com/csdvrx/indent-rainbow/main/vim-indent-rainbow_solarized.gif)

The above is what it looks like in Windows Terminal Preview, with syntax coloring enabled and Solarized Light, toggling indent-rainbow, then switching to Solarized Dark and doing the same.

## Installation

Add the files togglerb.vim and rainbow.vim to your ~/.vim/autoload so that they can get loaded automatically.

To setup a hotkey like F9 to enable the indent rainbow on demand, add to your .vimrc:

``
call togglerb#map("<F9>")
``

This will use pastel colors if you are using a light background, or shades of grey if you are using a dark background.

## Usage

The rainbow indent is not just limited to python files: you can use the same feature on any file, for example here's my rainbowised rainbow.vim inside vim:

![rainbow.vim is rainbowised by itself](https://raw.githubusercontent.com/csdvrx/indent-rainbow/main/rainbow_vim.jpg)

## Configuration

To change the default colors, pick 6 colors from the output of config/256-colors.sh as explained at the beginning of rainbow.vim, and put them in your .vimrc, like:

``
let g:rainbow_colors_black= [ 234, 235, 236, 237, 238, 239 ]
let g:rainbow_colors_color= [ 226, 192, 195, 189, 225, 221 ]
``

In case you can't run bash, or are too lazy, here's what the colors look like, so you can see 232 to 255 are different shades of grey.

![output of 256-colors.sh](https://raw.githubusercontent.com/csdvrx/indent-rainbow/main/config/256-colors.jpg)

To automagically start the indent rainbow with some file formats, like say python, add to your .vimrc:

`` 
if has("autocmd")
 augroup python
  au!
  autocmd BufNewFile,BufReadPre,FileReadPre        *.py set tabstop=4
  autocmd BufNewFile,BufReadPre,FileReadPre        *.py set softtabstop=4
  autocmd BufNewFile,BufReadPre,FileReadPre        *.py set shiftwidth=4
  autocmd BufNewFile,BufReadPre,FileReadPre        *.py set expandtab
  autocmd BufNewFile,BufReadPre,FileReadPre        *.py set autoindent
  autocmd BufNewFile,BufReadPre,FileReadPre        *.py set autoindent
  autocmd BufNewFile,BufReadPre,FileReadPre        *.py set fileformat=unix
"I like wide text, sorry PEP
" autocmd BufNewFile,BufReadPre,FileReadPre        *.py set textwidth=79
  autocmd WinEnter,VimEnter *.py :call rainbow#enable()
 augroup END
endif
``

If you want more, I have added some of the syntax configuration files I used in the after/ directory: I mostly care about the structure of comments standing out, so I use various text attributes like bold, italics, underline...

## My result doesn't look as good! Why?

### Ideally, run mintty

If you have no bold, italics, underline (etc) or some colors are missing (What do you mean, 16 colors? WTF! It's 2021!! I want 24 bit truecolor!!!), this is likely due to your terminal.

Long story short, you should really be using mintty, unless you don't care about getting the best results!

### If you can't, try using Windows Terminal

If you have no time to configure mintty, Windows Terminal is quite advanced, but not there yet.

Still, if you want to skip all the configuration steps while still getting the same final result, simply install msys2 then copy and paste the relevant parts of my windows_terminal.json into your configuration.

Protip: the json file is in the config/ directory.

### If you want to stick to Windows Terminal, please use sixel-tmux?

After giving it a try, if you want to make Windows Terminal your daily driver, don't just use a dull grey term! Sixels are nice! Ascii art is fun!

I mean, check out https://github.com/klamonte/jexer from the most exxcellent Autumn Lamonte or https://notcurses.com/ from another crazy genius, Nick Black!! 

These kind of interfaces are why I strongly suggest running https://github.com/csdvrx/sixel-tmux inside Windows Terminal : you can get results like https://github.com/microsoft/terminal/issues/448#issuecomment-744192801

However, please note that this is at best a clever hack: I still prefer and recommend mintty, which is the best terminal available on all platforms!

So please use mintty instead! This way, you can enjoy nice graphics inside your terminal and live a happy life :)

### If you are stuck with Linux, at least use a cute xterm!

xterm is the next best, cf my long rant on https://github.com/csdvrx/cutexterm#why-did-you-make-cutexterm-warning-long-rant where you'll at least get a nice set of defaults to make it usable.

### I thought you preferred Windows! Why don't you like Windows Terminal?

I really like Microsoft products and Windows in general, and I'm ready to admit
Windows Terminal is *extremely promising*, but has a few major showstoppers,
such as:

- a lack of support for TIOCGWINSIZ or OSC 14t to introspect the windows size in pixel: https://github.com/microsoft/terminal/issues/8581

- a lack of support for advanced font attributes: https://github.com/microsoft/terminal/issues/6779

- and issue number 1, a total lack of support for sixels: https://github.com/microsoft/terminal/issues/448

I am software agnostic: I use the best of whatever, regardless of what it is, and unfortunately for Windows Terminal, the best is currently called "mintty"!

Still, all hope hasn't been lost yet: some long standing issues such as a proper bold support are finally being fixed!

Just yesterday I learned this 2-years old feature request had finally been added (simply add `"intenseTextStyle": "bold"` in your profiles, cf https://github.com/microsoft/terminal/issues/109#issuecomment-926706612)

Maybe in 6 years from now, the VT-340 will be properly emulated by Windows Terminal?

Time will tell, as tests have barely started on https://github.com/hackerb9/vt340test with PR visible https://github.com/microsoft/terminal/pull/11152

Hopefully a proper Windows Terminal support will happen before the 30 years anniversary of this venerable DEC terminal :)

(unsensitive jokes aside, please keep going guys! I really want to love Windows Terminal!)

## TODO

For people who don't like rainbow barfs, the code could be improved to support a more "sophisticated" mode, maybe similar to Ident-Guide from https://www.vim.org/scripts/script.php?script_id=3361 where there is only one colored character per tab.

For people who are stuck with software from the previous century/millenia, 16 and 8 color mode should be added by... someone? I won't!

## indent-rainbow history

Adrian Punga wrote most of the code I found on https://github.com/adi/vim-indent-rainbow and forked here. Here's the one you should be thanking. I simply added a few things here and there.

I started this fork for very selfish reasons: since I mostly use light themes, I didn't like the shades of black.

This is why I added colors, and a better integration with the Solarized theme to automatically get rainbows when using Solarized Light, and revert to shades of black when using Solarized Dark - like, at night.

I also added some documentation and screenshots, and renamed this repo to just "indent-rainbow" to match similar plugins such as https://plugins.jetbrains.com/plugin/13308-indent-rainbow or https://marketplace.visualstudio.com/items?itemName=oderwat.indent-rainbow

I hope you'll like rainbow indent as much as I did, and that it will bring a touch of color and happiness to your coding days :)
