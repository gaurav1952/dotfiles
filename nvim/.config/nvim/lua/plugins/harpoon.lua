return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require('harpoon')
        harpoon:setup({})

        -- Telescope integration
        local conf = require("telescope.config").values
        local function toggle_telescope(harpoon_files)
            local file_paths = {}
            for _, item in ipairs(harpoon_files.items) do
                table.insert(file_paths, item.value)
            end
            require("telescope.pickers").new({}, {
                prompt_title = "Harpoon",
                finder = require("telescope.finders").new_table({
                    results = file_paths,
                }),
                previewer = conf.file_previewer({}),
                sorter = conf.generic_sorter({}),
            }):find()
        end

        -- Keymaps
        local map = vim.keymap.set

        map("n", "<C-p>", function() toggle_telescope(harpoon:list()) end, { desc = "Open harpoon window" })
        map("n", "<leader>a", function() harpoon:list():add() end, { desc = "Add file to harpoon" })

        -- Jump to file 1-4
        map("n", "<C-1>", function() harpoon:list():select(1) end, { desc = "Harpoon file 1" })
        map("n", "<C-2>", function() harpoon:list():select(2) end, { desc = "Harpoon file 2" })
        map("n", "<C-3>", function() harpoon:list():select(3) end, { desc = "Harpoon file 3" })
        map("n", "<C-4>", function() harpoon:list():select(4) end, { desc = "Harpoon file 4" })
    end
}
