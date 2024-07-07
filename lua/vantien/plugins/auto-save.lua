local autosave_setup, autosave = pcall(require, "auto-save")
if not autosave_setup then
	return
end

-- configure autopairs
autosave.setup({
	enabled = true,
})
