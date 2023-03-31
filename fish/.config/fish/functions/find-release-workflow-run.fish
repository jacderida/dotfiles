function find-release-workflow-run
    set -l owner (fd --type d --maxdepth 1 . ~/dev/github.com/ | sed 's/.*github.com\///; s/\/$//' | fzf)
    echo "Owner: $owner"

    set -l repo (find ~/dev/github.com/$owner -maxdepth 1 -mindepth 1 -type d -printf "%f\n" | fzf)
    echo "Repository: $repo"

    set -l commit (bash -c "cd ~/dev/github.com/$owner/$repo && \
        git log --oneline --grep '^chore(release):' --pretty=format:'%H %s' | fzf | awk '{print \$1}'")
    echo "Commit: $commit"

    set page 1
    set continue true
    while $continue
        set -l url (gh api "repos/$owner/$repo/actions/runs?branch=main&event=push&per_page=100&page=$page" | \
            jq --raw-output --arg commit "$commit" --arg workflow "release" \
            '.workflow_runs[] | select(.head_sha == $commit and .name == $workflow) | .html_url')
        if test -z $url
            echo "Release run not found for $commit. Try another page? [y/n]"
            read -n 1 choice
            if test "$choice" = "n" -o "$choice" = "N"
                set continue false
            end
            set page (math $page + 1)
        else
            echo $url
            set continue false
        end
    end
end
