local status_ok, comment = pcall(require, "harpoon")
if not status_ok then
  return
end

-- add to telescope
require("telescope").load_extension('harpoon')
