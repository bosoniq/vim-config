local prompt_library = {
    ["Generate PHPUnit Tests"] = {
      strategy = "chat",
      description = "Generate unit tests, including the file itself and any subdirectories",
      prompts = {
        {
          role = "system",
          content = "You are an experienced PHP developer working with Symfony, Phpunit and Neovim",
        },
        {
          role = "user",
          content = "Read the php file in the #buffer and extract the subfolders the file is located. For each subfolder excluding <folder>src</folder> create the same structure in the <directory>./tests/Unit/</directory> if it does not already exist using the @create_file tool."
        },
        {
          role = "user",
          content = "Analyse the code defined in the #buffer, generate phpunit tests with the Given,When,Then naming style including code comments to explain the basic context of each test and create a new php unit test file using the @create_file tool."
        }
      },
    }
}

return prompt_library
