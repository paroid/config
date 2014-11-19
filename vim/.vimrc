"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" .vimrc file for vim
" compatible with [windows/unix]  [vim/gvim]
" author: paroid
" email:  paroid@paroid.org
" update: 2013-10-8
" Happy Vimming! 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
execute pathogen#infect()
set nocompatible
filetype on
filetype plugin on
filetype indent on
syntax on
let mapleader=','
"OS  custom settings
if has("win32")
    let $LANG = 'en_US'
    set guifont=Microsoft_YaHei_Mono:h11:cANSI
    let g:baseDir = 'D:\Paroid\Project'
    lang messages en_US,utf-8
    set tags+=$VIM\stl_tags
    nnoremap <leader>e :e $VIM\_vimrc <CR>
    let g:vimwiki_list = [{'path': 'D:\vimwiki','path_html': 'D:\vimwiki\public_html','auto_export': 0}]

elseif has("unix")
    let $LANG = 'US'
    set guifont=consolas\ 11
    let g:baseDir = '~/project'
    set tags+=~/.vim/stl_tags
    nnoremap <leader>e :e ~/.vimrc <CR>
    let g:vimwiki_list = [{'path': '~/vimwiki','path_html': '~/vimwiki/public_html','auto_export': 0}]
endif
"short mapping
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
inoremap jk <ESC>
nnoremap ; :
vnoremap ; :
snoremap ; :
nnoremap <leader><space> :noh<CR>
nnoremap <leader>W :update !sudo tee %<CR>
nnoremap <leader>w :update<CR>
noremap <C-S>	:update<CR>
vnoremap <C-S>	<C-C>:update<CR>
inoremap <C-S>	<C-O>:update<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>l :call ListToggle()<CR>
nnoremap <leader>. :call NumberToggle()<CR>
nnoremap R :silent! MRU<CR>
nnoremap <leader>C :Calendar<CR>
nnoremap <leader>i :call FormatIndent()<CR>
nnoremap <leader>z :call WindowVerticalZoom()<CR>
nnoremap <leader>Z :call WindowHorizontalZoom()<CR>
"Fold Code With Space
nnoremap <silent> <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
nnoremap <silent> <S-space> @=(HasFoldedLine() ? 'zR' : 'zM')<CR>

"map function with short key
nnoremap <F1> :h 
inoremap <F1> <ESC>:h 
nnoremap <F2> :GundoToggle<CR>
nnoremap <F3> :call Astyle()<CR>
nnoremap <F4> :call Compile()<CR>
nnoremap <F5> :call Run()<CR>
nnoremap <F6> :call Debug()<CR>
nnoremap <F7> :NERDTreeToggle<CR>
nnoremap <F8> :TagbarToggle<CR>
nnoremap <F10> :Grep<CR>
nnoremap <F11> :call ToggleMenuBar()<CR>
nnoremap <F12> :call EchoHighlightGroup()<CR>

"copy to line end
nnoremap Y y$
"go to middle of current line
nnoremap gm :call cursor(0, len(getline('.'))/2)<CR>
"auto center search item
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz
nnoremap <silent> g# g#zz
"move text
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
" Code folding options
nmap <leader>f0 :set foldlevel=0<CR>
nmap <leader>f1 :set foldlevel=1<CR>
nmap <leader>f2 :set foldlevel=2<CR>
nmap <leader>f3 :set foldlevel=3<CR>
nmap <leader>f4 :set foldlevel=4<CR>
nmap <leader>f5 :set foldlevel=5<CR>
nmap <leader>f6 :set foldlevel=6<CR>
nmap <leader>f7 :set foldlevel=7<CR>
nmap <leader>f8 :set foldlevel=8<CR>
nmap <leader>f9 :set foldlevel=9<CR>
"real Tab
inoremap <C-Tab> <Tab>
"hex edit
nnoremap <leader>h :%!xxd<CR>
nnoremap <leader>H :%!xxd -r<CR>
nnoremap <leader>fv :FencView<CR>
"wrap toggle
nnoremap <leader>wr :set wrap! wrap?<CR>
"Auto Complete Bracket
inoremap {{ {}<ESC>i<CR><CR><ESC>kS
"Window switch 
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
"split window
nnoremap <leader>s :vsp 
nnoremap X :call TagbarZoom()<CR>
nnoremap Z :call NERDTreeZoom()<CR>
"resize window
nnoremap <Leader>= <C-w>=
nnoremap <leader>[ <C-w>12<
nnoremap <leader>] <C-w>12>
nnoremap <leader>{ <C-w>6-
nnoremap <leader>} <C-w>6+
"wrap line up down
nnoremap j gj
nnoremap k gk
"disable arrow key
"nnoremap <up> <nop>
"nnoremap <down> <nop>
"nnoremap <left> <nop>
"nnoremap <right> <nop>
"inoremap <up> <nop>
"inoremap <down> <nop>
"inoremap <left> <nop>
"inoremap <right> <nop>
"insert mode move
inoremap <C-h> <left>
inoremap <C-j> <down>
inoremap <C-k> <up>
inoremap <C-l> <right>
inoremap jl <right>
inoremap jf <left>
"visual indent
vnoremap > >gv
vnoremap < <gv
"quick delete command
nnoremap <leader>del :g/^\s*$/d<CR>
nnoremap <leader>dl :g/^$/,/./-j<CR>
"inc
noremap <C-i> <C-a>
"Select all
noremap <C-A> ggvG$
inoremap <C-A> <ESC>ggvG$
"system clipboard paste
nnoremap <C-q> "+gP
inoremap <C-q> <ESC>"+gPa
"copy to system clipboard
nnoremap <C-c> "+y
vnoremap <C-c> "+y
snoremap <C-c> "+y
"filename completion
inoremap <A-f> <C-x><C-f>
"work base dir
nnoremap <leader>bb :call CdBaseDir()<CR>
"python calculator
:py from math import *
:command! -nargs=+ Calc :py print <args>
"UTF-8 convertor
:command! -nargs=0 ConvertToUtf8 :call ConvertToUtf8()

"some custom vim function
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"base Directory
function! CdBaseDir()
    exe "cd ".g:baseDir
endfunc
"Astyle : format code, need Astyle.exe
function! Astyle()
    if &filetype == 'c' || &filetype == 'cpp' || &filetype == 'java'
        :update
        exec "!Astyle -A2 -p -S -n -y --indent=spaces %"
        exec "e!"
    endif
endfunc
"some compiler cmd
"need gcc/g++/java/python
function! Compile()
    :update
    if &filetype == 'c'
        exec "!gcc -Wl,-enable-auto-import % -g -o %<.exe"
    elseif &filetype == 'cpp'
        exec "!g++ -Wl,-enable-auto-import % -g -o %<.exe"
    elseif &filetype == 'java' 
        exec "!javac %" 
    elseif &filetype == 'python'
        exec "!python %"
    endif
endfunc

"Run
function! Run()
    if &filetype == 'c' || &filetype == 'cpp'
        exec "!%<.exe"
    elseif &filetype == 'java' 
        exec "!java %<"
    endif
endfunc

"Debug
function! Debug()
    if &filetype == 'c'
        exec "!gdb %<.exe"
    elseif &filetype == 'cpp'
        exec "!gdb %<.exe"
    elseif &filetype == 'java' 
        exec "!jdb %<"
    endif
endfunc

"Toggle Menu and Toolbar
function! ToggleMenuBar()
    if &guioptions =~# 'T' 
        set guioptions-=T 
        set guioptions-=m 
    else 
        set guioptions+=T
        set guioptions+=m
    endif
endfunc

function! ErrorSign()
    let errSign = SyntasticStatuslineFlag()
    let errSign = matchstr(errSign,"(\\d\*)")
    if errSign != ""
        let errSign = " ".errSign." "
    endif
    return errSign
endfunc

function! ListToggle()
    if &buftype != 'quickfix'
        :Errors
        :lopen
        :setl wrap
    else
        :lclose
    endif
endfunc

function! WindowVerticalZoom()
    if b:winVerticalZoomed == 1
        exe "res ".b:winHeight
        let b:winVerticalZoomed = 0
    else
        let b:winHeight = winheight(0)
        :res 
        let b:winVerticalZoomed = 1
    endif
endfunc
"horizontal
function! WindowHorizontalZoom()
    if b:winHorizontalZoomed == 1
        exe "vertical res ".b:winWidth
        let b:winHorizontalZoomed = 0
    else
        let b:winWidth = winwidth(0)
        :vertical res 
        let b:winHorizontalZoomed = 1
    endif
endfunc

function! TagbarZoom()
    if &filetype == 'nerdtree'
        call NERDTreeZoom()
    endif
    if &filetype == 'tagbar'
        normal x
        wincmd p
    else
        if bufwinnr('__Tagbar__') == -1
            :TagbarOpen
        endif
        :wincmd b
        if &filetype == 'tagbar'
            normal x
            call NoNumber()
        else
            :wincmd p
        endif
    endif
endfunc

"batch convert to UTF-8
function! ConvertToUtf8()
    let fileExt = "*.".expand("%:e")
    exec "args ".fileExt
    exec "argdo set fenc=utf-8 | update"
endfunc

function! NERDTreeZoom()
    if &filetype == 'tagbar'
        call TagbarZoom()
    endif
    if &filetype == 'nerdtree'
        normal A
        :vertical resize 24
        :q
        :wincmd b
        if &filetype == 'tagbar'
            :vertical resize 24
        endif
        :wincmd p
    else
        :silent! NERDTreeFind
        normal A
    endif
endfunc


function! NumberToggle()
    if(&relativenumber == 1)
        setl norelativenumber
        setl number
    else
        setl relativenumber
    endif
endfunc

function! FileTypeCheck()
    return &filetype != 'tagbar' && &filetype != 'nerdtree' && &filetype != 'mru' && &filetype != 'calendar'
endfunc

function! SetNumber()
    if FileTypeCheck()
        setl norelativenumber
        setl number
    endif
endfunc

function! SetRelativeNumber()
    if FileTypeCheck()
        :setl relativenumber
    endif
endfunc

function! NoNumber()
    if &nu == 1
        setl nonumber
    elseif &rnu == 1
        setl norelativenumber
    endif
endfunc

function! HasFoldedLine()
    let lnum = 1
    while lnum <= line("$")
        if foldclosed(lnum) != -1
            return 1
        endif
        let lnum += 1
    endwhile
    return 0
endfunc
"auto resize window
if has("gui_running")
    function! ScreenFilename()
        if has('amiga')
            return "s:.vimsize"
        elseif has('win32')
            return $HOME.'\_vimsize'
        else
            return $HOME.'/.vimsize'
        endif
    endfunction

    function! ScreenRestore()
        " Restore window size (columns and lines) and position
        " from values stored in vimsize file.
        " Must set font first so columns and lines are based on font size.
        let f = ScreenFilename()
        if has("gui_running") && g:screen_size_restore_pos && filereadable(f)
            let vim_instance = (g:screen_size_by_vim_instance==1?(v:servername):'GVIM')
            for line in readfile(f)
                let sizepos = split(line)
                if len(sizepos) == 5 && sizepos[0] == vim_instance
                    silent! execute "set columns=".sizepos[1]." lines=".sizepos[2]
                    silent! execute "winpos ".sizepos[3]." ".sizepos[4]
                    return
                endif
            endfor
        endif
    endfunction

    function! ScreenSave()
        " Save window size and position.
        if has("gui_running") && g:screen_size_restore_pos
            let vim_instance = (g:screen_size_by_vim_instance==1?(v:servername):'GVIM')
            let data = vim_instance . ' ' . &columns . ' ' . &lines . ' ' .
                        \ (getwinposx()<0?0:getwinposx()) . ' ' .
                        \ (getwinposy()<0?0:getwinposy())
            let f = ScreenFilename()
            if filereadable(f)
                let lines = readfile(f)
                call filter(lines, "v:val !~ '^" . vim_instance . "\\>'")
                call add(lines, data)
            else
                let lines = [data]
            endif
            call writefile(lines, f)
        endif
    endfunction

    if !exists('g:screen_size_restore_pos')
        let g:screen_size_restore_pos = 1
    endif
    if !exists('g:screen_size_by_vim_instance')
        let g:screen_size_by_vim_instance = 1
    endif
    autocmd VimEnter * if g:screen_size_restore_pos == 1 | call ScreenRestore() | endif
    autocmd VimLeavePre * if g:screen_size_restore_pos == 1 | call ScreenSave() | endif
endif

"set cursor to right position when open file
function! RestoreCursorPos()
    if line("'\"") > 0 && line("'\"") <= line("$") 
        normal! g`" 
    endif
endfunc

function! FormatIndent()
    :normal m`gg=G``
endfunc

function! QuickSelectMap()
    nmap <buffer> 1 1G<CR>
    nmap <buffer> 2 2G<CR>
    nmap <buffer> 3 3G<CR>
    nmap <buffer> 4 4G<CR>
    nmap <buffer> 5 5G<CR>
    nmap <buffer> 6 6G<CR>
    nmap <buffer> 7 7G<CR>
    nmap <buffer> 8 8G<CR>
    nmap <buffer> 9 9G<CR>
    nmap <buffer> 0 10G<CR>
endfunc

function! EchoHighlightGroup()
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc


"General setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"language & encoding
set fileencodings=utf-8,gbk
set encoding=utf-8
set spell
"format
set ambiwidth=double
set smarttab
set expandtab
set softtabstop=4
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set backspace=2
set nowrap
set linespace=0
"ctags
set tags=tags
set history=200
"Dir setting
set autochdir
set autoread
set wildmenu
set laststatus=2
set wildignore=*.o,*.obj,*.bak,*.exe,*.class,*.pyc
"search & match
set showmatch
set matchtime=8
set ignorecase
set smartcase
set incsearch
set hlsearch
set confirm
"color scheme & font
set background=dark
colorscheme molokai
let g:ophigh_color = "#b9c798"
set mouse=a
set mousehide
set foldenable
set foldmethod=indent
set foldlevel=100
set nobackup
set ruler
set scrolloff=3
set nojoinspaces
set updatetime=200
set backspace=eol,start,indent
set report=0
set noerrorbells
"persistent undo
set undolevels=120
set undofile
set undodir=$HOME/vim_undo

"tab setting
set tabpagemax=12
if has("gui_running")
    source $VIMRUNTIME/delmenu.vim
    set langmenu=en_us.utf-8
    source $VIMRUNTIME/menu.vim
    let mapleader = ','
    nmap <C-t> :tabnew<CR>
    nmap <leader>tn :tabnew<CR>
    nmap <leader>tc :tabclose<CR>
    "remove gui menubar
    set guioptions-=m
    set guioptions-=T
    set guioptions-=r
    set guioptions-=l
    set guioptions-=L
    au InsertLeave * se nocul
    au InsertEnter * se cul
else
    if &term == 'xterm' || &term == 'screen'
        set t_Co=256
        au InsertEnter * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape ibeam"
        au InsertLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape block"
        au VimLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape ibeam"
        hi clear SpellBad
        hi SpellBad cterm=undercurl
    endif 
endif

function! ShortTabLabel ()
    let bufnrlist = tabpagebuflist (v:lnum)
    let label = bufname (bufnrlist[tabpagewinnr (v:lnum) -1])
    let filename = fnamemodify (label, ':t')
    return filename
endfunction

set guitablabel=%{ShortTabLabel()}
"auto indent
au Bufwrite,FileReadPre * call FormatIndent()
"local cd dir
au BufEnter * lcd %:p:h 
au BufNew * let b:winVerticalZoomed = 0 | let b:winHorizontalZoomed = 0
"auto set number"
set number
au FocusLost * call SetNumber()
au FocusGained * call SetRelativeNumber()
au InsertEnter * call SetNumber()
au InsertLeave * call SetRelativeNumber()
"no number for plug-in
au FileType tagbar call NoNumber() | setl nospell
au FileType nerdtree call NoNumber()| setl nospell
au FileType gundo call NoNumber()| setl nospell
au FileType diff call NoNumber()| setl nospell
au FileType qf setl nospell 
"map <C-[> to <C-o> in help file"
au FileType help :nnoremap <buffer> <C-[> <C-o>
au FileType help :nnoremap <buffer> q :q<CR>
au FileType help call SetNumber()
"MRU quick select"
au FileType mru call QuickSelectMap()

au BufReadPost * call RestoreCursorPos()
function! NeoCache()
    :NeoCompleteTagMakeCache
    :NeoCompleteIncludeMakeCache
    :NeoCompleteBufferMakeCache
endfunc
"au BufNew * :call NeoCache()

"status line
hi CurrentLine guibg=#424242 ctermbg=238
hi CursorLine guibg=#424242 ctermbg=238
set cursorline
au WinLeave * set nocursorline
au WinEnter * set cursorline
au InsertEnter * hi CursorLine guibg=#283638 ctermbg=236
au InsertLeave * hi CursorLine guibg=#424242 ctermbg=238 | set cursorline
au InsertEnter * hi CurrentLine guibg=#283638 ctermbg=236
au InsertLeave * hi CurrentLine guibg=#424242 ctermbg=238 | set cursorline
au InsertEnter * hi User7 guifg=#070707 guibg=#a3bd29 ctermfg=232 ctermbg=149
au InsertLeave * hi User7 guifg=#d0d0d0 guibg=#313131 ctermfg=252 ctermbg=236
"colors
hi User1 guifg=#ae81ff guibg=#313131 ctermfg=141 ctermbg=236 
hi User2 guifg=#fd971f guibg=#212121 ctermfg=208 ctermbg=235
hi User3 guifg=#66d9ef guibg=#313131 ctermfg=81 ctermbg=236 
hi User4 guifg=#fd971f guibg=#040404 ctermfg=208 ctermbg=232 
hi User5 guifg=#eeee40 guibg=#313131 ctermfg=227 ctermbg=236 
hi User6 guifg=#e0e0e0 guibg=#040404 ctermfg=254 ctermbg=232 
hi User7 guifg=#d0d0d0 guibg=#313131 ctermfg=252 ctermbg=236
hi User8 guifg=#eeeeee guibg=#ac0317 ctermfg=255 ctermbg=124


set statusline =
set statusline +=%1*[%n]\ 
set statusline +=%6*\ %f\ %<
set statusline +=%2*%y%m
set statusline +=%6*\ %{&ff}\ \|\ %{(&fenc==\"\"?&enc:&fenc)}\ 
set statusline +=%7*%=%{strftime('%H:%M')}\ 
set statusline +=%8*%{ErrorSign()}
set statusline +=%3*\ [
set statusline +=%1*%b
set statusline +=%5*\ 0x%B
set statusline +=%3*]\ 
set statusline +=%4*\ %l
set statusline +=%6*\/\%L,
set statusline +=%4*%c%V\ 
set statusline +=%3*\ %P\ 

hi SyntasticErrorSign guifg=#eeeeee guibg=#ac0317 ctermfg=255 ctermbg=124
hi SyntasticWarningSign guifg=#040404 guibg=#66c9af ctermfg=232 ctermbg=79
hi qfLineNr guifg=#797979 ctermfg=244
hi qfError guifg=#eeeeee guibg=#ac0317 ctermfg=255 ctermbg=124
hi diffRemoved guifg=#ff8888  ctermfg=174 
hi diffAdded guifg=#88ff88  ctermfg=120 
hi diffNewFile guifg=#d0d0d0 ctermfg=252
hi diffFile guifg=#fd971f ctermfg=208
"plug-in  setting
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"css color
let g:cssColorVimDoNotMessMyUpdatetime = 1
"VimWiki
let g:vimwiki_camel_case = 0
let g:vimwiki_CJK_length = 1
let g:vimwiki_valid_html_tags='b,i,s,u,sub,sup,kbd,br,hr,div,del,code,span'
let s:vimwiki_defaults_diary_header = 'Diary'
nnoremap <S-F4> :Vimwiki2HTML<CR>
nnoremap <S-F5> :VimwikiAll2HTML<CR>
nnoremap <leader>wtt :VimwikiTable


"NERDTree
let NERDTreeShowBookmarks = 1
let NERDTreeWinSize = 24
let NERDTreeChDirMode = 2
let NERDTreeAutoCenter = 1
let NERDTreeAutoCenterThreshold = 5

"Tagbar
let g:tagbar_width = 24
let g:tagbar_indent = 1
let g:tagbar_autoshowtag = 1
let g:tagbar_iconchars = ['+', '-']  
let g:tagbar_sort = 0

"neosnippets
if has("win32")
    let g:neosnippet#enable_snipmate_compatibility = 1
    let g:neosnippet#snippets_directory='$VIM/vimfiles/bundle/neosnippet/snippets'
    imap <C-d> <Plug>(neosnippet_expand_or_jump)
endif

"SuperTab
let g:SuperTabNoCompleteAfter = [',',';','\s']
let g:SuperTabDefaultCompletionType = "\<C-n>"
"fenceView
let g:fencview_autodetect = 1

"autoclose
let g:AutoClosePairs = "() {} [] \""
let g:AutoCloseProtectedRegions = []
"Syntastic 
let g:syntastic_auto_loc_list = 0
"finally disabled
let g:syntastic_check_on_wq = 0
let g:syntastic_disabled_filetypes = "*"
let g:syntastic_mode_map = { "mode": "passive",
            \ "active_filetypes": [],
            \ "passive_filetypes": [] }

"GUndo
let g:gundo_width = 24
let g:gundo_preview_height = 16
let g:gundo_right = 0
let g:gundo_preview_bottom = 1
let g:gundo_help = 0
"neocomplete
if has("win32")
    let g:acp_enableAtStartup = 0
    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#use_vimproc = 1
    let g:neocomplete#enable_smart_case = 1
    let g:neocomplete#enable_auto_select = 1
    let g:neocomplete#release_cache_time = 300
    let g:neocomplete#force_overwrite_completefunc = 1
    let g:neocomplete#sources#buffer#cache_limit_size = 12097152
    au VimEnter * call neocomplete#initialize()
endif

function! PhpSyntaxOverride()
    hi! def link phpDocTags  phpDefine
    hi! def link phpDocParam phpType
endfunction

augroup phpSyntaxOverride
    autocmd!
    autocmd FileType php call PhpSyntaxOverride()
augroup END
