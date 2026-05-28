# Neovim Configuration Improvements

Reviewed against the local config and current official Neovim docs.

## High Impact

1. Fix stale APIs.

   - Replace `vim.diagnostic.disable()` in `lua/functions.lua` with:

     ```lua
     vim.diagnostic.enable(false, { bufnr = 0 })
     ```

   - Replace `vim.loop` with `vim.uv` in `lua/plugins.lua` and `lua/options.lua`.
   - Update old `vim.validate("bufnr", bufnr, "number")` usage in `lua/plugin/lsp.lua` to the modern table form.

2. Reduce duplicated keymaps.

   Current collisions or duplicate mappings:

   - `<leader>n` in `lua/keybinds.lua` and `lua/plugin/nvim-tree.lua`
   - `<M-h>` and `<M-l>` in `lua/keybinds.lua` and `lua/plugin/bufferline.lua`
   - duplicate `<leader>fF` in `lua/plugin/fzf-lua.lua`
   - `<leader>df` in `lua/plugin/dap.lua`

   Add `desc` to keymaps and keep one clear namespace for files, LSP, debug, buffers, and config editing.

3. Make plugin loading lazier.

   Candidates for `keys`, `cmd`, `ft`, or `VeryLazy` loading:

   - `fzf-lua`
   - `nvim-dap`
   - `nvim-tree`
   - `aerial`
   - `CopilotChat`
   - Mason registry refresh

   The Mason registry refresh in `lua/plugin/mason.lua` is especially worth moving off startup.

4. Unify formatting.

   You currently have LSP `:Format` in `lua/plugin/lsp.lua` and Conform formatting in `lua/plugin/conform.lua`.

   Prefer making `:Format` call Conform everywhere, with LSP fallback, and keep one formatting keybinding.

5. Actually trigger linting.

   `lua/plugin/lint.lua` defines linters but does not call `require("lint").try_lint()`.

   Add autocmds on save and/or insert leave so configured linters actually run.

## Workflow Improvements

1. Use Neovim's current LSP defaults more.

   Recent Neovim provides default LSP mappings such as `K`, `gra`, `grr`, `gri`, and `grn`. Keep fzf-lua as the picker layer, but avoid duplicating every LSP action twice.

2. Move LSP server overrides into native LSP config files.

   Long server-specific blocks in `lua/plugin/lsp.lua` can move into `lsp/*.lua` or `after/lsp/*.lua`.

   Since `exrc` is enabled, this also gives you a clean path for trusted project-local LSP overrides.

3. Lean harder on quickfix and location lists.

   You already use diagnostic location lists. Add fast mappings for:

   - `:lopen`
   - `:copen`
   - `]q`
   - `[q`

   Then use fzf selections into quickfix for batch edits with `:cdo` and `:cfdo`.

4. Make Poetry environment handling safer.

   `lua/poetry.lua` prepends to `PATH` on directory changes but does not restore or dedupe paths.

   Root-detect with `vim.fs.root()` and avoid accumulating Poetry virtualenv paths.

## Notes From Verification

The headless load check was partly blocked by sandboxed runtime sockets and state/cache writes, so fzf/Mason errors from that run are not reliable normal-session bugs.

The useful finding was the removed diagnostic API in `lua/functions.lua`.

## References

- https://neovim.io/doc/user/lsp.html
- https://neovim.io/doc/user/diagnostic/
- https://neovim.io/doc/user/deprecated/
- https://neovim.io/doc/user/options/
- https://neovim.io/doc/user/lua-plugin/
- https://neovim.io/doc/user/quickfix/
