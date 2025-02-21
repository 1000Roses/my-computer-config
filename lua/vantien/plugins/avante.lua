local statusAvante, avante = pcall(require, "avante")
if not statusAvante then
	print("Avante plugin not found")
	return
end

local statusLib, avante_lib = pcall(require, "avante_lib")
if not statusLib then
	print("AvanteLib plugin not found")
	return
end

avante_lib.load()

local statusRM, renterMarkdown = pcall(require, "render-markdown")
if not statusRM then
	print("render-markdown plugin not found")
	return
end

renterMarkdown.setup({
	-- use recommended settings from above
})

local statusIM, imgClip = pcall(require, "img-clip")
if not statusIM then
	print("image-clip plugin not found")
	return
end

imgClip.setup({
	-- use recommended settings from above
})

local statusCopilot, copilot = pcall(require, "copilot")
if not statusCopilot then
	print("copilot plugin not found")
	return
end

copilot.setup({
	-- use recommended settings from above
})
-- avante.setup({
--   default_model = "claude-3-opus", -- or "claude-3-sonnet"
--   api_key = os.getenv("ANTHROPIC_API_KEY"),
--   -- Customize prompts
--   system_prompt = "You are Claude, an AI assistant created by Anthropic. Respond concisely and helpfully.",

--   -- UI configuration
--   ui = {
--     width = 0.8,  -- 80% of window width
--     height = 0.7, -- 70% of window height
--     border = "rounded",
--   },

--   -- Key mappings
--   mappings = {
--     submit = "<C-s>",
--     new_line = "<C-Enter>",
--     close = "<Esc>",
--   }
-- })

-- Set keymap to open Claude chat
vim.keymap.set("n", "<leader>ac", ":AvanteChat<CR>", { noremap = true, silent = true, desc = "Open Chat" })

avante.setup({
	---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | "deepseek" | string
	provider = "gemini", -- Set Gemini as default provider
	-- WARNING: Since auto-suggestions are a high-frequency operation and therefore expensive,
	-- currently designating it as `copilot` provider is dangerous because: https://github.com/yetone/avante.nvim/issues/1048
	-- Of course, you can reduce the request frequency by increasing `suggestion.debounce`.
	auto_suggestions_provider = "claude", -- Keep Claude for suggestions
	gemini = {
		api_key = os.getenv("GOOGLE_API_KEY"),
		model = "gemini-2.0-flash-thinking-exp",
		safety_settings = {
			{
				category = "HARM_CATEGORY_HATE_SPEECH",
				threshold = "BLOCK_NONE",
			},
			{
				category = "HARM_CATEGORY_SEXUALLY_EXPLICIT",
				threshold = "BLOCK_NONE",
			},
			{
				category = "HARM_CATEGORY_HARASSMENT",
				threshold = "BLOCK_NONE",
			},
			{
				category = "HARM_CATEGORY_DANGEROUS_CONTENT",
				threshold = "BLOCK_NONE",
			},
		},
		generationConfig = {
			topP = 0.95,
			topK = 40,
			maxOutputTokens = 4096,
			stopSequences = {},
			temperature = 0,
		},
	},
	claude = {
		api_key = os.getenv("ANTHROPIC_API_KEY"),
		model = "claude-3-5-sonnet-20241022",
		temperature = 0,
		max_tokens = 4096,
	},
	---Specify the special dual_boost mode
	---1. enabled: Whether to enable dual_boost mode. Default to false.
	---2. first_provider: The first provider to generate response. Default to "openai".
	---3. second_provider: The second provider to generate response. Default to "claude".
	---4. prompt: The prompt to generate response based on the two reference outputs.
	---5. timeout: Timeout in milliseconds. Default to 60000.
	---How it works:
	--- When dual_boost is enabled, avante will generate two responses from the first_provider and second_provider respectively. Then use the response from the first_provider as provider1_output and the response from the second_provider as provider2_output. Finally, avante will generate a response based on the prompt and the two reference outputs, with the default Provider as normal.
	---Note: This is an experimental feature and may not work as expected.
	dual_boost = {
		enabled = false,
		first_provider = "openai",
		second_provider = "claude",
		prompt = "Based on the two reference outputs below, generate a response that incorporates elements from both but reflects your own judgment and unique perspective. Do not provide any explanation, just give the response directly. Reference Output 1: [{{provider1_output}}], Reference Output 2: [{{provider2_output}}]",
		timeout = 60000, -- Timeout in milliseconds
	},
	behaviour = {
		auto_suggestions = false, -- Experimental stage
		auto_set_highlight_group = true,
		auto_set_keymaps = true,
		auto_apply_diff_after_generation = false,
		support_paste_from_clipboard = false,
		minimize_diff = true, -- Whether to remove unchanged lines when applying a code block
		enable_token_counting = true, -- Whether to enable token counting. Default to true.
	},
	mappings = {
		--- @class AvanteConflictMappings
		diff = {
			ours = "co",
			theirs = "ct",
			all_theirs = "ca",
			both = "cb",
			cursor = "cc",
			next = "]x",
			prev = "[x",
		},
		suggestion = {
			accept = "<M-l>",
			next = "<M-]>",
			prev = "<M-[>",
			dismiss = "<C-]>",
		},
		jump = {
			next = "]]",
			prev = "[[",
		},
		submit = {
			normal = "<CR>",
			insert = "<C-s>",
		},
		sidebar = {
			apply_all = "A",
			apply_cursor = "a",
			switch_windows = "<Tab>",
			reverse_switch_windows = "<S-Tab>",
		},
		switch_provider = "<leader>ap", -- Add this line
	},
	hints = { enabled = true },
	windows = {
		---@type "right" | "left" | "top" | "bottom"
		position = "right", -- the position of the sidebar
		wrap = true, -- similar to vim.o.wrap
		width = 30, -- default % based on available width
		sidebar_header = {
			enabled = true, -- true, false to enable/disable the header
			align = "center", -- left, center, right for title
			rounded = true,
		},
		input = {
			prefix = "> ",
			height = 8, -- Height of the input window in vertical layout
		},
		edit = {
			border = "rounded",
			start_insert = true, -- Start insert mode when opening the edit window
		},
		ask = {
			floating = false, -- Open the 'AvanteAsk' prompt in a floating window
			start_insert = true, -- Start insert mode when opening the ask window
			border = "rounded",
			---@type "ours" | "theirs"
			focus_on_apply = "ours", -- which diff to focus after applying
		},
	},
	highlights = {
		---@type AvanteConflictHighlights
		diff = {
			current = "DiffText",
			incoming = "DiffAdd",
		},
	},
	--- @class AvanteConflictUserConfig
	diff = {
		autojump = true,
		---@type string | fun(): any
		list_opener = "copen",
		--- Override the 'timeoutlen' setting while hovering over a diff (see :help timeoutlen).
		--- Helps to avoid entering operator-pending mode with diff mappings starting with `c`.
		--- Disable by setting to -1.
		override_timeoutlen = 500,
	},
	suggestion = {
		debounce = 600,
		throttle = 600,
	},
})

-- views can only be fully collapsed with the global statusline
vim.opt.laststatus = 3

-- Add visual feedback for provider switching
vim.api.nvim_create_autocmd("User", {
	pattern = "AvanteProviderChanged",
	callback = function(args)
		vim.notify("Provider changed to: " .. args.data.provider)
	end,
})
