# This may seem pointless, but often the command is randomly cleared out of the
# fzf history and I forget exactly how it should be formed.
function list-droplets
    doctl compute droplet list --format "ID,Name"
end
