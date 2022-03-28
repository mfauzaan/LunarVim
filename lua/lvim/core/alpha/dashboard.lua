local M = {}

function M.get_sections()
  local header = {
    type = "text",
    val = {
      " ██╗   ██╗██╗███╗   ███╗ ",
      " ██║   ██║██║████╗ ████║ ",
      " ██║   ██║██║██╔████╔██║ ",
      " ╚██╗ ██╔╝██║██║╚██╔╝██║ ",
      "  ╚████╔╝ ██║██║ ╚═╝ ██║ ",
      "   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
    },
    opts = {
      position = "center",
      hl = "Label",
    },
  }

  local text = require "lvim.interface.text"
  local git_utils = require "lvim.utils.git"

  local current_branch = git_utils.get_lvim_branch()

  local lvim_version
  if current_branch ~= "HEAD" or "" then
    lvim_version = current_branch .. "-" .. git_utils.get_lvim_current_sha()
  else
    lvim_version = "v" .. git_utils.get_lvim_tag()
  end

  local footer = {
    type = "text",
    val = text.align_center({ width = 0 }, {
      "",
      "mfauzaan",
      lvim_version,
    }, 0.5),
    opts = {
      position = "center",
      hl = "Number",
    },
  }

  local buttons = {
    entries = {
      { "SPC f", "  Find File", "<CMD>Telescope find_files<CR>" },
      { "SPC n", "  New File", "<CMD>ene!<CR>" },
      { "SPC P", "  Recent Projects ", "<CMD>Telescope projects<CR>" },
      { "SPC s r", "  Recently Used Files", "<CMD>Telescope oldfiles<CR>" },
      { "SPC s t", "  Find Word", "<CMD>Telescope live_grep<CR>" },
      {
        "SPC L c",
        "  Configuration",
        "<CMD>edit " .. require("lvim.config").get_user_config_path() .. " <CR>",
      },
    },
  }

  return {
    header = header,
    buttons = buttons,
    footer = footer,
  }
end

return M
