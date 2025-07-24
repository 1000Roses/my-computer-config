local ok, none_ls = pcall(require, "none-ls")
if not ok then return end

-- Then update the setup:
none_ls.setup({
    sources = {
        none_ls.builtins.formatting.prettier,
        none_ls.builtins.formatting.stylua,
        none_ls.builtins.formatting.gofumpt,
        none_ls.builtins.diagnostics.eslint_d.with({
            condition = function(utils)
                return utils.root_has_file(".eslintrc.js")
            end,
        }),
        none_ls.builtins.diagnostics.black,
        none_ls.builtins.diagnostics.pylint,
    },
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = aug, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = aug,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({
                        filter = function(c) return c.name == "none-ls" end,
                        bufnr = bufnr,
                    })
                end,
            })
        end
    end,
})
