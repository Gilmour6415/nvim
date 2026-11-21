return {
  "isakbm/gitgraph.nvim",
  init = function()
    -- 默认 message 色 #339921 在深色终端上过暗，提亮
    local hls = require("gitgraph.highlights")
    hls.ITEM_HGS.message.fg = "#9ece6a"
    -- colorscheme 加载晚于 gitgraph setup，其 highlight clear 会抹掉这些组，切换后补回
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function()
        hls.set_highlights()
      end,
    })
  end,
  opts = {
    hooks = {
      on_select_commit = function(commit)
        vim.cmd("DiffviewOpen " .. commit.hash .. "^!")
      end,
      on_select_range_commit = function(from, to)
        vim.cmd("DiffviewOpen " .. from.hash .. "~1.." .. to.hash)
      end,
    },
  },
}
