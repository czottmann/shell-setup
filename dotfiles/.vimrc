"
"   VIM Config
"
"   Pulled together from a wide variety of sources, in particular:
"   *   _General goodness_:
"       *   http://items.sjbach.com/319/configuring-vim-right
"       *   http://github.com/spicycode/bringing-vim-to-the-people/
"       *   http://vimrc-dissection.blogspot.com/
"   *   _Colors_:
"       *   http://rtlechow.com/2008/12/256-colors-in-vim-inside-screen-in-an-iterm-on-os-x-leopard
"       *   http://pjkh.com/articles/2008/07/09/osx-iterm-screen-vim-256-colors
"   *   _Long line highlighting_:
"       *   http://muffinresearch.co.uk/archives/2009/06/22/vim-automatically-highlight-long-lines/
"   *   _File Templates_:
"       *   http://lucumr.pocoo.org/2007/8/3/vim-file-templates and http://dev.pocoo.org/~mitsuhiko/_vimrc
"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors
"
    set t_Co=64            " Use 256 colors
    " syntax highlighting
    if has('syntax')
        syntax on

        filetype on
        filetype plugin on
        filetype indent on
        " set cursorline          " What line am I on?
        colorscheme slate 
        " syntax highlight for complext documents is a little slow.  Tweaking
        " the settings a bit to reduce the load (especially on remote
        " machines)
        set synmaxcol=500
        syn sync minlines=50
        let loaded_matchparen=1 
    endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   Generic Config
"
    set encoding=utf8               " UTF-8!  Yay!
    set nocompatible                " Vim is The Future.
    set hidden                      " 'Hidden' buffers are awesome.
    let mapleader=","               " Set ',' as leader.
    set history=1000                " More history is better
    runtime macros/matchit.vim      " Make '%' more useful
    set wildmenu                    " Make tab completion more useful
    set wildmode=list:longest
    set wildignore+=*.pyc,*.o,*.obj,.git
    set title                       " Show Vim title in the terminal window
    set visualbell                  " Why would I want my computer to beep at me?
    set shortmess=atI               " get rid of prompts I don't care about
    set timeoutlen=300              " Quick timeouts for command combinations
    set laststatus=2                " Always show status line
    set showmode                    " Tell me what mode I'm in (insert/visual/etc)
    set showmatch                   " Automatically show matching brace/parens/etc.
    set number                      " Line numbers, yessir
    set lsp=2                       " Line spacing, 's important

    " Helpful mappings
    nnoremap ' `                            " ` is more useful than '.  Swap them.
    nnoremap ` '
    map <silent> <leader>p :set paste!<CR> " <leader>p toggles paste mode


    " Modelines let me set file-specific settings with file headers
    set modeline
    set modelines=5

    " Ruler / Rulerformat 
    if has('cmdline_info')
        set ruler
        set rulerformat=%40(%=%y%m%r%w\ [Line=%4l,Col=%2c]\ %P%)
        set showcmd
    endif

    " temp files in ~/.vim/tmp
    set backupdir=~/.vim/tmp,~/.tmp,~/tmp,/var/tmp,/tmp
    set directory=~/.vim/tmp,~/.tmp,~/tmp,/var/tmp,/tmp

    " Set `K` to call help on the currently marked keyword in vimrc
    au BufReadPost .vimrc map K :exe ":help ".expand("<cword>")<CR>

    " Ctrl-A == Select All
    nmap <silent> <C-A> ggVG<CR>

    " Map <Ctrl-C> and <Ctrl-V> to the OSX clipboard (using fakeclip plugin)
    map <C-C> <Plug>(fakeclip-y)
    map <C-V> <Plug>(fakeclip-p)

    imap <C-BS> <C-W>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   Movement
"
    " Redefining sections to 
    map [[ ?{<CR>w99[{
    map ][ /}<CR>b99]}
    map ]] j0[[%/{<CR>
    map [] k$][%?}<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   Typos
"
    command W write
    command Q quit
    command Wq wq
    command WQ wq

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   Tabs/Buffers
"
    " Map <leader>[ and <leader>] to previous/next buffer
    nmap <silent> <leader>[ :bp<CR>
    nmap <silent> <leader>] :bn<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   Searching and Scrolling
"
    " scroll a bit faster
    nnoremap <C-e> 3<C-e>
    nnoremap <C-y> 3<C-y>

    " Highlight search, incrementally
    set hlsearch
    set incsearch

    " make search case-sensitive only when a capital letter is involved
    set ignorecase 
    set smartcase
   
    nnoremap <silent> <leader>h :noh<CR>

    "This unsets the "last search pattern" register by hitting return
    nnoremap <CR> :noh<CR><CR>
    

    " show more stuff around the cursor
    set scrolloff=3
 
    " Toggle display of whitespace and +80 character lines with <leader>s
    set listchars=nbsp:¬,eol:¶,tab:>-,extends:»,precedes:«,trail:·
    nnoremap <silent> <leader>s
        \ :set number!<Bar>set nolist!<CR>
        \ :if exists('w:long_line_match') <Bar>
        \   silent! call matchdelete(w:long_line_match) <Bar>
        \   unlet w:long_line_match <Bar>
        \ elseif &textwidth > 0 <Bar>
        \   let w:long_line_match = matchadd('ErrorMsg', '\%>'.&tw.'v.\+', -1) <Bar>
        \ else <Bar>
        \   let w:long_line_match = matchadd('ErrorMsg', '\%>80v.\+', -1) <Bar>
        \ endif<CR>

    " Display word/byte count with <leader>wc
    nnoremap <leader>wc g<C-g>

    " wrap around when crossing left and right edge of editors
    set whichwrap=h,l,~,[,],<,>
    set backspace=eol,start,indent

    " Don't softwrap files by default
    set nowrap

    " Fix page up/down to maintain cursor position: Also: page up/down now
    " scroll only half a screen at a time.  I'm pretty much ok with that.  :)
    map <PageUp>    <C-U>
    map <PageDown>  <C-D>
    imap <PageUp>   <C-O><C-U>
    imap <PageDown> <C-O><C-D>
    set nostartofline               " Preserve column when repositioning cursor  

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   GUI Settings (I don't actually use these (except the mouse)... will delete
"   this section if I don't install MacVim soon)
"
    if has('gui_running')
        set encoding=utf-8
        set lines=75
        set columns=144
        set guifont=Menlo:h14
        set guitablabel=%t
        "set fuoptions=maxvert,maxhorz
        "au GUIEnter * set fullscreen
        set fuoptions=maxvert
        set guioptions=egmt

        map <leader>mz
            \ :set columns=75<Bar>
            \ :set invwrap<Bar>
            \ :set invlinebreak<Bar>
            \ :set invfu<CR>
    end

    " What's that?  You have a mouse?  And you're using iTerm?  Well then...
    if has('mouse')
        " Use the mouse in normal, visual, and insert modes; this leaves
        " command mode open for GUI copy/paste.
        set mouse=nvi
    endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   Indenting is serious business
"
    " Defaults: tab stop every 2 columns (autoindent too), tabs expanded to spaces
    set tabstop=2
    set shiftwidth=2
    set softtabstop=2
    set expandtab

    " Indent in visual mode remains in visual mode: allows multiple indents
    vnoremap <silent> > >gv
    vnoremap <silent> < <gv

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   Syntax
"
    " Debugging Syntax Files
    map <leader>d :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
            \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
            \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

    " PHP
    let php_folding=0           " Folding is for losers.
    let php_short_tags=0        " Short tags are bad.
    let php_alt_properties=1    " Colorize `->` based on usage
    let php_sql_query=1         " SQL in strings
    let php_htmlInStrings=1     " HTML in strings (aside: I find it
                                " _hilarious_ that even the PHP syntax file
                                " options follow the general standard of
                                " completly absurd naming conventions.
                                " `sql_query` vs `htmlInString`.)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"   File Templates
"
    function! LoadFileTemplate()
      silent! 0r ~/.vim/templates/%:e.tmpl
      syn match vimTemplateMarker "<+.\++>" containedin=ALL
      hi vimTemplateMarker guifg=#67a42c guibg=#112300 gui=bold
    endfunction
    function! JumpToNextPlaceholder()
      let old_query = getreg('/')
      echo search("<+.\\++>")
      exec "norm! c/+>/e\<CR>"
      call setreg('/', old_query)
    endfunction
    autocmd BufNewFile * :call LoadFileTemplate()
    nnoremap <leader>j :call JumpToNextPlaceholder()<CR>a
    inoremap <leader>j <ESC>:call JumpToNextPlaceholder()<CR>a

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Debugging Syntax
"
map <leader>d :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
    \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
    \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   Plugins
"


    " Command-T
    let g:CommandTMaxHeight=5
    let g:CommandTMatchWindowAtTop=1
    nmap <silent> <Leader>t :CommandT<CR>

    " NERD_Tree
    let NERDChristmasTree=1
    let NERDTreeHighlightCursorline=1
    let NERDTreeShowBookmarks=1
    let NERDTreeShowHidden=1
    let NERDTreeQuitOnOpen=1
    map <silent> <leader>n :execute 'NERDTreeToggle ' . getcwd()<CR>

    " NERD_Comment
    let NERDCommentWholeLinesInVMode=1
    let NERDSpaceDelims=1
    map  <leader>/  <Plug>NERDCommenterToggle
    imap <C-/>      <C-O><Plug>NERDCommenterToggle

    " Syntastic
    let g:syntastic_enable_signs=1
    let g:syntastic_auto_loc_list=1

    " SuperTab
    let g:SuperTabMidWordCompletion = 0             " No mid-word completion
    let g:SuperTabMappingTabLiteral = '<S-tab>'     " Shift-Tab inserts literal tab
    let g:SuperTabMappingBackward = '<C-tab>'       " Map ctrl-tab to backwards tab completion

    " taglist
    map <silent> <leader>l :TlistToggle<CR>

    " MiniBufExplorer
    let g:miniBufExplorerMoreThanOne=2
    let g:miniBufExplTabWrap=1

    " bufkill ( http://www.vim.org/scripts/script.php?script_id=1147 )
    map <silent> <leader>q  <Plug>BufKillBd

    " vim-git: show diff when writing git commit message
