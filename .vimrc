""2014-01-20: nmap <C-K> : Kwbd<CR> 
""2012-10-05: tags: nnoremap t g<C-]>
""2012-10-05: Updated Tagbar: F8 for left, F9 for right bar. 
""2012-08-29: Added <C-Q> to :q 
""2012-08-22: Added qbuf 
""2012-08-20: set cursorline
""2012-08-19: Removded miniBufExpl (it makes Mark response slow for some reasons).
""2012-08-16: miniBufExpl (just copy it to plugin)
""2012-08-15: Move tagbar to left side instead of default right.
""2012-08-13: <F11> UpdateTypesFile to make TagHighlight refresh with tags.
""2012-08-13: <F10> (instead of F11) for trailing WS. 
""2012-08-13: Tagbar 
""2012-08-11: Toggle Menu and Toolbar
""2012-08-09: Added copy&paste: shortcut for copy
""2012-07-13: Added 'useful command' section
""2012-07-11: Fixed <F12> cmd.
""2012-07-10: Modified <F12> cmd to ctags C files only
""2012-06-27: Added set font for Linux
""2012-05-31: Added OmniComplete
""2012-05-30
""2012-05-23

"" Plugins: mark, NERD_tree, taglist, TagHighlight, omni, (c, bufexplorer)
"" tagbar, minibuffexpl, bclose.vim(self-copied)
"" Colors: bandit, eclipse, vylight

" --- Generic---
colorscheme eclipse
syn on
set number
set hlsearch
set ignorecase
set smartcase
set cursorline

" set UTF-8 encoding
  set enc=utf-8
  set fenc=utf-8
  set termencoding=utf-8
" Set font
" Try "set guifont?" to see the cmd
" For Win
" set guifont=Courier_New:h10:cANSI 
" For Linux
set guifont=Courier\ 10\ Pitch\ 10 

 " turn syntax highlighting on
 set t_Co=256
 syntax on
 colorscheme eclipse
 
  " highlight matching brace
set showmatch

" --- Indentation ---
 " use indentation of previous line
 set autoindent
 
 " use intelligent indentation for C
 set smartindent
 
 " configure tabwidth and insert spaces instead of tabs
 "set tabstop=4        " tab width is 4 spaces
 "set shiftwidth=4     " indent also with 4 spaces
 "set expandtab        " expand tabs to spaces
 "Put autocmd commands based on the file suffix in your ~/.vimrc
 "autocmd BufRead,BufNewFile   *.c,*.h,*.java set noic cin noexpandtab
 "autocmd BufRead,BufNewFile   *.pl syntax on
 
 set expandtab
 set shiftwidth=2
 "set softtabstop=2
 "autocmd FileType make set noexpandtab " 


" intelligent comments
set comments=sl:/*,mb:\ *,elx:\ */

" ------------------------
" --- Copy & Paste    ---
" ------------------------
vnoremap <A-c> "+y
noremap <A-v> "+p

" ------------------------
" --- Search ---
" ------------------------
map <F3> :execute 'vimgrep /'.expand('<cword>').'/gj '.expand('%') <Bar> cw<CR>
map <F4> :execute "vimgrep /" . expand("<cword>") . "/j **" <Bar> cw<CR>

" --- quickfix list launch files in new tab---
set switchbuf+=usetab,newtab

" Function: Remap keys to make it more similar to firefox tab functionality
"--------------------
"map     <C-T>       :tabnew<CR>
"map     <C-N>       :!gvim -f &<CR><CR>
"map     <C-W>       :confirm bdelete<CR>

nnoremap <C-Q>  : q<CR>

" --------------------------------------------------
" --- Tabs ---
" --------------------------------------------------
"Switch to last-active tab
let g:lasttab = 1
nmap <C-tab> :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Delete all trailing whitespace (at the end of each line) with
map <F10> :%s/\s\+$//

" -------------------------------
" --- cTags ---
"----------------------------------
" Open tag in a new tab
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
" Open tag in botright vsplit
map <A-]> :botright vsp<CR>:exec ("tag ".expand("<cword>")) <CR>

" Synergy has problems on "]" "\"mapping
nnoremap t g<C-]>
map <F5> :botright vsp<CR>:exec ("tag ".expand("<cword>")) <CR>
map <F6> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

"-----------------------------------
"----------OmniComplete-------------
"-----------------------------------
if v:version >= 600
  filetype plugin on
  filetype indent on
else
  filetype on
endif

if v:version >= 700
  set omnifunc=syntaxcomplete#Complete " override built-in C omnicomplete with C++ OmniCppComplete plugin
  let OmniCpp_GlobalScopeSearch   = 1
  let OmniCpp_DisplayMode         = 1
  let OmniCpp_ShowScopeInAbbr     = 0 "do not show namespace in pop-up
  let OmniCpp_ShowPrototypeInAbbr = 1 "show prototype in pop-up
  let OmniCpp_ShowAccess          = 1 "show access in pop-up
  let OmniCpp_SelectFirstItem     = 1 "select first item in pop-up
  set completeopt=menuone,menu,longest
endif

"" Map F12 to update ctags
function! UpdateTags()
  "execute ":!ctags -R --languages=C,C++ --c++-kinds=+p --fields=+iaS --extra=+q ./"
  execute ":!ctags -R --languages=C,C++ --langmap=C:+.h --c++-kinds=+pxdt --fields=+iaS --extra=+qf ./"
  echohl StatusLine | echo "C/C++ tag updated" | echohl None
endfunction
nnoremap <F12> :call UpdateTags()

"------------------------------------
"---------Toggle Menu and Toolbar----
"------------------------------------
set guioptions-=m
set guioptions-=T
map <silent> <F2> :if &guioptions =~# 'T' <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=m <bar>
    \else <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=m <Bar>
    \endif

"------------------------------------
"-----Tagbar-------------------------
"------------------------------------
nmap <F8> :let g:tagbar_left = 1<CR>:TagbarToggle<CR>
nmap <F9> :let g:tagbar_left = 0<CR>:TagbarToggle<CR>

"------------------------------------
"-----NERDTree-------------------------
"------------------------------------
nmap <C-F> : NERDTree<CR>
nmap <C-D> : NERDTreeClose<CR>

"------------------------------------
"-----TagHighlight-------------------
"------------------------------------
nmap <F11> :UpdateTypesFile<CR>

"------------------------------------
"----- qbuf -------------------
"------------------------------------
let g:qb_hotkey = "<F7>"

"------------------------------------
"-----Kwbd-------------------------
"------------------------------------
nmap <C-K> : Kwbd<CR>

"-------------------------------
"-------Useful commands---------
"-------------------------------
"--- Remove Windows line endings in VIM
" :%s/\r//g or :set fileformat=unix
" to check: set ff? ffs?

"--- Find tab ---
" grep $'\t' fine_name
" grep <ctrl + v> <tab> fine_name

"--- Python ctags ---
"ctags -R --python-kinds=-i  ./
