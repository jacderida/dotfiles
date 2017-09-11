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

# Tools
function run_azure() {
    docker run --rm \
    -v ~/.azure:/home/user/.azure \
    -v ~/.ssh:/home/user/.ssh:ro \
    -v ~/bin:/home/user/bin \
    -v ~/.bashrc:/home/user/.bashrc \
    -v $(pwd):/home/user/$(basename `pwd`) \
    -h azure-0-10-6 \
    -u user -it jacderida/azure-cli:0.10.6
}
alias azure="run_azure"

function run_terragrunt() {
    docker run --rm \
    -v ~/.terraform:/home/user/.terraform \
    -v ~/.azure:/home/user/.azure \
    -v ~/.ssh:/home/user/.ssh:ro \
    -v ~/bin:/home/user/bin \
    -v ~/.bashrc:/home/user/.bashrc \
    -v $(pwd):/home/user/$(basename `pwd`) \
    -h terragrunt-0-11-0 \
    -u user -it jacderida/terragrunt:0.11.0
}
alias terragrunt="run_terragrunt"

function run_aws() {
    docker run --rm \
    -v ~/.aws_keys:/home/user/.aws_keys \
    -v ~/.aws:/home/user/.aws \
    -v ~/.ssh:/home/user/.ssh:ro \
    -v ~/bin:/home/user/bin \
    -v ~/.bashrc:/home/user/.bashrc \
    -v $(pwd):/home/user/$(basename `pwd`) \
    -h aws-1-11-57 \
    -u user -it jacderida/awscli:1.11.57
}
alias aws="run_aws"

function run_ansible() {
    docker run --rm \
    -v ~/.ssh:/home/user/.ssh \
    -v ~/.bashrc:/home/user/.bashrc \
    -v ~/.ansible:/home/user/.ansible \
    -v $(pwd):/home/user/$(basename `pwd`) \
    -h ansible-2-1-0-0 \
    -u user -it jacderida/ansible:2.1.0.0
}
alias ansible="run_ansible"

function run_oc() {
    docker run --rm \
    -v ~/.ssh:/home/user/.ssh \
    -v ~/.bashrc:/home/user/.bashrc \
    -v $(pwd):/home/user/$(basename `pwd`) \
    -v ~/.docker:/home/user/.docker \
    -h oc-3-1-1-6 \
    -u user -it jacderida/openshift-enterprise-client-tools:3.1.1.6
}
alias oc-enterprise="run_oc"

# Vagrant
alias vup="vagrant up"
alias vaws="vagrant up --provider=aws"
alias vrs="vagrant up --provider=rackspace"
alias vdest="vagrant destroy -f"
alias vssh="vagrant ssh"

# SVN
alias svnadd="svn status | grep -v \"^.[ \t]*\..*\" | grep \"^?\" | awk '{print $2}' | xargs svn add"
alias svnrm="svn status | grep -v \"^.[ \t]*\..*\" | grep \"^!\" | awk '{print $2}' | xargs svn rm"

# Misc
alias cat="pygmentize -O style=monokai -f console256 -g"
alias colourtest="perl $HOME/bin/colourtest -w"
alias amu="python $HOME/dev/automated_music_utils/amu/clidriver.py"
