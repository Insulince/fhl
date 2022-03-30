#!/usr/bin/env bash

# A simple shell script to be executed each time before building the CLI to increment the build number.
# I have setup my IDE to do this automatically.

# Get the current build number.
BUILD_NUMBER=$(
  cat "./cli/version.go" | # Output contents of version.go
    tail -n 2 |            # Grab the last two lines.
    head -n 1 |            # Of those last two lines, grab the first.
    cut -d ' ' -f3         # Split up that line into a list of strings by spaces, and grab only the 3rd such string.
)                          # The resulting string is the current build number. Store it in BUILD_NUMBER.

# Increment build number by 1.
BUILD_NUMBER=$((BUILD_NUMBER + 1))

# Find a line in version.go which looks like "build = <number>", and replace it with "build = <new_build_number>".
sed -i -e "s/\\tbuild = .*/\\tbuild = ${BUILD_NUMBER}/g" "./cli/version.go"
