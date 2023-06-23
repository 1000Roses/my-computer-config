-- import venv-selector plugin safely
local status, venv_selector = pcall(require, "venv-selector")
if not status then
	print("venv-selector not found ne")
	return
end

venv_selector.setup({})
