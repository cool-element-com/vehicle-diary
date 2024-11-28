#!/bin/sh
pwd
cd iOS/VehicleDiary
ls -aril
scheme_list=$(xcodebuild -list -json | tr -d "\n")
echo $scheme_list
# default=$(echo $scheme_list | ruby -e "require 'json'; puts JSON.parse(STDIN.gets)['project']['targets'][0]")
# echo $default | cat >default
# echo Using default scheme: $default
