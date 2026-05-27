return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    main = "nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    config = function()
        local parsers = {
            "c", "go", "lua", "markdown", "proto", "rust",
            "vim", "vimdoc",
        }
        require("nvim-treesitter").install(parsers)

        vim.api.nvim_create_autocmd("FileType", {
            callback = function()
                pcall(vim.treesitter.start)
            end,
        })
    end,
}
