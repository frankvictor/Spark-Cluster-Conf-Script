set nocompatible
syntax on
if has("autocmd")
		filetype plugin indent on
		augroup vimrcEx
				au!
				autocmd FileType text setlocal textwidth=78
				autocmd BufReadPost *
										\ if line("'\"") > 1 && line("'\"") <= line("$") |
										\ exe "normal! g`\"" |
										\ endif
		augroup END
else
		set autoindent
endif " has("autocmd")
set tabstop=2
set shiftwidth=2
set vb t_vb=
set nowrap
set hlsearch
set incsearch
set backspace=indent,eol,start whichwrap+=<,>,[,]
set guifont=Arial\ monospaced\ for\ SAP\ 10
set gfw=YouYuan\ 10
set nu
set t_Co=256 

"设置编码格式
"set encoding=utf-8
"set fenc=cp936
"set fileencodings=cp936,ucs-bom,utf-8
if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'
		set ambiwidth=double
endif
set nobomb


"进行版权声明的设置
"添加或更新头
map <F4> ms:call TitleDet()<cr>'s
function AddTitle()
		call append(0,"/*")
		call append(1," * Author: frankvictor-frankvictor@qq.com")
		call append(2," * QQ: 543741935")
		call append(3," * Last modified: ".strftime("%Y-%m-%d %H:%M"))
		call append(4," * Filename: ".expand("%:t"))
		call append(5," * Description: ")
		call append(6," */")
		call append(7,"")
		echohl WarningMsg | echo "Successful in adding the copyright." | echohl None
endf
"更新最近修改时间和文件名
function UpdateTitle()
		normal m'
		execute '/ * *Last modified:/s@:.*$@\=strftime(":\t%Y-%m-%d %H:%M")@'
		normal ''
		normal mk
		execute '/ * *Filename:/s@:.*$@\=": ".expand("%:t")@'
		execute "noh"
		normal 'k
		echohl WarningMsg | echo "Successful in updating the copy right." | echohl None
endfunction
"判断前10行代码里面，是否有Last modified这个单词，
"如果没有的话，代表没有添加过作者信息，需要新添加；
"如果有的话，那么只需要更新即可
function TitleDet()
		let n=1
		"默认为添加
		while n < 10
				let line = getline(n)
				if line =~ '^\s\*\s*\S*Last\smodified:\S*.*$'
						call UpdateTitle()
						return
				endif
				let n = n + 1
		endwhile
		call AddTitle()
endfunction

"进行make的设置
map <F6> :!make<CR>
map <C-F6> :!make clean<CR>

map <F7> :!gcc % && ./a.out<CR>
map <F11> :!g++ % && ./a.out<CR>
"map <C-F7> :!gcc % && ./a.out<CR>

"mapping TlistToggle to F8
nnoremap <silent> <F8> :TlistToggle<CR> 
let NERDShutUp=1

"NERDTree settings
let NERDChristmasTree=0
"let NERDTreeQuitOnOpen=1
nnoremap <silent> <F5> :NERDTreeToggle<CR>

"function to MaximizeToggle one split
nnoremap <C-W>O :call MaximizeToggle ()<CR>
nnoremap <C-W>o :call MaximizeToggle ()<CR>
nnoremap <C-W><C-O> :call MaximizeToggle ()<CR>

function! MaximizeToggle()
	if exists("s:maximize_session")
		exec "source " . s:maximize_session
		call delete(s:maximize_session)
		unlet s:maximize_session
		let &hidden=s:maximize_hidden_save
		unlet s:maximize_hidden_save
	else
		let s:maximize_hidden_save = &hidden
		let s:maximize_session = tempname()
		set hidden
		exec "mksession! " . s:maximize_session
		only
	endif
endfunction

map <C-F9> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
map <C-F10> :!cscope -R<CR>

":colorscheme blue
let NERDTreeIgnore=['\.o$','\~$']

let Tlist_Use_Right_Window=1
