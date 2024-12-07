#!/bin/sh
set -e

WHITE_ON_BLUE='\033[37;44m'
YELLOW_ON_BLUE='\033[33;44m'
NC='\033[0m' # no color

log_command() {
    echo "${YELLOW_ON_BLUE}${1}${NC}"
}

log_command "hello runtime :)"
log_command "we are ready to run some shell commands"
pwd

# cd iOS/VehicleDiary
# ls -aril
# scheme_list=$(xcodebuild -list -json | tr -d "\n")
# default=$(echo $scheme_list | ruby -e "require 'json'; puts JSON.parse(STDIN.gets)['project']['targets'][0]")
# echo $default | cat >default
# echo Using default scheme: $default
