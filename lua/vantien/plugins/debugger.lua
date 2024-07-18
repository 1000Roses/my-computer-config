local dap = require("dap")
local dapui = require("dapui")
local dapgo = require("dap-go")

dapui.setup()

dapgo.setup({
	dap_configurations = {
		{
			type = "go",
			name = "Debug main.go start",
			request = "launch",
			program = "${workspaceFolder}/main.go",
			-- args = { "start", "--env=./" },
			args = { "start" },
			cwd = "${workspaceFolder}",
		},
		{
			type = "go",
			name = "Debug main.go start --env=./",
			request = "launch",
			program = "${workspaceFolder}/main.go",
			args = { "start", "--env=./" },
			-- args = { "start", "--env=/home/vantien/Desktop/FPT/hi-ecom-survey-api/" },
			cwd = "${workspaceFolder}",
			trace = "verbose",
		},
		-- {
		-- 	type = "go",
		-- 	name = "Debug",
		-- 	request = "launch",
		-- 	program = "${file}",
		-- },
	},
	delve = {
		-- path = "/usr/bin/dlv",
		initialize_timeout_sec = 20,
		type = "server",
		host = "127.0.0.1",
		-- port = "${port}",
		port = 38697,
	},
})

dap.listeners.after.event_initialized["dapui_config"] = function()
	print("Debug session initialized")
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	print("Debug session terminated")
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	print("Debug session exited")
	dapui.close()
end

dap.listeners.after.launch_error["dapui_config"] = function(_, body)
	print("Launch error occurred")
	if body.message then
		print("Error message: " .. body.message)
	end
	if body.error then
		print("Detailed error: " .. vim.inspect(body.error))
	end
	print("Full error body: " .. vim.inspect(body))
end

vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, {})
-- vim.keymap.set("n", "<Leader>dc", dap.continue, {})
vim.keymap.set("n", "<Leader>dx", dap.terminate, {})
vim.keymap.set("n", "<Leader>dn", dap.step_over, {})
vim.keymap.set("n", "<Leader>di", dap.step_into, {})
vim.keymap.set("n", "<Leader>do", dap.step_out, {})
vim.keymap.set("n", "<Leader>dr", dap.repl.open, {})

vim.keymap.set("n", "<Leader>dc", function()
	print("Debug continue triggered")
	dap.continue()
end, {})

dap.set_log_level("TRACE")
