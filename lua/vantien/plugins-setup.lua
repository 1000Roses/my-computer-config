local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
        vim.cmd([[packadd packer.nvim]])
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

-- Autocommand that reloads neovim whenever you save this file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerCompile
  augroup end
]])

local status, packer = pcall(require, "packer")
if not status then
    return
end

return packer.startup(function(use)
    use("wbthomason/packer.nvim")
    -- use("bluz71/vim-nightfly-guicolors") --  preferred colorscheme
    use({ "catppuccin/nvim", as = "cappuccin" }) --  preferred colorscheme

    -- tmux & split window navigation
    use("christoomey/vim-tmux-navigator")
    use("szw/vim-maximizer")
    -- essential plugins
    use("tpope/vim-surround")
    use("vim-scripts/ReplaceWithRegister")

    -- commenting with gc
    use("numToStr/Comment.nvim")

    -- file explorer
    use("nvim-tree/nvim-tree.lua")

    -- telescope plugin
    use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" })
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
    use("nvim-lua/plenary.nvim")

    -- autocompletion
    use("hrsh7th/nvim-cmp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")

    -- snippets
    use("L3MON4D3/LuaSnip")
    use("saadparwaiz1/cmp_luasnip")
    use("rafamadriz/friendly-snippets")
    use("onsails/lspkind-nvim")

    -- managing & installing lsp servers
    use("williamboman/mason.nvim")           -- in charge of managing lsp servers, linters & formatters
    use("williamboman/mason-lspconfig.nvim") -- bridges gap b/w mason & lspconfig

    -- configuring lsp servers
    use("neovim/nvim-lspconfig")
    use("hrsh7th/cmp-nvim-lsp") -- for autocompletion
    use({
        "glepnir/lspsaga.nvim",
        branch = "main",
        requires = {
            { "nvim-tree/nvim-web-devicons" },
            { "nvim-treesitter/nvim-treesitter" },
        },
    })                                        -- enhanced lsp uis
    use("jose-elias-alvarez/typescript.nvim") -- additional functionality for typescript server (e.g. rename file & update imports)
    use("onsails/lspkind.nvim")               -- vs-code like icons for autocompletion

    -- formatting & linting
    use('nvimtools/none-ls.nvim')
    use("jayp0521/mason-null-ls.nvim") -- bridges gap b/w mason & null-ls

    -- treesitter configuration
    use({
        "nvim-treesitter/nvim-treesitter",
        run = function()
            local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
            ts_update()
        end,
    })

    -- auto closing
    use("windwp/nvim-autopairs")                                 -- autoclose parens, brackets, quotes, etc...
    use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- autoclose tags

    use("tpope/vim-fugitive")
    -- git integration
    use("lewis6991/gitsigns.nvim") -- show line modifications on left hand side

    -- venv selector
    use("AckslD/swenv.nvim")
    use("stevearc/dressing.nvim")

    -- alternative venv selector
    use("linux-cultist/venv-selector.nvim")

    -- toggleterm
    use("akinsho/toggleterm.nvim")

    -- autosave
    use("Pocco81/auto-save.nvim")

    -- vim-visual-multi
    use("mg979/vim-visual-multi")
    -- trouble
    use({ "folke/trouble.nvim", requires = { "folke/todo-comments.nvim" } })
    -- statusline
    use("beauwilliams/statusline.lua")

    -- Debugging
    use({
        "mfussenegger/nvim-dap",
        requires = {
            "rcarriga/nvim-dap-ui",
            "leoluz/nvim-dap-go",
            "nvim-neotest/nvim-nio", -- nvim-dap-ui need nvim-nio
        },
    })

    -- Code company
    use({
        "olimorris/codecompanion.nvim",
        config = function()
            require("codecompanion").setup({
                adapters = {
                    deepseek = function()
                        return require("codecompanion.adapters").extend("deepseek", {
                            env = {
                                api_key = "sk-f13bb02cab834d7e8639e6387a83ae79"
                            },
                        })
                    end,
                },
                strategies = {
                    chat = {
                        adapter = {
                            name = "deepseek",
                            model = "deepseek-chat"
                        }
                    },
                    inline = {
                        adapter = {
                            name = "deepseek",
                            model = "deepseek-reasoner"
                        }
                    },
                    cmd = {
                        adapter = {
                            name = "deepseek",
                            model = "deepseek-reasoner"
                        }
                    }
                },
                display = {
                    chat = {
                        intro_message = "Welcome to CodeCompanion ✨! Press ? for options",
                        show_header_separator = false, -- Show header separators in the chat buffer? Set this to false if you're using an external markdown formatting plugin
                        separator = "─", -- The separator between the different messages in the chat buffer
                        show_references = true, -- Show references (from slash commands and variables) in the chat buffer?
                        show_settings = false, -- Show LLM settings at the top of the chat buffer?
                        show_token_count = true, -- Show the token count for each response?
                        start_in_insert_mode = false, -- Open the chat buffer in insert mode?
                    },
                    action_palette = {
                        width = 95,
                        height = 10,
                        prompt = "Prompt ",                   -- Prompt used for interactive LLM calls
                        provider = "default",                 -- Can be "default", "telescope", "fzf_lua", "mini_pick" or "snacks". If not specified, the plugin will autodetect installed providers.
                        opts = {
                            show_default_actions = true,      -- Show the default actions in the action palette?
                            show_default_prompt_library = true, -- Show the default prompt library in the action palette?
                        },
                    },
                },
            })
        end,
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        }
    })
    if packer_bootstrap then
        require("packer").sync()
    end
end)
