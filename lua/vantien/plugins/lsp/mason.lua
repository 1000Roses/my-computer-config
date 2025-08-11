-- ===============================
-- Mason + mason-lspconfig setup
-- ===============================
local mason_status, mason = pcall(require, "mason")
if not mason_status then
  print("mason not found ne")
  return
end

local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
  print("mason-lspconfig not found ne")
  return
end

local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status then
  print("mason-null-ls not found ne")
  return
end

mason.setup()

mason_lspconfig.setup({
  ensure_installed = {
    "tsserver",
    "html",
    "cssls",
    "tailwindcss",
    "lua_ls",
    "emmet_ls",
    "pyright",  -- Python LSP
    "gopls",    -- Go LSP
  },
  automatic_installation = true,
})

mason_null_ls.setup({
  ensure_installed = {
    "prettier",
    "stylua",
    "eslint_d",
    "black",   -- Python formatter
    "pylint",  -- Python linter
  },
  automatic_installation = true,
})

-- ===============================
-- Virtualenv Path Setup
-- ===============================
-- Adjust this if your venv is not inside project root
local venv = vim.fn.getcwd() .. "/venv"  -- you said yours is named 'venv'
vim.env.VIRTUAL_ENV = venv
vim.env.PATH = venv .. "/bin:" .. vim.env.PATH

-- ===============================
-- Pyright LSP Setup for Python
-- ===============================
local lspconfig = require("lspconfig")

lspconfig.pyright.setup({
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "workspace",  -- analyze whole project
      },
    },
  },
})

