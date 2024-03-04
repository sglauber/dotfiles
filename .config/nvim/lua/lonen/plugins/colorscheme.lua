function FixColors(color)
    color = color or "rose-pine"
    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

end

return {
    {
        "folke/tokyonight.nvim",
        config = function()
            require("tokyonight").setup({
                -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
                style = "storm",
                -- Enable this to disable setting the background color
                transparent = true,
                -- Configure the colors used when opening a `:terminal` in Neovim
                terminal_colors = true,
                styles = {
                    -- Style to be applied to different syntax groups
                    -- Value is any valid attr-list value for `:help nvim_set_hl`
                    comments = { italic = false },
                    keywords = { italic = false },
                    -- Background styles. Can be "dark", "transparent" or "normal"
                    sidebars = "dark", -- style for sidebars, see below
                    floats = "dark", -- style for floating windows
                },
            })
        end
    },

    {
        "rose-pine/neovim",
        name = "rose-pine",
        lazy = false,
        priority = 1000,
        config = function()
            require('rose-pine').setup({
                disable_background = true,
            })

            vim.cmd("colorscheme rose-pine")

            FixColors()
        end
    },
}
