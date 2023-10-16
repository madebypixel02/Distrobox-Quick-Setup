" **************************************************************************** "
"                                                                              "
"                                                           _nnnn_             "
"                                                          dGGGGMMb            "
"                                                         @p~qp~~qMb           "
"                                                         M|@||@) M|           "
"                                                         @,----.JM|           "
"                                                        JS^\__/  qKL          "
"                                                       dZP        qKRb        "
"                                                      dZP          qKKb       "
"                                                     fZP            SMMb      "
"                                                     HZM            MMMM      "
"    .vimrc                                           FqM            MMMM      "
"                                                   __| `.        |\dS'qML     "
"    By: madebypixel02 <madebypixel02@proton.me>    |    `.       | `' \Zq     "
"                                                   _)      .___.,|     .'     "
"    Created: 2022/06/25 20:30:34 by madebypixel02  \___   )MMMMMP|   .'       "
"    Updated: 2023/10/16 10:03:14 by madebypixel02      `-'       `--'         "
"                                                                              "
" **************************************************************************** "

set nu
set showcmd
set mouse=a
set laststatus=2
set tabstop=4
set shiftwidth=4
set scrolloff=999
set sidescrolloff=999
set relativenumber
set encoding=utf-8
set list lcs=tab:\|\ 
set noexpandtab

if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

call plug#begin('~/.vim/plugged')

au BufEnter *.html setf html "(set a filetype unless it already exist)
au filetype html set expandtab

Plug 'tomasiser/vim-code-dark'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'preservim/nerdtree'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'lervag/vimtex'
Plug 'ericbn/vim-relativize'
Plug 'dccsillag/magma-nvim', { 'do': ':UpdateRemotePlugins' }

call plug#end()

" Coc Extensions
let g:coc_global_extensions = ['coc-marketplace', 'coc-clangd', 'coc-emoji', 'coc-clang-format-style-options', 'coc-word', 'coc-git', 'coc-cmake', 'coc-pyright', 'coc-cspell-dicts', 'coc-markdownlint', 'coc-markdown-preview-enhanced', 'coc-dictionary', 'coc-ltex', 'coc-gitignore', 'coc-yank', 'coc-spell-checker', 'coc-webview', 'coc-pairs', 'coc-gist', 'coc-html', 'coc-css', 'coc-tsserver']

" Fix auto-completion enter
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

" Custom Mappings
map <c-p> :Files<CR>
map gl :Git log<CR>
map gs :Git status<CR>
map <c-S-Right> :tabn<CR>
map <c-S-Left> :tabp<CR>
map <c-S-Up> :tabnew<CR>
map <c-S-Down> :tabclose<CR>
map <c-m>t :!make test<CR>
map <c-m>a :!make all<CR>
map <c-m>b :!make bonus<CR>
map <c-s> :w <bar> source ~/.vimrc<CR>
map m :set mouse=a<CR>
map mm :set mouse-=a<CR>
map md :CocCommand markdown-preview-enhanced.openPreview<CR>
map b :set nu <bar> set relativenumber<CR>
map bb :set nonu <bar> set norelativenumber<CR>
map tr :NERDTree<CR>

" Coc Stuff

" Disable Coc Warinings
let g:coc_disable_startup_warning = 1

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> df <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <F2> <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

colorscheme codedark

"" Magma nvim stuff
nnoremap <silent><expr> <LocalLeader>r  :MagmaEvaluateOperator<CR>
nnoremap <silent>       <LocalLeader>rr :MagmaEvaluateLine<CR>
xnoremap <silent>       <LocalLeader>r  :<C-u>MagmaEvaluateVisual<CR>
nnoremap <silent>       <LocalLeader>rc :MagmaReevaluateCell<CR>
nnoremap <silent>       <LocalLeader>rd :MagmaDelete<CR>
nnoremap <silent>       <LocalLeader>ro :MagmaShowOutput<CR>

let g:magma_automatically_open_output = v:false
let g:magma_image_provider = "ueberzug"
