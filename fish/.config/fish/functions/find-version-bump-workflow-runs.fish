function find-version-bump-workflow-runs
    set -l owner (fd --type d --maxdepth 1 . ~/dev/github.com/ | sed 's/.*github.com\///; s/\/$//' | fzf)
    echo "Owner: $owner"

    set -l repo (find ~/dev/github.com/$owner -maxdepth 1 -mindepth 1 -type d -printf "%f\n" | fzf)
    echo "Repository: $repo"

    set page 1
    set continue true
    while $continue
        set rows (gh api "repos/$owner/$repo/actions/runs?branch=main&event=push&per_page=100&page=$page" | \
            jq --raw-output --arg workflow "Version Bump" \
            '.workflow_runs[] | select(.name == $workflow and .conclusion != "skipped") | "\(.created_at),\(.display_title),\(.conclusion),\(.html_url),\(.head_sha)"')
        for row in $rows
            set created_at (echo $row | cut -d ',' -f 1 | sed 's/T/ /' | sed 's/Z//' | \
                xargs -I{} date -d "{}" +'%Y-%m-%d %H:%M')
            set display_title (echo $row | cut -d ',' -f 2)
            set conclusion (echo $row | cut -d ',' -f 3)
            set url (echo $row | cut -d ',' -f 4)
            set commit_hash (echo $row | cut -d ',' -f 5)

            if test "$conclusion" = "success"
                printf "\e[32m%s -- %s\e[0m\n" $created_at $display_title
                printf "\e[32m%s\e[0m\n" $commit_hash
                printf "\e[32m%s\e[0m\n" $url
            else if test "$conclusion" = "failure"
                printf "\e[31m%s -- %s\e[0m\n" $created_at $display_title
                printf "\e[31m%s\e[0m\n" $commit_hash
                printf "\e[31m%s\e[0m\n" $url
            else
                printf "%s,%s,%s\n" $created_at $display_title
            end
            printf "\n"
        end

        echo "Continue? [y/n]"
        read -n 1 choice
        if test "$choice" = "n" -o "$choice" = "N"
            break
        end
        set page (math $page + 1)
    end
end
