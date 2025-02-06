-- ** LSP and Completion Configuration **

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "L3MON4D3/LuaSnip",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-path",
    "hrsh7th/nvim-cmp",
    "j-hui/fidget.nvim",
    "nvimtools/none-ls.nvim",
    "mfussenegger/nvim-ansible",
    "MunifTanjim/prettier.nvim",
    "nvim-lua/plenary.nvim",
    "stevearc/conform.nvim",
    "williamboman/mason-lspconfig.nvim",
    "williamboman/mason.nvim",
    "zbirenbaum/copilot-cmp",
    "zbirenbaum/copilot.lua",
  },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
      automatic_installation = false,
      ensure_installed = {
        "ansiblels",
        "bashls",
        "eslint",
        "lua_ls",
        "marksman",
        "pyright",
        "ruff",
        "terraformls",
        "ts_ls",
        "yamlls",
      },
    })

    -- Setup none-ls
    local null_ls = require("null-ls")
    local null_opts = {
      sources = {
        null_ls.builtins.formatting.prettier.with({
          filetypes = {
            "javascript",
            "typescript",
            "javascriptreact",
            "typescriptreact",
            "json",
            "yaml",
            "markdown",
            "html",
            "css",
          },
        }),
      },
    }
    null_ls.setup(null_opts)

    -- LSP capabilities for nvim-cmp
    local cmp_lsp = require("cmp_nvim_lsp")
    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      cmp_lsp.default_capabilities()
    )

    -- Ansible LSP configuration
    require("lspconfig").ansiblels.setup({
      capabilities = capabilities,
    })

    -- Copilot LSP configuration
    require("copilot").setup({
      capabilities = capabilities,
      settings = {
        copilot = {
          panel = { enabled = false },
          suggestion = { enabled = false },
        },
      },
    })

    -- Copilot completion configuration
    require("copilot_cmp").setup({
      capabilities = capabilities,
    })

    -- TypeScript/JavaScript LSP configuration
    require("lspconfig").ts_ls.setup({
      capabilities = capabilities,
      init_options = {
        preferences = {
          disableSuggestions = true,
        },
      },
    })

    -- Lua LSP configuration
    require("lspconfig").lua_ls.setup({
      capabilities = capabilities,
      settings = {
        Lua = {
          runtime = { version = "LuaJIT" },
          diagnostics = { globals = { "vim" } },
          workspace = { library = vim.api.nvim_get_runtime_file("", true) },
        },
      },
    })

    -- Python LSP configuration (Pyright)
    require("lspconfig").pyright.setup({
      capabilities = capabilities,
      settings = {
        python = {
          analysis = {
            typeCheckingMode = "strict",
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
          },
        },
      },
    })

    -- Ruff LSP Configuration
    require("lspconfig").ruff.setup({
      capabilities = capabilities,
      settings = {
        ruff = {
          organizeImports = true,
          fixAll = true,
        },
      },
    })

    -- Terraform LSP configuration
    require("lspconfig").terraformls.setup({
      capabilities = capabilities,
    })

    -- TypeScript LSP configuration (ESLint)
    require("lspconfig").eslint.setup({
      capabilities = capabilities,
    })

    -- Completion setup
    local cmp = require("cmp")

    local has_words_before = function()
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
    end

    cmp.setup({
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = vim.schedule_wrap(function(fallback)
          if cmp.visible() and has_words_before() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
          else
            fallback()
          end
        end),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      sources = cmp.config.sources({
        { name = "copilot" },
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "nvim_lua" },
        { name = "path" },
      }),
    })

    -- Set up completion for command-line mode
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "cmdline" },
      }),
    })

    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    -- Diagnostic configuration
    vim.diagnostic.config({
      virtual_text = {
        prefix = "●",
      },
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
      },
      signs = true,
      underline = true,
      update_in_insert = false,
    })

    -- Format on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      callback = function()
        local filetype = vim.bo.filetype
        -- Use Prettier for supported filetypes
        if vim.tbl_contains({
              "javascript",
              "typescript",
              "javascriptreact",
              "typescriptreact",
              "json",
              "yaml",
              "markdown",
              "html",
              "css"
            }, filetype) then
          vim.lsp.buf.format({
            async = false,
            formatting_options = {
              tabSize = 2,
              insertSpaces = true,
            },
          })
        else
          vim.lsp.buf.format({
            async = false,
          })
        end
      end,
    })
  end,
}
