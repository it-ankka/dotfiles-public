(import-macros {: command!} :hibiscus.vim)
;; VIM COMMANDS

(vim.cmd "command W execute 'w'")
(vim.cmd "command GoRun execute '!cd %:h && go run %'")
(vim.cmd "command GoRunMain execute '!go run main.go'")
(vim.cmd "command VRun execute '!v run %'")
(vim.cmd "command NimRunSilent execute '!nim r --verbosity:0 %'")
(vim.cmd "command NimRun execute '!nim r %'")
(vim.cmd "command TsxRun execute '!tsx %'")
(vim.cmd "command! -complete=shellcmd -nargs=+ Shell call s:ExecuteInShell(<q-args>)")

(command! [] :DiagnosticHide #(vim.diagnostic.config {:virtual_text false :signs false :underline false}))
(command! [] :DiagnosticShow #(vim.diagnostic.config {:virtual_text true :signs true :underline true}))
