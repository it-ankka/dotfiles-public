(local autoclose {})

(local config {"(" {:escape false :close true :pair "()"}
               "[" {:escape false :close true :pair "[]"}
               "{" {:escape false :close true :pair "{}"}
               :> {:escape true :close false :pair "<>"}
               ")" {:escape true :close false :pair "()"}
               "]" {:escape true :close false :pair "[]"}
               "}" {:escape true :close false :pair "{}"}
               "\"" {:escape true :close true :pair "\"\""}
               "'" {:escape true :close true :pair "''"}
               "`" {:escape true :close true :pair "``"}
               :<BS> {}
               :<CR> {}})

(fn get-pair []
  (let [line (.. "_" (vim.api.nvim_get_current_line))
        col (+ (. (vim.api.nvim_win_get_cursor 0) 2) 1)]
    (line:sub col (+ col 1))))

(fn is-pair [pair]
  (each [_ info (pairs config)]
    (when (= pair info.pair)
      (lua "return true")))
  false)

;; (fn next-is-alphanum [] 
;;   (let [line (.. "_" (vim.api.nvim_get_current_line))
;;         col (+ (. (vim.api.nvim_win_get_cursor 0) 2) 1)
;;         char (line:sub col (+ col 1))]
;;     (string.match char "[%p*%w*]")))

(fn handler [key info]
  (let [pair (get-pair)]
    (if (and (= key :<BS>) (is-pair pair)) :<BS><Del>
        (and (= key :<CR>) (is-pair pair)) :<CR><ESC>O
        (and info.escape (= (pair:sub 2 2) key)) :<Right>
        ;; (and info.close (not (next-is-alphanum)))  (.. info.pair :<Left>)
        (and info.close true)  (.. info.pair :<Left>)
         key)))

(fn autoclose.setup [user-config]
  (each [key info (pairs user-config)]
    (tset config key info))
  (each [key info (pairs config)]
    (vim.keymap.set :i key #(handler key info)
                    {:noremap true :expr true})))
autoclose
