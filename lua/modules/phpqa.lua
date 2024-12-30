
-- PHPQA -  :Php, :Phpcs, :Phpmd, :Phpcc
-- PHP Code Sniffer binary (default = "phpcs")
vim.g.phpqa_codesniffer_cmd=phpcs
vim.g.phpqa_codesniffer_args = "--standard=PSR12 -n"
vim.g.phpqa_codesniffer_autorun = 1

-- PHP Mess Detector binary (default = "phpmd")
vim.g.phpqa_messdetector_cmd=phpmd
vim.g.phpqa_messdetector_autorun = 1

-- Stop the location list opening automatically
vim.g.phpqa_open_loc = 1
