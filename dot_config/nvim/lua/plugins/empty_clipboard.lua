return {
	-- add symbols-outline
	{
		"ibhagwan/smartyank.nvim",
		-- cmd = "SymbolsOutline",
		-- keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
		opts = {
			-- add your options that should be passed to the setup() function here
			highlight = {
				enabled = false, -- highlight yanked text
				higroup = "IncSearch", -- highlight group of yanked text
				timeout = 1000, -- timeout for clearing the highlight
			},
			clipboard = {
				enabled = true,
			},
			tmux = {
				enabled = true,
				-- remove `-w` to disable copy to host client's clipboard
				cmd = { "tmux", "set-buffer", "-w" },
			},
			osc52 = {
				enabled = true,
				-- escseq = 'tmux',     -- use tmux escape sequence, only enable if
				-- you're using tmux and have issues (see #4)
				ssh_only = true, -- false to OSC52 yank also in local sessions
				silent = true, -- true to disable the "n chars copied" echo
				echo_hl = "Directory", -- highlight group of the OSC52 echo message
			},
		},
	},
}
