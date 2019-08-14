" vim: set foldmarker={,} foldlevel=0 foldmethod=marker:

" Basic Settings {
set nocompatible
"set term=xterm
set t_Co=256
" }

" Vundle Settings {
" To Install Vundle:
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
" vim +PluginInstall +qall
filetype off
set rtp+=$VIM/vimfiles/bundle/Vundle.vim/
call vundle#rc()
Plugin 'gmarik/vundle'
" Custom Plugins {
Plugin 'Smart-Home-Key'
Plugin 'SingleCompile'
Plugin 'bufexplorer.zip'
Plugin 'a.vim'
Plugin 'w0rp/ale'
Plugin 'bling/vim-airline'
Plugin 'kien/ctrlp.vim'
Plugin 'ledger/vim-ledger'
Plugin 'flazz/vim-colorschemes'
" Plugin 'davidhalter/jedi-vim'
Plugin 'ervandew/supertab'
Plugin 'scrooloose/nerdtree'
Plugin 'Yggdroot/LeaderF'
" Plugin 'Valloric/YouCompleteMe'
" Plugin 'git://vim-latex.git.sourceforge.net/gitroot/vim-latex/vim-latex'
" }
filetype plugin indent on
" }

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
"set encoding=utf-8
"set langmenu=zh_CN.UTF-8
"set langmenu=en_US.utf8
"lan en
if has("multi_byte")
	" if &termencoding == ""
	" 	let &termencoding = &encoding
	" endif
	setglobal fileencoding=utf-8
	" Uncomment to have 'bomb' on by default for new files.
	" Note, this will not apply to the first, empty
	" buffer created at Vim startup.
	" setglobal bomb
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
" set laststatus=2

" 自动识别颜色方案
if (has("gui_running"))
	set guioptions=egrL
	color torte
	set nowrap
	set lines=60
	set columns=135
else
	"colo molokai
	colo ron
	set wrap
endif
" 自动全屏
if has('win32')
	au GUIEnter * simalt ~x
else
	au GUIEnter * call MaximizeWindow()
endif

function! MaximizeWindow()
	silent !wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
endfunction

" 文件类型识别
" filetype plugin indent off
" 开启语法加亮
syntax on
" 设置字体
set guifont=Consolas:h15

" 显示行号
set number
" 去掉响铃
set vb
" 使用sublime主题
syntax enable
colorscheme Monokai

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
set listchars=tab:>-,trail:-
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
" autocmd FileType python setlocal completeopt-=preview
autocmd FileType python set tabstop=4
autocmd FileType python set shiftwidth=4
autocmd FileType python set smarttab
autocmd FileType python set noexpandtab
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
" 转到默认目录
"cd D:\Doc\sources\ACMICPC

" ------------------------
"   程序相关
" ------------------------
func Compile() 
	exec "silent w"
	if (findfile("Makefile") == "")
		let ext = expand("%:e")
		if ext == "cpp"
			set makeprg=g++\ -Wall\ -Wextra\ -g\ %:r.cpp\ -o\ %:r
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
	if ext == "java"
		exec "! start /B /D\"%:p:h\" java %:r"
	else
		exec "!gdb %:r.exe"
	endif
endfunc

func RunProg()
	"if (findfile(expand("%:p:r.exe")) == "")
	"    echo "Executable file not found."
	"    return
	"endif
	if (findfile("input") == "")
		echo "Input file not found."
		return
	endif
	silent exec "!./%:r< %:p:h/input  > %:p:h/output"
	exec "e %:p:h/output"
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
"   快捷键设
" ------------------------
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
command -nargs=+ Svnblame :!start tortoiseProc /command:blame /Path:<args>  /startrev:1 /endrev:HEAD
command -nargs=+ Svncleanup :!start tortoiseProc /command:cleanup /Path:<args>
command -nargs=+ Svndiff :!start tortoiseProc /command:diff /Path:<args>

" ------------------------
"   插件设置
" ------------------------
" 插件快捷键
map <F2> :BufExplorer<CR>
highlight Pmenu         ctermbg=13  guifg=#ffcd00   guibg=#1e1e1e
highlight PmenuSel      ctermbg=7   guifg=#7e7eae   guibg=#2e2e2e

set shellslash
let g:tex_flavor = 'latex'
let g:Tex_FormatDependency_pdf = 'pdf'
let g:Tex_CompileRule_pdf = 'pdflatex $*'
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_ViewRule_pdf = 'C:\Softwares\FoxitReader\Foxit Reader.exe'
set grepprg=grep\ -nH\ $*
"let g:miniBufExplMapWindowNavVim = 1
"let g:miniBufExplMapWindowNavArrows = 1
"let g:miniBufExplMapCTabSwitchBufs = 1
"let g:miniBufExplModSelTarget = 1
set t_Co=256
set autochdir

set hidden
set novisualbell

let mapleader=","

" nnoremap <leader>f :FufFile <C-r>=expand('%:~:.')[:-1-len(expand('%:~:.:t'))]<CR><CR>
" nnoremap <leader>b :FufBuffer<CR>

let NERDTreeWinPos = "left"
let NERDTreeWinSize = 31 "size of the NERD tree
map <F7> :NERDTreeMirror<CR>
map <F7> :NERDTreeToggle<CR>

nmap <C-j> :bp<CR>
imap <C-j> <C-r>:bp<CR>
nmap <C-k> :bn<CR>
imap <C-k> <C-r>:bn<CR>

" Plugin: Smart-Home { 
nmap <silent> <Home> :SmartHomeKey <CR>
imap <silent> <Home> <C-O>:SmartHomeKey<CR>
" }

" Plugin: SingleCompile {
let common_run_command = './$(FILE_TITLE)$'
call SingleCompile#SetCompilerTemplate('c', 'gcc', 'GNU C Compiler',
			\'gcc', '-g -Wall -o $(FILE_TITLE)$', common_run_command)
call SingleCompile#SetCompilerTemplate('cpp', 'g++',
			\'GNU C++ Compiler', 'g++', '-g -Wall -o $(FILE_TITLE)$',
			\common_run_command)
nmap <F9> :SCCompile<cr>:cw<cr>
nmap <F10> :SCCompileRun<cr>
" }

" Plugin: Buf Explorer {
map <F2>    :BufExplorer<CR>
" }

" Plugin: vim-airline {
set laststatus=2
"let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#whitespace#mixed_indent_algo = 1
"let g:airline#extensions#whitespace#checks = [ 'indent' ]
let g:airline#extensions#whitespace#checks = [ ]
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
let g:ale_python_flake8_options = '-m flake8 --builtins=_tr'
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
" }

" Plugin: jedi-vim {
let g:jedi#popup_on_dot = 0
" }

" Plugin: supertab {
let g:SuperTabDefaultCompletionType = "context"
" }

" Plugin: ctags {
set tags=tags;
set autochdir
" }

" Plugin: Leaderf {
" map <C-f>: Leaderf rg -e
" }
