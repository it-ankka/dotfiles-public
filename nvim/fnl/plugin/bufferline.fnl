(import-macros {: map!} "hibiscus.vim")
(let [bl (require :bufferline)]
  (bl.setup {
      :options {
        :diagnostics "nvim_lsp"
        :offsets [{
                  :filetype "NvimTree"
                  :text "📁 File Explorer"
                  :highlight "Directory"
                  :text_align "left"
                  }]
        }}))

;; KEYBINDS
; Movement between buffers
(map! [n :silent] "<M-l>" ":BufferLineCycleNext<CR>" )
(map! [n :silent] "<M-h>" ":BufferLineCyclePrev<CR>" )
(map! [n :silent] "ﬁ" ":BufferLineCycleNext<CR>" )
(map! [n :silent] "˛" ":BufferLineCyclePrev<CR>" )
; Reorganize buffers
(map! [n :silent] "<S-M-l>" ":BufferLineMoveNext<CR>" )
(map! [n :silent] "<S-M-h>" ":BufferLineMovePrev<CR>" )
(map! [n :silent] "ﬂ" ":BufferLineMoveNext<CR>" )
(map! [n :silent] "˘" ":BufferLineMovePrev<CR>" )
; Pick a buffer
(map! [n :silent] "<M-b>" ":BufferLinePick<CR>")
(map! [n :silent] "›" ":BufferLinePick<CR>")
