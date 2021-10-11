function gdiff
    git diff --name-only --diff-filter=d | xargs bat --diff --style=full
end
