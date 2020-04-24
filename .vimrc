execute pathogen#infect()
set nocompatible

filetype plugin indent on

syntax on
colorscheme joker

set number
set visualbell
set encoding=utf-8
set runtimepath^=~/.vim/bundle/ctrlp.vim
set mouse=a 
set laststatus=2
set copyindent
set autoindent
set autowrite
set tabstop=2
set shiftwidth=2
set expandtab

" Set paste by default
" Double escape the codes in tSI/tEI
function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif

  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

" Plugin key
map <F3> :CtrlP<CR>
map <F2> :NERDTreeToggle<CR>

" Startup plugin
" autocmd vimenter * NERDTree
autocmd VimEnter * wincmd p

" NERDTree
let NERDTreeShowHidden=1

" Emmet
let g:user_emmet_leader_key='<Tab>'
imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")

" Language specific config

" Go
autocmd Filetype go setlocal expandtab tabstop=8 shiftwidth=8 softtabstop=8
let g:go_fmt_command = "goimports"

" Python
autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4

" PHP
autocmd Filetype php setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4

" PHP
" https://github.com/stephpy/vim-php-cs-fixer
let g:php_cs_fixer_level = "symfony"
let g:php_cs_fixer_config = "default"
let g:php_cs_fixer_rules = "@PSR2"
let g:php_cs_fixer_php_path = "php"
let g:php_cs_fixer_enable_default_mapping = 1
let g:php_cs_fixer_dry_run = 0
let g:php_cs_fixer_verbose = 0
autocmd BufWritePost *.php silent! call PhpCsFixerFixFile()

" Tmux shift + arrow
if &term =~ '^screen'
  execute "set <xUp>=\e[1;*A"
  execute "set <xUp>=\e[1;*A"
  execute "set <xDown>=\e[1;*B"
  execute "set <xRight>=\e[1;*C"
  execute "set <xLeft>=\e[1;*D"
endif
