#!/bin/bash

set -e

base_dir=$(dirname "$0")
cd "$base_dir"

set -o pipefail && xcodebuild -workspace "Example/APExtensions.xcworkspace" -scheme "APExtensions-Example" -configuration "Release"  -sdk iphonesimulator12.1 | xcpretty
echo
carthage build --no-skip-current

echo ""
echo "SUCCESS!"
