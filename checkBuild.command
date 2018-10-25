#!/bin/bash

base_dir=$(dirname "$0")
cd "$base_dir"

xcodebuild -workspace "Example/APExtensions.xcworkspace" -scheme "APExtensions-Example" -configuration "Release" | xcpretty
xcodebuild -project "CarthageSupport/APExtensions-example.xcodeproj" -alltargets | xcpretty
