(let [c (require :Comment)]
    (c.setup {
              :ignore "^$"
              :pre_hook (lambda [ctx]
                            (when (= vim.bo.filetype :typescriptreact)
                              (local U (require :Comment.utils))
                              (local type (or (and (= ctx.ctype U.ctype.line) :__default) :__multiline))
                              (var location nil)
                              (if (= ctx.ctype U.ctype.block)
                                  (set location ((. (require :ts_context_commentstring.utils)
                                                    :get_cursor_location)))
                                  (or (= ctx.cmotion U.cmotion.v) (= ctx.cmotion U.cmotion.V))
                                  (set location ((. (require :ts_context_commentstring.utils)
                                                    :get_visual_start_location))))
                              ((. (require :ts_context_commentstring.internal) :calculate_commentstring) {:key type
                                                                                                          : location})))
              }))
