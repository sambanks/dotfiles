return {
  { "sainnhe/gruvbox-material", lazy = false, priority = 1000 },
  { "tpope/vim-commentary", event = "VeryLazy" },
  { "tpope/vim-fugitive" },
  { "tpope/vim-vinegar", keys = { "-" } },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    opts = {
      cmdline = {
        view = "cmdline",
      },
      messages = {
        view = "notify",
      },
      popupmenu = {
        enabled = true,
      },
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        progress = {
          view = "notify",
        },
        message = {
          view = "notify",
        },
      },
      views = {
        mini = {
          border = {
            style = "rounded",
            padding = { 0, 1 },
          },
          win_options = {
            winblend = 0,
            winhighlight = "Normal:NoiceMini,FloatBorder:NoiceMini",
          },
        },
      },
      presets = {
        bottom_search = true,
        command_palette = false,
        long_message_to_split = true,
      },
    },
  },
}
