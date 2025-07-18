-- Function to generate a prompt that reads all current buffers
local function generate_read_all_buffers_prompt()
    local buffers = {}
    local prompt_parts = {}

    -- Get all loaded buffers
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        -- Check if buffer is loaded and has a valid file name
        if vim.api.nvim_buf_is_loaded(buf) then
            local buf_name = vim.api.nvim_buf_get_name(buf)
            local buf_type = vim.api.nvim_buf_get_option(buf, 'buftype')

            -- Only include normal file buffers (not terminal, help, etc.)
            if buf_name ~= "" and buf_type == "" then
                -- Get relative path if possible, otherwise use full path
                local relative_path = vim.fn.fnamemodify(buf_name, ':.')
                table.insert(buffers, relative_path)
            end
        end
    end

    -- Generate the prompt
    table.insert(prompt_parts, "Please read all my currently open buffers to understand the context of my codebase:")
    table.insert(prompt_parts, "")

    -- Add read_file tool calls for each buffer
    for _, file_path in ipairs(buffers) do
        table.insert(prompt_parts, "<tool>read_file</tool>")
        table.insert(prompt_parts, "{")
        table.insert(prompt_parts, string.format('  "path": "%s"', file_path))
        table.insert(prompt_parts, "}")
        table.insert(prompt_parts, "")
    end

    table.insert(prompt_parts, "Now that you have context of all my open files, ")

    return table.concat(prompt_parts, "\n")
end

-- Function to copy the prompt to clipboard
local function copy_read_all_buffers_prompt()
    local prompt = generate_read_all_buffers_prompt()
    vim.fn.setreg('+', prompt)
    print("Read all buffers prompt copied to clipboard!")
end

-- Function to insert the prompt at cursor position
local function insert_read_all_buffers_prompt()
    local prompt = generate_read_all_buffers_prompt()
    local lines = vim.split(prompt, '\n')
    vim.api.nvim_put(lines, 'l', true, true)
end

-- Create user commands
vim.api.nvim_create_user_command('ReadAllBuffersPrompt', copy_read_all_buffers_prompt, {})
vim.api.nvim_create_user_command('InsertReadAllBuffersPrompt', insert_read_all_buffers_prompt, {})

-- Optional: Create a keybinding
vim.keymap.set('n', '<leader>rab', copy_read_all_buffers_prompt, {
    desc = 'Copy read all buffers prompt to clipboard'
})

-- Return functions for use in other scripts
return {
    generate_prompt = generate_read_all_buffers_prompt,
    copy_prompt = copy_read_all_buffers_prompt,
    insert_prompt = insert_read_all_buffers_prompt
}
