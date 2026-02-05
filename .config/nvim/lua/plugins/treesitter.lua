return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("nvim-treesitter.configs").setup({
      highlight = { enable = true },
      indent = { enable = true },
      sync_install = false,
      ensure_installed = {
        "bash", "c", "diff", "html", "javascript", "jsdoc", "json",
        "lua", "luadoc", "luap", "markdown", "markdown_inline", "printf",
        "python", "query", "regex", "terraform", "toml", "tsx", "typescript",
        "vim", "vimdoc", "xml", "yaml",
      },
    })
  end
}
