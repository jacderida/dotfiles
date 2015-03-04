#!/usr/bin/env bash

# Maven
# thanks to:  http://blog.blindgaenger.net/colorize_maven_output.html
# and: http://johannes.jakeapp.com/blog/category/fun-with-linux/200901/maven-colorized
# Colorize Maven Output
alias maven="command mvn"
function color_maven
{
    local BLACK='[0;30m'
    local BLUE='[0;34m'
    local GREEN='[0;32m'
    local CYAN='[0;36m'
    local RED='[0;31m'
    local PURPLE='[0;35m'
    local ORANGE='[0;33m'
    local LIGHT_GRAY='[0;37m'
    local DARK_GRAY='[1;30m'
    local LIGHT_BLUE='[1;34m'
    local LIGHT_GREEN='[1;32m'
    local LIGHT_CYAN='[1;36m'
    local LIGHT_RED='[1;31m'
    local LIGHT_PURPLE='[1;35m'
    local YELLOW='[1;33m'
    local WHITE='[1;37m'
    local NO_COLOUR='[0m'

    maven $* | sed \
        -e "s/Tests run: \([^,]*\), Failures: \([^,]*\), Errors: \([^,]*\), Skipped: \([^,]*\)/${LIGHT_GREEN}Tests run: \1$NO_COLOUR, Failures: $RED\2$NO_COLOUR, Errors: $RED\3$NO_COLOUR, Skipped: $ORANGE\4$NO_COLOUR/g" \
        -e "s/\(\[WARNING\].*\)/$ORANGE\1$NO_COLOUR/g" \
        -e "s/\(\[ERROR\].*\)/$RED\1$NO_COLOUR/g" \
        -e "s/\(\(BUILD \)\{0,1\}FAILURE.*\)/$RED\1$NO_COLOUR/g" \
        -e "s/\(\(BUILD \)\{0,1\}SUCCESS.*\)/$GREEN\1$NO_COLOUR/g" \
        -e "s/\(\[INFO\].*\)/$LIGHT_GRAY\1$NO_COLOUR/g"
    return $PIPESTATUS
}
alias mvn=color_maven

# Vagrant
alias vup="vagrant up"
alias vaws="vagrant up --provider=aws"
alias vrs="vagrant up --provider=rackspace"
alias vdest="vagrant destroy -f"
alias vssh="vagrant ssh"

# SVN
alias svnadd="svn status | grep -v "^.[ \t]*\..*" | grep "^?" | awk '{print $2}' | xargs svn add"
alias svnrm="svn status | grep -v "^.[ \t]*\..*" | grep "^!" | awk '{print $2}' | xargs svn rm"

# Docker
alias docker_stop_containers="sudo docker ps -a -q | xargs -n 1 -I {} sudo docker stop {}"
alias docker_remove_containers="sudo docker ps -a -q | xargs -n 1 -I {} sudo docker rm {}"
alias docker_remove_images="sudo docker images -q | xargs -n 1 -I {} sudo docker rmi {}"

# Misc
alias cat="pygmentize -O style=monokai -f console256 -g"
alias list_ec2_instances="aws ec2 describe-instances | jq '.[] | .[] | .Instances[] | { image_id: .InstanceId, name: .Tags[][\"Value\"], public_ip: .PublicDnsName }'"
alias colourtest="perl $HOME/bin/colourtest -w"
