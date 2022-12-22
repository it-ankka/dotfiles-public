local pack = "packer"

local function bootstrap(url, ref)
	local name = url:gsub(".*/", "")
	local path = vim.fn.stdpath [[data]] .. "/site/pack/".. pack .. "/start/" .. name

	if vim.fn.isdirectory(path) == 0 then
		print(name .. ": installing in data dir...")

		vim.fn.system {"git", "clone", url, path}
		if ref then
			vim.fn.system {"git", "-C", path, "checkout", ref}
		end

		vim.cmd [[redraw]]
		print(name .. ": finished installing")
	end
end

-- for git head
bootstrap("https://github.com/udayvir-singh/tangerine.nvim")
-- for git head
bootstrap("https://github.com/udayvir-singh/hibiscus.nvim")

require("tangerine").setup {
	-- save fnl output in a separate dir, it gets automatically added to package.path
	target = vim.fn.stdpath [[data]] .. "/tangerine",

	-- compile files in &rtp
	rtpdirs = {
		"plugin",
		"colors",
	},

	compiler = {
		-- disable popup showing compiled files
		verbose = false,

		-- compile every time changed are made to fennel files or on entering vim
		hooks = {"onsave", "oninit"}
	}
}
