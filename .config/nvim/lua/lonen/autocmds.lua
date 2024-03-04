-- define local alias
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- create groups
local LonenGroup = augroup('TheLonenGroup', {})
local yank_group = augroup('HighlightYank', {})

function R(name)
    require("plenary.reload").reload_module(name)
end

vim.filetype.add({
    extension = {
        templ = 'templ',
    }
})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({"BufWritePre"}, {
    group = LonenGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

autocmd('LspAttach', {
    group = LonenGroup,
    callback = function(e)
        local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = e.buf, desc = 'LSP: ' .. desc })
        end

        -- Jump to the definition of the word under your cursor.
        --  This is where a variable was first declared, or where a function is defined, etc.
        map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
        -- Opens a popup that displays documentation about the word under your cursor
        --  See `:help K` for why this keymap
        map('K', vim.lsp.buf.hover, 'Hover Documentation')
        -- Fuzzy find all the symbols in your current workspace
        --  Similar to document symbols, except searches over your whole project.
        map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
        -- Find references for the word under your cursor.
        map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        -- Jump to the implementation of the word under your cursor.
        --  Useful when your language has ways of declaring types without an actual implementation.
        map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
        map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
        map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
        map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        -- Execute a code action, usually your cursor needs to be on top of an error
        -- or a suggestion from your LSP for this to activate.
        map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
        -- WARN: This is not Goto Definition, this is Goto Declaration.
        --  For example, in C this would take you to the header
        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        map('[d', function() vim.diagnostic.goto_next() end, '')
        map(']d', function() vim.diagnostic.goto_prev() end, '')

        local client = vim.lsp.get_client_by_id(e.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
            autocmd({ 'CursorHold', 'CursorHoldI' }, {
                buffer = e.buf,
                callback = vim.lsp.buf.document_highlight,
            })

            autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                buffer = e.buf,
                callback = vim.lsp.buf.clear_references,
            })
        end
    end,
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
