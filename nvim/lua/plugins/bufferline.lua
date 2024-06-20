return {
	"akinsho/bufferline.nvim",
	opts = function()
		local highlights = function()
			local bg = "#193549"
			return {
				background = {
					bg = bg,
				},
				buffer_selected = {
					bg = bg,
				},
				buffer_visible = {
					bg = bg,
				},
				close_button = {
					bg = bg,
				},
				duplicate = {
					bg = bg,
				},
				duplicate_selected = {
					bg = bg,
				},
				duplicate_visible = {
					bg = bg,
				},
				fill = {
					bg = bg,
				},
				indicator_visible = {
					bg = bg,
				},
				modified = {
					bg = bg,
				},
				separator = {
					bg = bg,
				},
				separator_visible = {
					bg = bg,
				},
			}
		end
		return {
			highlights = highlights,
			options = {
				show_close_icon = false,
				show_buffer_close_icons = false,
				always_show_bufferline = true,
			},
		}
	end,
}
