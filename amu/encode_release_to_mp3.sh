#!/usr/bin/env bash

release_id=$1
consumer_key="ujteSPrEAXsVvqTWrRiU"
consumer_secret="XSglsnOKXACMLbhaAiVbhYVwJJbANMAV"
present_directory=$(pwd)

if [[ -z "${release_id// }" ]]; then
    echo "A release ID must be supplied."
    exit 1
fi

function get_image()
{
    primary_image_url=$(curl https://api.discogs.com/releases/$release_id --user-agent "amu/0.1" -H "Authorization: Discogs key=ujteSPrEAXsVvqTWrRiU, secret=XSglsnOKXACMLbhaAiVbhYVwJJbANMAV"  | jq '.images | map(select(.type == "primary")) | .[]["resource_url"]')
    if [[ ! -z $primary_image_url ]]; then
        primary_image_url=$(curl https://api.discogs.com/releases/$release_id --user-agent "amu/0.1" -H "Authorization: Discogs key=ujteSPrEAXsVvqTWrRiU, secret=XSglsnOKXACMLbhaAiVbhYVwJJbANMAV"  | jq '.images | map(select(.type == "primary")) | .[]["resource_url"]')
        # curl wouldn't download the image without the quotes removed.
        url_without_surrounding_quotes="${primary_image_url%\"}"
        url_without_surrounding_quotes="${url_without_surrounding_quotes#\"}"
        curl $url_without_surrounding_quotes >> cover.jpg
    else
        secondary_image_url=$(curl https://api.discogs.com/releases/$release_id --user-agent "amu/0.1" -H "Authorization: Discogs key=ujteSPrEAXsVvqTWrRiU, secret=XSglsnOKXACMLbhaAiVbhYVwJJbANMAV"  | jq '.images | .[]["resource_url"]')
        url_without_surrounding_quotes="${secondary_image_url%\"}"
        url_without_surrounding_quotes="${url_without_surrounding_quotes#\"}"
        curl $url_without_surrounding_quotes >> cover.jpg
    fi
}

function rip_cd()
{
    amu rip
    amu encode wav mp3 --keep-source --discogs-id=$release_id
}

[[ -d "$release_id" ]] && rm -rf "$release_id"
mkdir "$release_id"
cd "$release_id"
get_image
rip_cd
get_image # The image is moved in the encoding process, so re-download it.
cd $present_directory
