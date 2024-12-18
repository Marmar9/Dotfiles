require("session"):setup({
	sync_yanked = true,
})

-- ~/.config/yazi/init.lua
require("relative-motions"):setup({ show_numbers = "relative", show_motion = true })
