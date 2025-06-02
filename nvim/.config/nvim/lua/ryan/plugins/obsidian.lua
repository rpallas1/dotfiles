--- Check if a path exists
---@param path string
---@return boolean
local function path_exists(path)
  local stat = vim.loop.fs_stat(path)
  return stat ~= nil
end

-- Trim function to remove leading and trailing whitespace
---@param s string
---@return string
local function trim(s)
  return (s:gsub("^%s*(.-)%s*$", "%1")) -- Remove leading and trailing whitespace
end

return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",
  },

  opts = {
    workspaces = {
      {
        name = "personal",
        path = "~/vaults/personal",
      },
      {
        name = "work",
        path = "~/vaults/work",
      },
    },

    note_id_func = function(title)
      -- If no title is given, generate a timestamp
      local new_title = title or ""

      if title == nil then
        for _ = 1, 4 do
          new_title = new_title .. string.char(math.random(65, 90)) -- Generate a random uppercase letter
        end
      else
        new_title = trim(new_title):gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      end

      return new_title .. "-" .. tostring(os.time())
    end,

    note_path_func = function(spec)
      local full_path = tostring(spec.dir)

      if path_exists(full_path) then
        -- If the file already exists, return the full path
        local path = spec.dir / tostring(spec.id)
        return path:with_suffix(".md")
      end

      -- If the path does not exist, then take the last segment and make lowercase and replace spaces with dashes
      local split_path = vim.split(full_path, "/")
      local last_segment = trim(split_path[#split_path])
      local new_path = "/"

      -- Remove the first item in the split_path if it is empty (this happens if the path starts with a slash)
      if split_path[1] == "" then
        table.remove(split_path, 1)
      end

      for segment = 1, #split_path - 1 do
        new_path = new_path .. split_path[segment] .. "/"
      end

      new_path = new_path .. last_segment:gsub(" ", "-"):lower()

      local Path = require("obsidian.path")
      local final_path = Path:new(new_path)

      final_path = final_path / tostring(spec.id)

      return final_path:with_suffix(".md")
    end,

    ui = { enable = false }, -- disable the UI, since we use the `:ObsidianOpen` command to open notes
  },
}
