local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    vim.fn.system { 'git','clone', '--filter=blob:none','--branch=stable',lazyrepo, lazypath }
end
vim.opt.rtp:prepend(lazypath)

--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
require("lonen.set")
require("lonen.remap")
require("lonen.autocmds")

require("lazy").setup({
    spec = "lonen.plugins",
    change_detection = { notify = false }
})
