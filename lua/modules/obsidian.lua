require("obsidian").setup({
  dir = "~/Notes/Work",
  workspaces = {
    {
      name = "Personal",
      path = "~/Notes/Personal",
    },
    {
      name = "Work",
      path = "~/Notes/Work",
    },
  },
  daily_notes = {
    folder = "/Dailies",
  },
  note_id_func = function(title)
    local suffix = ""
    if title ~= nil then
      -- If title is given, transform it into valid file name.
      suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
    else
      -- If title is nil, just add 4 random uppercase letters to the suffix.
      for _ = 1, 4 do
        suffix = suffix .. string.char(math.random(65, 90))
      end
    end
    return tostring(os.time()) .. "-" .. suffix
  end,
})
