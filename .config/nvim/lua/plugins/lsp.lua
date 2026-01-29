-- ** LSP and Completion Configuration **

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-path",
    "hrsh7th/nvim-cmp",
    { "j-hui/fidget.nvim", opts = {} },
    "stevearc/conform.nvim",
    { "williamboman/mason.nvim", opts = {} },
  },
  config = function()

    -- Setup conform.nvim for formatting (replaces deprecated null-ls)
    require("conform").setup({
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
      },
      format_on_save = {
        timeout_ms = 2000,
        lsp_fallback = true,
      },
    })

    -- LSP capabilities for nvim-cmp
    local cmp_lsp = require("cmp_nvim_lsp")
    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      cmp_lsp.default_capabilities()
    )

    -- Ansible LSP configuration
    vim.lsp.config.ansiblels = {
      capabilities = capabilities,
    }

    -- TypeScript/JavaScript LSP configuration
    vim.lsp.config.ts_ls = {
      capabilities = capabilities,
      init_options = {
        preferences = {
          disableSuggestions = true,
        },
      },
    }

    -- Lua LSP configuration
    vim.lsp.config.lua_ls = {
      capabilities = capabilities,
      root_dir = function(fname)
        local util = require("lspconfig.util")
        local lua_project_root = util.root_pattern(
          ".luarc.json",
          ".luarc.jsonc",
          ".luacheckrc",
          ".stylua.toml",
          "stylua.toml",
          "selene.toml",
          "selene.yml"
        )(fname)

        if lua_project_root then
          return lua_project_root
        end

        if type(fname) == "string" and fname:match("%.config/nvim") then
          local git_root = util.find_git_ancestor(fname)
          if git_root and git_root:match("%.config/nvim") then
            return git_root
          end
        end

        return nil
      end,
      settings = {
        Lua = {
          runtime = { version = "LuaJIT" },
          diagnostics = { globals = { "vim" } },
          workspace = {
            library = { vim.env.VIMRUNTIME },
            checkThirdParty = false,
          },
        },
      },
    }

    -- Python LSP configuration (Pyright)
    vim.lsp.config.pyright = {
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
    }

    -- Ruff LSP Configuration
    vim.lsp.config.ruff = {
      capabilities = capabilities,
      settings = {
        ruff = {
          organizeImports = true,
          fixAll = true,
        },
      },
    }

    -- Terraform LSP configuration
    vim.lsp.config.terraformls = {
      capabilities = capabilities,
    }

    -- ESLint LSP configuration
    vim.lsp.config.eslint = {
      capabilities = capabilities,
    }

    -- Enable all configured LSP servers
    vim.lsp.enable({
      'ansiblels',
      'bashls',
      'eslint',
      'lua_ls',
      'marksman',
      'pyright',
      'ruff',
      'terraformls',
      'ts_ls',
      'yamlls',
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
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "nvim_lua" },
        { name = "path" },
      }),
    })

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
      virtual_text = false,
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
      },
      signs = true,
      severity_sort = true,
      underline = true,
      update_in_insert = false,
    })

    -- Show diagnostics in a float on cursor hold
    vim.api.nvim_create_autocmd("CursorHold", {
      callback = function()
        vim.diagnostic.open_float(nil, { scope = "cursor" })
      end,
    })
  end,
}
