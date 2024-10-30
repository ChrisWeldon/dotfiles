local DeployVitekAIMB275 = function ()
    folder = "\"C:\\Users\\adm16015577\\projects\\VMs\\Development - VITEK AIMB 275\\shared_folder\\PitRelMgmt\""
    os.execute("rm -r " .. folder)
    os.execute("mkdir " ..folder)
    vim.fn.jobstart("dotnet build /p:OutputPath=" .. folder)
end

vim.api.nvim_create_user_command('BuildVitek275', DeployVitekAIMB275, {})
