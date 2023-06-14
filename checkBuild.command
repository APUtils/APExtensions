#!/bin/bash

set -e

base_dir=$(dirname "$0")
cd "$base_dir"

echo ""
echo -e "\nChecking Carthage integrity..."
pbxproj_path='CarthageSupport/APExtensions-example.xcodeproj/project.pbxproj'
swift_files=$(find 'APExtensions/Classes' -type f -name "*.swift" | grep -o "[0-9a-zA-Z+ ]*.swift" | sort -fu | grep -v "Dummy.swift")
swift_files_count=$(echo "${swift_files}" | wc -l | tr -d ' ')

build_section_id=$(sed -n -e '/\/\* APExtensions \*\/ = {/,/};/p' "${pbxproj_path}" | sed -n '/PBXNativeTarget/,/Sources/p' | tail -1 | tr -d "\t" | cut -d ' ' -f 1)
swift_files_in_project=$(sed -n "/${build_section_id}.* = {/,/};/p" "${pbxproj_path}" | grep -o "[A-Z].[0-9a-zA-Z+ ]*\.swift" | sort -fu)
swift_files_in_project_count=$(echo "${swift_files_in_project}" | wc -l | tr -d ' ')
if [ "${swift_files_count}" -ne "${swift_files_in_project_count}" ]; then
    echo  >&2 "error: Carthage project missing dependencies."
    echo -e "\nFinder files:\n${swift_files}"
    echo -e "\nProject files:\n${swift_files_in_project}"
    echo -e "\nMissing dependencies:"
    comm -23 <(echo "${swift_files}") <(echo "${swift_files_in_project}")
    echo " "
	exit 1
fi

echo -e "\nBuilding Swift Package for iOS..."
swift build -Xswiftc "-sdk" -Xswiftc "`xcrun --sdk iphonesimulator --show-sdk-path`" -Xswiftc "-target" -Xswiftc "x86_64-apple-ios16.2-simulator"

echo -e "\nBuilding Swift Package project..."
set -o pipefail && xcodebuild -project "PackageExample/APExtensions-Package.xcodeproj" -sdk iphonesimulator -scheme "APExtensions-Package" | xcpretty

echo -e "\nBuilding Pods project..."
set -o pipefail && xcodebuild -workspace "Example/APExtensions.xcworkspace" -scheme "APExtensions-Example" -configuration "Release" -sdk iphonesimulator | xcpretty

echo -e "\nBuilding Carthage projects..."
. "./CarthageSupport/Scripts/Carthage/utils.sh"
applyXcode12Workaround
set -o pipefail && xcodebuild -project "CarthageSupport/APExtensions-example.xcodeproj" -sdk iphonesimulator -target "APExtensions-example" | xcpretty
set -o pipefail && xcodebuild -project "CarthageSupport/APExtensions-example.xcodeproj" -sdk iphonesimulator -target "APExtensionsStoryboard" | xcpretty
set -o pipefail && xcodebuild -project "CarthageSupport/APExtensions-example.xcodeproj" -sdk iphonesimulator -target "APExtensionsViewModel" | xcpretty

echo -e "\nPerforming tests..."
simulator_id="$(xcrun simctl list devices available iPhone | grep " SE " | tail -1 | sed -e "s/.*(\([0-9A-Z-]*\)).*/\1/")"
if [ -n "${simulator_id}" ]; then
    echo "Using iPhone SE simulator with ID: '${simulator_id}'"

else
    simulator_id="$(xcrun simctl list devices available iPhone | grep "^    " | tail -1 | sed -e "s/.*(\([0-9A-Z-]*\)).*/\1/")"
    if [ -n "${simulator_id}" ]; then
        echo "Using iPhone simulator with ID: '${simulator_id}'"
        
    else
        echo  >&2 "error: Please install iPhone simulator."
        echo " "
        exit 1
    fi
fi

set -o pipefail && xcodebuild -workspace "Example/APExtensions.xcworkspace" -sdk iphonesimulator -scheme "APExtensions-Example" -destination "platform=iOS Simulator,id=${simulator_id}" test | xcpretty

echo ""
echo "SUCCESS!"
echo ""
echo ""
