return { 
    "pchuan98/nvim-lastplace",
    lazy = false,
    config = function()
        local opts = {
            lastplace_ignore_buftype = {"quickfix", "nofile", "help"},
            lastplace_ignore_filetype = {"gitcommit", "gitrebase", "svn", "hgcommit"},
            lastplace_open_folds = true,
            ignore_extension = {"py"}
        }
        require("nvim-lastplace").setup(opts)
    end
}
