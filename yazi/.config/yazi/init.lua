-- You can configure your bookmarks by lua language
local bookmarks = {}

require("yamb"):setup({
	-- Optional, the path ending with path seperator represents folder.
	bookmarks = bookmarks,
	-- Optional, the cli of fzf.
	cli = "fzf",
	-- Optional, a string used for randomly generating keys, where the preceding characters have higher priority.
	keys = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",
	-- Optional, the path of bookmarks
	path = (ya.target_family() == "windows" and os.getenv("APPDATA") .. "\\yazi\\config\\bookmark")
		or (os.getenv("HOME") .. "/.config/yazi/bookmark"),
})

function Linemode:size_and_mtime()
	local year = os.date("%Y")
	local time = math.floor(self._file.cha.mtime or 0)

	if time > 0 and os.date("%Y", time) == year then
		time = os.date("%Y-%m-%d %H:%M", time)
	else
		time = time and os.date("%Y-%m-%d --:--", time) or ""
	end

	local size = self._file:size()
	return ui.Line(string.format(" %s %s ", size and ya.readable_size(size) or "-", time))
end

require("git"):setup()

require("copy-file-contents"):setup({
	clipboard_cmd = "linux",
	append_char = "\n",
	notification = true,
})

require("simple-status"):setup()
