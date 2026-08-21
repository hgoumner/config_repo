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

require("copy-file-contents"):setup({
	clipboard_cmd = "linux",
	append_char = "\n",
	notification = true,
})

require("simple-status"):setup()

require("starship"):setup({
	-- Hide flags (such as filter, find and search). This can be beneficial for starship themes
	-- which are intended to go across the entire width of the terminal.
	hide_flags = false,
	-- Whether to place flags after the starship prompt. False means the flags will be placed before the prompt.
	flags_after_prompt = true,
	-- Custom starship configuration file to use
	config_file = "~/config_repo/starship/starship_yazi.toml", -- Default: nil
	-- Whether to enable support for starship's right prompt (i.e. `starship prompt --right`).
	show_right_prompt = false,
	-- Whether to hide the count widget, in case you want only your right prompt to show up. Only has
	-- an effect when `show_right_prompt = true`
	hide_count = false,
	-- Separator to place between the right prompt and the count widget. Use `count_separator = ""`
	-- to have no space between the widgets.
	count_separator = " ",
})
