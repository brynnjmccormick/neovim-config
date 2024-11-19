local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  "eandrju/cellular-automaton.nvim",
  {
    "rose-pine/neovim",
    name = "rose-pine",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter")

      configs.setup({
        ensure_installed = { "javascript", "lua", "html", "djangohtml" },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  "williamboman/mason.nvim",
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body)
          end
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = {
          { name = "nvim_lsp" }
        }
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
      },
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      mason.setup()
      mason_lspconfig.setup()

      lspconfig.ts_ls.setup({
        capabilties = capabilities,
      })
      lspconfig.rust_analyzer.setup({
        capabilties = capabilities,
      })
      lspconfig.lua_ls.setup({
        capabilties = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" }
            }
          }
        }
      })
      lspconfig.html.setup({
        capabilties = capabilities,
      })
      lspconfig.emmet_language_server.setup({
        capabilties = capabilities,
      })
      lspconfig.pyright.setup({
        capabilities = capabilities,
        -- https://neovim.discourse.group/t/pyright-can-not-find-root-dir-single-file-mode/2156
        root_dir = function(fname)
          local util = require('lspconfig/util')
          local root_files = {
            'pyrightconfig.json'
          }
          return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname) or
          util.path.dirname(fname)
        end
      })
    end
  },
})
