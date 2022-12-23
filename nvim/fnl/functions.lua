-- VIM FUNCTIONS

-- Smart indeting for I
vim.cmd([[
function IndentWithI(default)
    if len(getline('.')) == 0
        return "\"_cc"
    else
        return a:default
    endif
endfunction
]])

-- Show output of shell command in a new split
vim.cmd([[
function! ExecuteInShell(command)
  let command = join(map(split(a:command), 'expand(v:val)'))
  let winnr = bufwinnr('^' . command . '$')
  if winnr > 0
      silent! execute winnr . 'wincmd q'
  endif
  silent! execute 'botright vnew ' . fnameescape(command)
  setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap number
  echo 'Execute ' . command . '...'
  silent! execute 'silent %!'. command
  silent! execute 'resize '
  silent! execute 'set filetype=html'
  silent! execute 'set wrap'
  silent! execute 'lua vim.diagnostic.disable()'
  silent! execute '1wincmd w'
  silent! redraw
  silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ')'
  silent! execute 'nnoremap <silent> <buffer> <F1> :call <SID>ExecuteInShell(''' . command . ''')<CR>'
  " echo 'Shell command ' . command . ' executed.'
endfunction
]])

