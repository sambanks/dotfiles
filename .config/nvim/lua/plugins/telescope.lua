return {
  "nvim-telescope/telescope.nvim",

  tag = "0.1.8",

  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },

  cmd = "Telescope",
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>" },
    { "<leader>fg", function() require('telescope.builtin').grep_string({ cwd = vim.fn.getcwd() }) end },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>" },
    { "<leader>fl", function() require('telescope.builtin').live_grep({ cwd = vim.fn.getcwd() }) end },
  },

  config = function()
    local telescope = require('telescope')
    telescope.setup({
      defaults = {
        file_ignore_patterns = { "node_modules", ".git/" },
      },
    })
    pcall(telescope.load_extension, 'fzf')
  end
}
