func! myspacevim#before() abort

    " 当文件被其他编辑器修改时，自动加载
    set autowrite
    set autoread 
    set encoding=utf-8

    " 让 leaderf 可以搜索 git 的 submodule，否则 submodule 的文件会被自动忽略
    let g:Lf_RecurseSubmodules = 1

    let g:table_mode_corner='|'
    
    " Disable Direction Keys
    noremap <up> <nop>
    noremap <down> <nop>
    noremap <left> <nop>
    noremap <right> <nop>
    inoremap <up> <nop>
    inoremap <down> <nop>
    inoremap <left> <nop>
    inoremap <right> <nop>

    " Defx File Tree.
    let g:spacevim_filetree_direction = 'left'

    " 让光标自动进入到popup window 中间
    let g:git_messenger_always_into_popup = v:true
    " 设置映射规则，和 spacevim 保持一致
    call SpaceVim#custom#SPC('nnoremap', ['g', 'm'], 'GitMessenger', 'show commit message in popup window', 1)
    call SpaceVim#custom#SPC('nnoremap', ['g', 'l'], 'FloatermNew lazygit', 'open lazygit in floaterm', 1)

    " 和 sourcetrail 配合使用
    call SpaceVim#custom#SPC('nnoremap', ['a', 'a'], 'SourcetrailStartServer', 'start sourcetrail server', 1)
    call SpaceVim#custom#SPC('nnoremap', ['a', 'b'], 'SourcetrailActivateToken', 'sync sourcetrail with neovim', 1)
    call SpaceVim#custom#SPC('nnoremap', ['a', 'f'], 'SourcetrailRefresh', 'sourcetrail server', 1)

    " FloaTerm
    let g:floaterm_keymap_prev   = '<C-p>'
    let g:floaterm_keymap_new    = '<C-n>'
    let g:floaterm_keymap_toggle = '<F4>'

    " Fast Expand Pwd
    cnoremap <expr> %% getcmdtype( ) == ':' ? expand('%:h').'/' : '%%'

    " Airline
    nnoremap ]b :bnext<CR>
    nnoremap ]B :blast<CR>
    nnoremap [b :bprevious<CR>
    nnoremap [B :bfirst<CR>

    " Color Highlight

    " Coc
    set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
    set termencoding=utf-8
    set encoding=utf-8

    " Some servers have issues with backup files, see #649.
    set nobackup
    set nowritebackup

    " DisplayLine
    set cmdheight=1

    " Update Delays
    set updatetime=0

    " Don't pass messages to |ins-completion-menu|.
    set shortmess+=c

    " Always show the signcolumn, otherwise it would shift the text each time
    " diagnostics appear/become resolved.
    if has("nvim-0.5.0") || has("patch-8.1.1564")
    " Recently vim can merge signcolumn and number column into one
    set signcolumn=number
    else
    set signcolumn=yes
    endif

    " Use tab for trigger completion with characters ahead and navigate.
    " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
    " other plugin before putting this into your config.
    inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    " Use <c-space> to trigger completion.
    if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
    else
    inoremap <silent><expr> <c-@> coc#refresh()
    endif

    " Make <CR> auto-select the first completion item and notify coc.nvim to
    " format on enter, <cr> could be remapped by other vim plugin
    inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                                \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

    " Code Diagnostics
    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)

    " Code Nivagation
    nmap <silent> <leader>gd <Plug>(coc-definition)
    nmap <silent> <leader>gr <Plug>(coc-references)

    " Code Documentation
    nnoremap <silent> K :call <SID>show_documentation()<CR>
    function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . " " . expand('<cword>')
    endif
    endfunction

    " Hover Highlight
    autocmd CursorHold * silent call CocActionAsync('highlight')

    " Symbol Rename
    nmap <leader>rn <Plug>(coc-rename)

    " Fast Close Search Highlight
    nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

    augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    augroup end

    " Code Action
    nmap <leader>ac  <Plug>(coc-codeaction)

    " Code Quick Fix
    nmap <leader>qf  <Plug>(coc-fix-current)

    " Map function and class text objects
    " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
    xmap if <Plug>(coc-funcobj-i)
    omap if <Plug>(coc-funcobj-i)
    xmap af <Plug>(coc-funcobj-a)
    omap af <Plug>(coc-funcobj-a)
    xmap ic <Plug>(coc-classobj-i)
    omap ic <Plug>(coc-classobj-i)
    xmap ac <Plug>(coc-classobj-a)
    omap ac <Plug>(coc-classobj-a)

    " Scroll Half Screen
    if has('nvim-0.4.0') || has('patch-8.2.0750')
    nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
    inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
    vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    endif

    " Code Select
    " Requires 'textDocument/selectionRange' support of language server.
    " nmap <silent> <C-s> <Plug>(coc-range-select)
    " xmap <silent> <C-s> <Plug>(coc-range-select)

    " Add `:Format` command to format current buffer.
    command! -nargs=0 Format :call CocAction('format')

    " Add `:Fold` command to fold current buffer.
    command! -nargs=? Fold :call     CocAction('fold', <f-args>)

    " Add `:OR` command for organize imports of the current buffer.
    command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

    " Add (Neo)Vim's native statusline support.
    " NOTE: Please see `:h coc-status` for integrations with external plugins that
    " provide custom statusline: lightline.vim, vim-airline.
    set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
    autocmd CursorHold * silent call CocActionAsync('highlight')

" F5 Compile
map <F5> :call RunCompiler()<CR>
func! RunCompiler()
    exec "w"
    if &filetype == 'c'
        AsyncRun -mode=bang g++ % -o %:t:r
        AsyncRun -mode=bang %:t:r
    elseif &filetype == 'cpp'
        AsyncRun -mode=bang g++ -g -Wall --std=c++11 % -o %:t:r
        AsyncRun -mode=bang %:t:r
    elseif &filetype == 'java'
        AsyncRun -cwd=%:p:h -mode=bang javac *.java
        AsyncRun -cwd=%:p:h -mode=bang java -cp ../ %:p:h:t.%:t:r
    elseif &filetype == 'python'
        AsyncRun -mode=bang python3.5 %
    elseif &filetype == 'sh'
        AsyncRun -mode=bang %
    endif
endfunc

" F9 Debug
map <F9> :call RunDebugger()<CR>  
func! RunDebugger()  
    exec "w"
    if &filetype == 'c' || &filetype =='cpp'
      AsyncRun -mode=bang g++ % -g -o %:t:r
      AsyncRun -mode=os gdb %:t:r
    elseif &filetype == 'java'
      AsyncRun -cwd=%:p:h -mode=bang javac -g *.java
      AsyncRun -cwd=%:p:h -mode=os java -classpath ../ -Xdebug -Xrunjdwp:transport=dt_socket,address=5005,server=y,suspend=y %:p:h:t.%:t:r
      AsyncRun -mode=os jdb -connect com.sun.jdi.SocketAttach:port=5005,hostname=localhost
    endif
endfunc

" F10 Git
map <F10> :call RunGit()<CR>
func! RunGit()
  AsyncRun -cwd=%:p:h -mode=os bash
endfunc

endf

func! myspacevim#after() abort
    " F2: vista
    let g:vista_sidebar_position = "vertical rightbelow"
    let g:vista_default_executive = 'coc'
    let g:vista_finder_alternative_executives = 'ctags'
    nnoremap  <F2>  :Vista!!<CR>

    " Map jj to Esc.
    inoremap jj <esc>
    
    " Indent.
    set autoindent          " 设置自动缩进
    set smartindent         " 设置智能缩进
    set ts=2                " 设置tab长度为4
    set shiftwidth=2
    set softtabstop=2
    set expandtab           " 使用空格替换tab

    " Environment: Python.
    " set pythonthreedll=python39.dll
    " set pythondll=python39.dll

    " Defx
    autocmd FileType defx call s:defx_my_settings()
	function! s:defx_my_settings() abort
	  " Define mappings
	  nnoremap <silent><buffer><expr> <CR>
	  \ defx#do_action('open')
	  nnoremap <silent><buffer><expr> c
	  \ defx#do_action('copy')
	  nnoremap <silent><buffer><expr> m
	  \ defx#do_action('move')
	  nnoremap <silent><buffer><expr> p
	  \ defx#do_action('paste')
	  nnoremap <silent><buffer><expr> l
	  \ defx#do_action('open')
	  nnoremap <silent><buffer><expr> K
	  \ defx#do_action('new_directory')
	  nnoremap <silent><buffer><expr> N
	  \ defx#do_action('new_file')
	  nnoremap <silent><buffer><expr> d
	  \ defx#do_action('remove')
	  nnoremap <silent><buffer><expr> r
	  \ defx#do_action('rename')
	  nnoremap <silent><buffer><expr> yy
	  \ defx#do_action('yank_path')
	  nnoremap <silent><buffer><expr> .
	  \ defx#do_action('toggle_ignored_files')
	  nnoremap <silent><buffer><expr> h
	  \ defx#do_action('cd', ['..'])
	  nnoremap <silent><buffer><expr> ~
	  \ defx#do_action('cd')
	  nnoremap <silent><buffer><expr> q
	  \ defx#do_action('quit')
	  nnoremap <silent><buffer><expr> <C-l>
	  \ defx#do_action('redraw')
      nnoremap <silent><buffer><expr> cd
	  \ defx#do_action('change_vim_cwd')
	endfunction

    " Defx Icon


endf
