return {
    -- NOTE: Mason core (manages external tools)
    {
        "mason-org/mason.nvim",
        lazy = false,
        config = function()
            require("mason").setup()
        end,
    },
    -- NOTE: Mason LSPConfig (manages LSP servers)
    {
        "mason-org/mason-lspconfig.nvim",
        lazy = false,
        opts = {
            ensure_installed = {
                "lua_ls",
                "clangd",
                "gopls",
                "pyright",
                "html",
                "cssls",
                "jsonls",
                "eslint",
                "hyprls",
                "rust_analyzer",
            },
            automatic_installation = true,
        },
    },
    -- NOTE: Mason Tool Installer (manages formatters, linters, debuggers)
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        lazy = false,
        opts = {
            ensure_installed = {
                "stylua",             -- NOTE: Lua
                "isort",              -- NOTE: Python
                "black",
                "prettierd",          -- NOTE: JS / TS / Web
                "prettier",
                "goimports",          -- NOTE: Go
                "gofumpt",
                "rustfmt",            -- NOTE: Rust
                "alejandra",          -- NOTE: Nix
                "shfmt",              -- NOTE: Shell
                "yamlfmt",            -- NOTE: YAML
                "clang-format",       -- NOTE: C / C++
                "google-java-format", -- NOTE: Java
                "sqlfluff",           -- NOTE: SQL
            },
            auto_update = true,
            run_on_start = true,
        },
    },
    -- NOTE: LSP setup via nvim-lspconfig
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "saghen/blink.cmp" },
        config = function()
            -- NOTE: Capabilities from blink.cmp
            local capabilities = require("blink.cmp").get_lsp_capabilities()
            local lspconfig = require("lspconfig")
            local mason_lspconfig = require("mason-lspconfig")

            -- NOTE: Setup LSP servers with handlers (new API)
            mason_lspconfig.setup({
                handlers = {
                    -- NOTE: Default handler (runs for every server)
                    function(server_name)
                        lspconfig[server_name].setup({
                            capabilities = capabilities,
                        })
                    end,
                    -- NOTE: Lua custom config
                    ["lua_ls"] = function()
                        lspconfig.lua_ls.setup({
                            capabilities = capabilities,
                            settings = {
                                Lua = {
                                    diagnostics = { globals = { "vim" } },
                                },
                            },
                        })
                    end,
                    -- NOTE: Clangd custom config
                    ["clangd"] = function()
                        lspconfig.clangd.setup({
                            capabilities = capabilities,
                            cmd = { "clangd", "--background-index" },
                        })
                    end,
                },
            })
        end,
    },
}
