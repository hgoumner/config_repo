local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
  return
end

require("bufferline").setup{
    options = {
        separator_style = 'slant',
    }
}
