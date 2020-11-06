#!/bin/bash

set -e

base_dir=$(dirname "$0")
cd "$base_dir"

removeParam() {
    sed -e "/${1}/d"
}

removeBadParams() {
    removeParam '"CFFIXED_USER_HOME"' | removeParam '"HOME"' | removeParam '"TMPDIR"' | removeParam '"XPC_SERVICE_NAME"'
}

# Compute unit tests diff from ordinary start
unit_tests_from_ordinary_start_diff=$(comm -23 Simulator_UnitTests_Environment.json Simulator_NotTests_Environment.json)

# Compute UI tests diff from ordinary start
ui_tests_from_ordinary_start_diff=$(comm -23 Simulator_UITests_Environment.json Simulator_NotTests_Environment.json)

# Compute unit tests diff from UI tests
unit_tests_unique=$(comm -23 <(echo "${unit_tests_from_ordinary_start_diff}") <(echo "${ui_tests_from_ordinary_start_diff}") | removeBadParams)
echo -e "\nUnique unit tests sctrings"
echo "${unit_tests_unique}"
echo "${unit_tests_unique}" > "UnitTests_Unique.json"

# Compute UI diff from unit tests
ui_tests_unique=$(comm -13 <(echo "${unit_tests_from_ordinary_start_diff}") <(echo "${ui_tests_from_ordinary_start_diff}") | removeBadParams)
echo -e "\nUnique UI tests sctrings"
echo "${ui_tests_unique}"
echo "${ui_tests_unique}" > "UITests_Unique.json"
