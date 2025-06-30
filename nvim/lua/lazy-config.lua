require("lazy").setup(
    {
        {
            import = "plugins"
        }
    },
    {
        checker = {
            enabled = true,
            notify = false,
        },
        performance = {
            cache = {
                enabled = true
            }
       }
    }
)
