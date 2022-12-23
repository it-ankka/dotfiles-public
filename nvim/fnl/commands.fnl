(import-macros {: command!} :hibiscus.vim)
;; VIM COMMANDS

(vim.cmd "command W execute 'w'")
(vim.cmd "command Go execute '!cd %:h && go run %'")
(vim.cmd "command GoMain execute '!go run main.go'")
(vim.cmd "command Vlang execute '!v run %'")
(vim.cmd "command NimSilent execute '!nim r --verbosity:0 %'")
(vim.cmd "command Nim execute '!nim r %'")
(vim.cmd "command Tsx execute '!tsx %'")
(vim.cmd "command! -complete=shellcmd -nargs=+ Shell call ExecuteInShell(<q-args>)")

(command! [] :HideDiagnostics #(vim.diagnostic.config {:virtual_text false :signs false :underline false}))
(command! [] :ShowDiagnostics #(vim.diagnostic.config {:virtual_text true :signs true :underline true}))
