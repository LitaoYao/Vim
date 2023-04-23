" vim: set foldmarker={,} foldlevel=0 foldmethod=marker:

" Basic Settings {
set nocompatible
" set term=xterm
set t_Co=256
" }

call plug#begin('~/vimfiles/plugged')
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'ludovicchabant/vim-gutentags'
" Plug 'chenkaie/smarthomekey.vim'
" Plug 'jlanzarotta/bufexplorer'
Plug 'vim-scripts/a.vim'
Plug 'dense-analysis/ale'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ledger/vim-ledger'
Plug 'flazz/vim-colorschemes'
Plug 'ervandew/supertab'
"Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'preservim/nerdcommenter'
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
Plug 'dyng/ctrlsf.vim'
" Plug 'tikhomirov/vim-glsl'
Plug 'beyondmarc/hlsl.vim'
" Plug 'Yggdroot/indentLine'
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Plug 'junegunn/fzf.vim'
Plug 'SirVer/ultisnips'
Plug 'iamcco/mathjax-support-for-mkdp'
Plug 'iamcco/markdown-preview.nvim', {'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'voldikss/vim-floaterm'
if has('nvim')
	Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
	" Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
else
	Plug 'Shougo/defx.nvim'
	" Plug 'Shougo/deoplete.nvim'
	Plug 'roxma/nvim-yarp'
	Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'kristijanhusak/defx-icons'
" Plug 'liuchengxu/vista.vim'
Plug 'sheerun/vim-polyglot'
Plug 'vim-scripts/wimproved.vim'
Plug 'puremourning/vimspector'
Plug 'voldikss/vim-translator'
Plug 'mhinz/vim-startify'
Plug 'OmniSharp/omnisharp-vim'
" Plug 'skywind3000/vim-auto-popmenu'
" Plug 'skywind3000/vim-dict'
" Plug 'yegappan/lsp'
call plug#end()

if $TERM == 'screen'
	set term=xterm
endif
" ------------------------
"   基本设置
" ------------------------
" vi 不兼容模式
set nocp

" ------------------------
"   编码相关
" ------------------------
set encoding=utf-8
set termencoding=utf-8
"set langmenu=zh_CN.UTF-8
set langmenu=en_US.utf8
let $LANG='en_US'
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

if has("multi_byte")
	" if &termencoding == ""
	" 	let &termencoding = &encoding
	" endif
	setglobal fileencoding=utf-8
	" Uncomment to have 'bomb' on by default for new files.
	" Note, this will not apply to the first, empty
	" buffer created at Vim startup.
	setglobal bomb
	set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
endif

" ------------------------
"   显示相关
" ------------------------
" 显示光标位置
set ruler
" 显示括号配对
set showmatch
" 搜索结果高亮
set hlsearch
set incsearch
" 防止单词间断行
set linebreak
" 总是显示状态栏
set statusline=
set laststatus=2

" 自动识别颜色方案
if (has("gui_running"))
	set guioptions=eg
	" color torte
	set nowrap
	set lines=60
	set columns=150
else
	"colo molokai
	colo ron
	set wrap
endif

" 自动全屏
" if has('win32')
" 	au GUIEnter * simalt ~x
" else
" 	au GUIEnter * call MaximizeWindow()
" endif


function! MaximizeWindow()
	silent !wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
endfunction

" 文件类型识别
" filetype plugin indent off
" 开启语法加亮
syntax on
syntax enable
set re=1
set lazyredraw
set synmaxcol=256
syntax sync minlines=256

" 设置字体
if (has("gui_running"))
    set guifont=Consolas_NF:h14:cANSI
else
	set guifont=Consolas:h14:cANSI
endif

" 显示行号
set number
" 去掉响铃
set vb
" 使用sublime主题
colorscheme solarized8_dark_high
" colorscheme gruvbox
set background=dark

" ------------------------
"   格式相关设置
" ------------------------
" tab 宽度
set tabstop=4
" 自动缩进宽度
set shiftwidth=4
" 自动识别 backspace 删除空格数目
set smarttab
" 将 tab 替换成空格
set noexpandtab
" 显示tab
set list
set listchars=tab:\¦\ 
" 设定tab为灰色
highlight LeaderTab guifg=#666666
" 匹配tab
match LeaderTab /\t/
" 打开 doxygen 高亮
let g:load_doxygen_syntax=1
" 打开 c 风格缩进
set cindent
" 打开自动缩进
set autoindent
" 打开智能缩进
set smartindent
" 设置 c 自动缩进选项
set cinoptions=:0g0t0(susj1
" 行宽度
" set textwidth=78
" 设置在可断行符号处断行
set linebreak
" 设置代码折叠方式
set formatoptions+=mB
" 识别 unicode 特殊全角字符宽度
set ambiwidth=double
autocmd FileType python setlocal completeopt-=preview
autocmd FileType python set tabstop=4
autocmd FileType python set shiftwidth=4
autocmd FileType python set smarttab
autocmd FileType python set noexpandtab

autocmd FileType lua set expandtab

" ------------------------
"   编辑相关设置
" ------------------------
" 设置 backspace 缩进/跨行/插入
set backspace=indent,eol,start
" 设置可以跨行的按键
set whichwrap=b,s,<,>,[,]
" 在所有模式启用鼠标
set mouse=a
" 设置启动选择模式的方式
set selectmode=
" 设置鼠标模式
set mousemodel=popup
" 设置使用 shift 选择区块
set keymodel=startsel,stopsel
" 选择时候不包括光标位置
set selection=exclusive
" 查找时不区分大小写
set ignorecase
" 高亮光标所在列
set cursorcolumn
set cursorline
" 智能 Home 键
function SmartHome()
	let curcol = col(".")
	if curcol == 1 || curcol > indent(".") + 1
		normal ^
	else
		normal 0
	endif
	return ""
endfunction

" ------------------------
"   杂类设置
" ------------------------
" 自动完成的方式
set wildmode=longest,list,full
" 自动完成时菜单提示
set wildmenu
" 打开拼写检查
"set spell
" 取消preivew补全
set completeopt-=preview

" ------------------------
"   自动保存退出时vim状态
" ------------------------
" set sessionoptions=buffers,curdir,folds,tabpages
" " 退出时自动保存 注意目录要存在
" autocmd VimLeave * mks! $HOME/.vim/session/Session.vim
" " 加载时自动读取
" autocmd VimEnter * :call s:ReadSession()
" function s:ReadSession()
" 	let session_file = $HOME . "/.vim/session/Session.vim"
" 	if filereadable( session_file )
" 		execute "so " . session_file
" 	endif
" endfunction

" ------------------------
"   程序相关
" ------------------------
" Python

let g:python3_host_prog = 'C:\Users\bobyao\AppData\Local\Programs\Python\Python311\python.exe'
set pythonthreehome=C:\\Users\\bobyao\\AppData\\Local\\Programs\\Python\\Python311
set pythonthreedll=C:\\Users\\bobyao\\AppData\\Local\\Programs\\Python\\Python311\\python311.dll

func Compile() 
	exec "silent w"
	if (findfile("Makefile") == "")
		let ext = expand("%:e")
		if ext == "cpp"
			set makeprg=g++\ -Wall\ -Wextra\ -g\ -std=c++11\ %:r.cpp\ -o\ %:r
		endif
		if ext == "c"
			set makeprg=gcc\ -Wall\ -Wextra\ -lm\ -g\ %:r.c\ -o\ %:r
		endif
		if ext == "java"
			set makeprg=javac\ -Xlint:unchecked\ %:r.java
		endif
	else
		set makeprg=make
	endif
	exec "make"
	exec "cw"
endfunc

func RunDebug() 
	let ext = expand("%:e")
	if ext == "cpp"
		exec "!start gdb %:r"
	endif
	if ext == "c"
		exec "!start gdb %:r"
	endif
	if ext == "java"
		exec "! start /B /D\"%:p:h\" java %:r"
	endif
endfunc

func RunProg()
	if (findfile("input") == "")
		silent exec "!start %:r > %:p:h/output"
	else
		silent exec "!%:r %:p:h/input > %:p:h/output"
		exec "e %:p:h/output"
	endif
endfunc

func ZOJSymbol()
	exec '%s/&/\&amp;/g'
	exec '%s/>=/\&ge;/g'
	exec '%s/<=/\&le;/g'
	exec '%s/</\&lt;/g'
	exec '%s/>/\&gt;/g'
endfunc

func ZOJParam(x)
	let x = "%s#\\<" . a:x . "\\>#<i>" . a:x . "</i>#g"
	exec x
endfunc

func CleanVerilog()
	exec ':%s/<=/ <= /g'
	exec ':%s/>=/ >= /g'
	exec ':%s/==/ == /g'
	exec ':%s/!=/ != /g'
	exec ':%s/\([^=<>!]\)=\([^=<>!]\)/\1 = \2/g'
	exec ':%s/,/, /g'
	exec ':%s/\s\+/ /g'
	exec ':%s/\s\+$//g'
	exec ':%s/^\s\+//g'
endfunc

" ------------------------
"   快捷键设置
" ------------------------
"  全选
map <C-a> ggVG
" 保存当前文件
map <C-s> :w<CR>
" 复制
map <C-c> "+y<CR>
" 粘贴
"map <C-v> "+p<CR>
map! <C-v> <C-r>+
" 窗口切换
map <C-Tab> :tabnext<CR>
" 执行当前文件
map <C-b> : !start %<CR>
" 调试
map <F8> :call RunDebug()<CR>
" 编译
map <F9> :call Compile()<CR>
" 查看输入
map <F10> :e %:p:h/input<CR>
" 查看输出
map <F11> :call RunProg()<CR>
" 智能 Home 键
nmap <silent><Home>     :call SmartHome()<CR>
imap <silent><Home>     <C-r>=SmartHome()<CR>
vmap <silent><Home>     <Esc>:call SmartHome()<CR>msgv`s
" TortoiseSVN
command -nargs=+ Svnup :!start tortoiseProc /command:update /Path:<args>
command -nargs=+ Svnlog :!start tortoiseProc /command:log /Path:<args>
command -nargs=+ Svncommit :!start tortoiseProc /command:commit /Path:<args>
command -nargs=+ -range Svnblame :!start tortoiseProc /command:blame /Path:<args>  /startrev:1 /endrev:HEAD /line:<line1>
command -nargs=+ Svncleanup :!start tortoiseProc /command:cleanup /Path:<args>
command -nargs=+ Svndiff :!start tortoiseProc /command:diff /Path:<args>
command -nargs=+ Svnrevert :!start tortoiseProc /command:revert /Path:<args>

" ------------------------
"   插件设置
" ------------------------
" 插件快捷键
highlight Pmenu         ctermbg=13  guifg=#ffcd00   guibg=#1e1e1e
highlight PmenuSel      ctermbg=7   guifg=#7e7eae   guibg=#2e2e2e

set shellslash
set grepprg=grep\ -nH\ $*

set hidden
set novisualbell

let mapleader=","

nmap <C-j> :bp<CR>
imap <C-j> <C-r>:bp<CR>
nmap <C-k> :bn<CR>
imap <C-k> <C-r>:bn<CR>

" " Plugin: NERDTree {
" let NERDTreeWinPos = "left"
" let NERDTreeWinSize = 31 "size of the NERD tree
" map <F7> :NERDTreeMirror<CR>
" map <F7> :NERDTreeToggle<CR>
" let NERDTreeMinimalUI=1
" let NERDTreeDirArrowExpandable=""
" let NERDTreeDirArrowCollapsible=""
" " }

" " Plugin: SingleCompile {
" let common_run_command = './$(FILE_TITLE)$'
" call SingleCompile#SetCompilerTemplate('c', 'gcc', 'GNU C Compiler',
" 			\'gcc', '-g -Wall -o $(FILE_TITLE)$', common_run_command)
" call SingleCompile#SetCompilerTemplate('cpp', 'g++',
" 			\'GNU C++ Compiler', 'g++', '-g -Wall -o $(FILE_TITLE)$',
" 			\common_run_command)
" nmap <F9> :SCCompile<cr>:cw<cr>
" nmap <F10> :SCCompileRun<cr>
" " }

" " Plugin: Buf Explorer {
" map <F2> :BufExplorer<CR>
" let g:bufExplorerDefaultHelp=0
" let g:bufExplorerDisableDefaultKeyMapping=1
" " }

" Plugin: vim-airline {
set laststatus=2
set ttimeoutlen=50
let g:airline#extensions#disable_rtp_load = 1
let g:airline_extensions = []
"let g:airline#extensions#whitespace#mixed_indent_algo = 1
"let g:airline#extensions#whitespace#checks = [ 'indent' ]
"let g:airline#extensions#whitespace#checks = [ ]
let g:airline_powerline_fonts=1
let g:Powerline_symbols='fancy'
let g:airline_theme='solarized_flood'
" let g:airline_theme='wombat'
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
" let g:airline_left_sep = ''
" let g:airline_left_alt_sep = ''
" let g:airline_right_sep = ''
" let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.colnr = ''
let g:airline_symbols.dirty='⚡'
" }

" Plugin: ctrlp {
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_regexp = 1
let g:ctrlp_max_files = 0
let g:ctrlp_custom_ignore = 'build$\|doc$\|.git$\|.svn$\|obj$\|.log$'
let g:ctrlp_root_markers = ['.project']
" }

" Plugin: vim-ledger {
let g:ledger_bin = 'hledger'
" }

" Plugin: ale {
let g:ale_python_flake8_executable = 'python'
let g:ale_python_flake8_options = '-m flake8 --ignore=E101,E117,E12,E20,E22,E23,E24,E25,E26,E30,E402,E501,E502,E722,E731,W191,W293,W292,W391 --builtins=_tr'
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_lint_on_insert_leave = 1
" 显示状态栏
let g:ale_sign_column_always = 0
" 不需要高亮行
let g:ale_set_highlights = 0
" 文件内容发生变化时不进行检查
let g:ale_lint_on_text_changed = 'never'
" 打开文件时不进行检查
let g:ale_lint_on_enter = 0
" 设置图标
let g:ale_sign_error = '✗' "❌
let g:ale_sign_warning = '⚡'
" 默认linters
" , 'mypy', 'pylint']
let g:ale_linters = {
	\ 'python': ['flake8'],
	\ 'cpp': ['gcc'],
	\ 'c': ['gcc'],
\}
" }

" Plugin: jedi-vim {
let g:jedi#popup_on_dot = 0
" }

" Plugin: supertab {
let g:SuperTabDefaultCompletionType = "context"
" }

" Plugin: ctags {
set tags=.tags;
set autochdir
" }

" Plugin: Leaderf {
nnoremap <leader>p :LeaderfFunction<CR>
nnoremap <leader>o :LeaderfBufTag<CR>
nnoremap <leader>l :LeaderfLine<CR>
let g:Lf_WildIgnore = {
	\ 'dir': ['.svn','.git','.hg', 'Temp'],
	\ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[con]','*.bin', '*.dll', '*.pdb',
	\		'*.jpg','*.png','*.csb','*.dds','*.tga','*.ktx','*.astc','*.pvr', '*.bc7',
	\		'*.scn[_flag_32]','*.chunk*','*.area',
	\		'*.ags','*.gim','*.gis','*.mesh','*.mtg','*.sfx',
	\		'*.doc[x]', '*.xls[x]', '*.ppt[x]',
	\		'*.meta',]
	\}
let g:Lf_WindowPosition = 'popup'
let g:Lf_RootMarkers = ['.vimroot', '.svn', '.git', '.hg']
let g:Lf_WorkingDirectoryMode = 'ac'
" let g:Lf_StlColorscheme = 'default'
" let g:Lf_PopupColorscheme = 'default'
let g:Lf_StlColorscheme = 'gruvbox_material'
let g:Lf_PopupColorscheme = 'gruvbox_default'
" let g:Lf_StlSeparator = { 'left': '', 'right': '' }
let g:Lf_StlSeparator = { 'left': '', 'right': '' }
let g:Lf_PreviewCode = 1
let g:Lf_PreviewInPopup = 1
let g:Lf_ShowRelativePath = 0
let g:Lf_PopupWidth = 0.75
let g:Lf_PopupHeight = 0.5
" }

" Plugin: CtrlSF {
nnoremap <C-S-f> :CtrlSF<Space>
let g:ctrlsf_auto_preview = 1
let g:ctrlsf_absolute_file_path = 1
let g:ctrlsf_extra_root_markers = ['.project']
let g:ctrlsf_default_root = 'project+fw'
let g:ctrlsf_ignore_dir = ['tmp', 'log', 'bin']
" }

" Plugin: glsl {
autocmd! BufNewFile,BufRead *.glsl,*.fp,*.vp,*.frag.*.vert set ft=glsl
" }

" Plugin: hlsl {
autocmd! BufNewFile,BufRead *.fx,*.hlsl,*.fxh,*.spzs,*.hlsl,*.gfx,*.spzs,*.vs,*.fs,*.ps,*.nfx,*.nsf,*.usf,*.ush set ft=hlsl
" }

" " Plugin: vim-gutentags {
" " gutentags搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归 "
" let g:gutentags_project_root = ['.root', '.svn', '.git', '.project']
" " 所生成的数据文件的名称 "
" let g:gutentags_ctags_tagfile = '.tags'
" " 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录 "
" let s:vim_tags = expand('~/.cache/tags')
" let g:gutentags_cache_dir = s:vim_tags
" " 检测 ~/.cache/tags 不存在就新建 "
" if !isdirectory(s:vim_tags)
"    silent! call mkdir(s:vim_tags, 'p')
" endif
" " 配置 ctags 的参数 "
" let g:gutentags_ctags_extra_args = []
" let g:gutentags_ctags_extra_args += ['--fields=+aiKSz', '--extra=+q']
" let g:gutentags_ctags_extra_args += ['--languages=python,c,c++,java']
" let g:gutentags_ctags_extra_args += ['--c++-kinds=+pxI']
" let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
" let g:gutentags_ctags_extra_args += ['--langmap=c++:+.mm,java:+.in']
" " 如果使用 universal ctags 需要增加下面一行
" let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']
" " }

" " Plugin: indentLine {
" let g:indentLine_enabled = 1
" let g:indentLine_concealcursor = 'inc'
" let g:indentLine_conceallevel = 2
" let g:indentLine_setColors = 0
" let g:indentLine_color_gui = '#A4E57E'
" " }

" " Plugin: fzf {
" nnoremap <C-p> :Files<CR>
" " nnoremap <leader>b :Buffers<CR>
" " nnoremap <leader>l :BLines<CR>
" let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
" let $FZF_DEFAULT_OPTS = '
     "\ --layout=reverse
     "\ --color fg:252,bg:233,hl:67,fg+:252,bg+:235,hl+:81
     "\ --color info:144,prompt:161,spinner:135,pointer:135,marker:118
     "\'
" " let g:fzf_preview_window = 'right:60%'
" " }

" Plugin: Ultisnips {
let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<c-b>"
" let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
" }

" Plugin: Floaterm {
let g:floaterm_keymap_new = '<leader>tn'
let g:floaterm_keymap_next = '<leader>tk'
let g:floaterm_keymap_prev = '<leader>tj'
let g:floaterm_keymap_toggle = '<leader>tt'
let g:floaterm_keymap_kill = '<leader>tq'
tnoremap <leader><Esc> <C-\><C-n>
tmap <S-Insert> <C-W>"+
let g:floaterm_width=0.9
let g:floaterm_height=0.9
" }

" Plugin: defx {
nnoremap <leader>d :Defx -columns=icons:indent:filename:type<CR>
nnoremap <leader>e :Defx `expand('%:p:h')` -columns=icons:indent:filename:type<CR>
autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
	set nonumber
	" Define mappings
	nnoremap <silent><buffer><expr> <CR>
		\ defx#is_directory() ?
		\ defx#do_action('open_directory') :
		\ defx#do_action('multi', ['quit', 'open'])
	nnoremap <silent><buffer><expr> c
		\ defx#do_action('copy')
	nnoremap <silent><buffer><expr> m
		\ defx#do_action('move')
	nnoremap <silent><buffer><expr> p
		\ defx#do_action('paste')
	nnoremap <silent><buffer><expr> l
		\ defx#is_directory() ?
		\ defx#do_action('open_directory') :
		\ defx#do_action('preview')
	nnoremap <silent><buffer><expr> E
		\ defx#do_action('open', 'vsplit')
	nnoremap <silent><buffer><expr> P
		\ defx#do_action('preview')
	nnoremap <silent><buffer><expr> o
		\ defx#do_action('open_tree', 'toggle')
	nnoremap <silent><buffer><expr> K
		\ defx#do_action('new_directory')
	nnoremap <silent><buffer><expr> N
		\ defx#do_action('new_file')
	nnoremap <silent><buffer><expr> M
		\ defx#do_action('new_multiple_files')
	nnoremap <silent><buffer><expr> C
		\ defx#do_action('toggle_columns',
		\                'mark:indent:icon:filename:type:size:time')
	nnoremap <silent><buffer><expr> S
		\ defx#do_action('toggle_sort', 'time')
	nnoremap <silent><buffer><expr> d
		\ defx#do_action('remove')
	nnoremap <silent><buffer><expr> r
		\ defx#do_action('rename')
	nnoremap <silent><buffer><expr> !
		\ defx#do_action('execute_command')
	nnoremap <silent><buffer><expr> x
		\ defx#do_action('execute_system')
	nnoremap <silent><buffer><expr> yy
		\ defx#do_action('yank_path')
	nnoremap <silent><buffer><expr> .
		\ defx#do_action('toggle_ignored_files')
	nnoremap <silent><buffer><expr> ;
		\ defx#do_action('repeat')
	nnoremap <silent><buffer><expr> h
		\ defx#do_action('cd', ['..'])
	nnoremap <silent><buffer><expr> ~
		\ defx#do_action('cd')
	nnoremap <silent><buffer><expr> q
		\ defx#do_action('quit')
	nnoremap <silent><buffer><expr> <Space>
		\ defx#do_action('toggle_select') . 'j'
	nnoremap <silent><buffer><expr> *
		\ defx#do_action('toggle_select_all')
	nnoremap <silent><buffer><expr> j
		\ line('.') == line('$') ? 'gg' : 'j'
	nnoremap <silent><buffer><expr> k
		\ line('.') == 1 ? 'G' : 'k'
	nnoremap <silent><buffer><expr> <C-l>
		\ defx#do_action('redraw')
	nnoremap <silent><buffer><expr> <C-g>
		\ defx#do_action('print')
	nnoremap <silent><buffer><expr> cd
		\ defx#do_action('change_vim_cwd')
endfunction

call defx#custom#option('_', {
	\ 'winwidth': 30,
	\ 'split': 'vertical',
	\ 'direction': 'topleft',
	\ 'show_ignored_files': 0,
	\ 'buffer_name': '',
	\ 'root_marker': '≡',
	\ 'toggle': 1,
	\ 'resume': 1
\ })

"call defx#custom#column('icon', {
	"\ 'directory_icon': '',
	"\ 'opened_icon': '',
	"\ 'root_icon': ' ',
"\ })
" }

" Plugin: nerdcommenter {
let g:NERDDefaultAlign = 'left'
let g:NERDSpaceDelims = 1
" }

" " Plugin: deoplete {
" let g:deoplete#enable_at_startup = 1
" " }

" Plugin: wimproved {
au GUIEnter * silent! WToggleClean
au GUIEnter * silent! WSetAlpha 255
" au GUIEnter * silent! WToggleFullscreen
map <S-F12> :WSetAlpha 210<CR>
map <C-F12> :WSetAlpha 255<CR>
map <F12> :call FullScreen()<CR>
func FullScreen()
	exec 'WToggleFullscreen'
	if has('win32')
		simalt ~x
	endif
endfunc
" }

" Plugin: startify {
let g:startify_lists = [
	\ { 'type': 'files',     'header': ['   MRU']            },
	\ { 'type': 'sessions',  'header': ['   Sessions']       },
	\ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
	\ { 'type': 'commands',  'header': ['   Commands']       },
\ ]
let g:startify_bookmarks = [
	\ { 'c': '~/_vimrc' },
\ ]
let g:startify_files_number = 10
let g:startify_fortune_use_unicode = 0
let g:startify_enable_special = 0
let g:startify_custom_header = 
	\startify#center(startify#fortune#cowsay('', '✧', '░', '✧', '✧', '✧', '✧'))
nnoremap <leader>s :Startify<CR>
" }

" Plugin: OmniSharp{
let g:OmniSharp_server_path = 'C:\Program Files\Omnisharp\OmniSharp.exe'
let g:OmniSharp_popup_position = 'center'
let g:OmniSharp_popup = 1
let g:OmniSharp_highlighting = 0
" }

" Plugin: vim-auto-popmenu{
" enable this plugin for filetypes, '*' for all files.
" let g:apc_enable_ft = {'*':1}
"
" " source for dictionary, current or other loaded buffers, see ':help cpt'
" set cpt=.,k,w,b
"
" " don't select the first item.
" set completeopt=menu,menuone,noselect
"
" " suppress annoy messages.
" set shortmess+=c
" }
