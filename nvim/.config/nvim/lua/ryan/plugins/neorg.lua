return {}
-- return {
--   "nvim-neorg/neorg",
--   lazy = false,
--   version = "*", -- Pin Neorg to the latest release
--   config = function()
--     require("neorg").setup({
--       load = {
--         ["core.defaults"] = {}, -- Load all the default modules
--         ["core.concealer"] = {}, -- Allows for use of icons
--         ["core.itero"] = {}, -- List/heading continuation
--         ["core.promo"] = {}, -- Increases/decreases nesting levels
--         ["core.qol.toc"] = {}, -- Generates a table of contents for a buffer
--         ["core.summary"] = {}, -- Creates links and annotations to all files in a workspace
--         ["core.journal"] = {}, -- Adds journaling capabilites
--         ["core.dirman"] = {
--           config = {
--             workspaces = {
--               notes = "~/notes",
--             },
--             index = "index.norg",
--             default_workspace = "notes",
--           },
--         },
--       },
--     })
--   end,
-- }
