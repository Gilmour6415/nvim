local keifu = require("keifu")

keifu.setup({})

vim.api.nvim_create_user_command("Keifu", function(o)
  if o.bang then
    keifu.close()
    return
  end
  keifu.open(o.args ~= "" and { cwd = o.args } or nil)
end, { desc = "Open keifu (git graph TUI)", nargs = "?", complete = "dir", bang = true })
