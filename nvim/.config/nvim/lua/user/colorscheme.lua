local colorscheme = "darkplus"
vim.g.transparent_background = true

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

if not status_ok then
    vim.notify("colorscheme " .. colorscheme .. " not found!")
    return
end

-- vim.cmd [[
-- try
--     colorscheme darkplus
-- catch /^Vim\%((\a\+)\)\=:E185/
--     colorscheme default
--     set background=dark
--     let g.transparent_background=true
-- endtry
-- ]]
