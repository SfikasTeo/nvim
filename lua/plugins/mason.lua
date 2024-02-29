-- lua/plugins/mason.lua
require("mason").setup{
    ui = {
        check_outdated_packages_on_open = true,
        keymaps = {
            uninstall_package = "dd",
            update_package = "u",
            check_package_version = "c",
            update_all_packages = "U",
            check_outdated_packages = "C",
        },
    },
    -- Use it to configure LSP servers or other tools that Mason has installed
    install_root_dir = vim.fn.stdpath("data") .. "/mason",
}
