#!/bin/bash

performPodInstallAndCaptureOutput() {
    # Capture variable but preserve console output - https://stackoverflow.com/a/12451419/4124265
    # Preserve colors - https://stackoverflow.com/a/3515296/4124265
    exec 5>&1
    set -o pipefail
    pod_install_output=`script -q /dev/null pod install | tee /dev/fd/5`
}

# Assume scripts are placed in /Scripts/Cocoapods dir
_script_call_path="${BASH_SOURCE%/*}"
if [[ ! -d "${_script_call_path}" ]]; then _script_call_path=$(dirname "$0"); fi
cd "${_script_call_path}"

. utils.sh

cd ..
cd ..

set +e
performPodInstallAndCaptureOutput
exit_code=$?
set -e

# Check if repo needs update
# * `31` Spec not found (i.e out-of-date source repos, mistyped Pod name etc...)
echo "Exit code: ${exit_code}"
if [ ${exit_code} -eq 31 ] || [ ${exit_code} -eq 1 ]; then
    echo "Fixing outdated repo"
    pod repo update
    pod_install_output=`script -q /dev/null pod install | tee /dev/fd/5`
    
elif [ ${exit_code} -eq 0 ]; then
    # Break
    :
    
else
    exit ${exit_code}
fi

# Check if there is a license warning caused by a broken pods cache.
# [!] Unable to read the license file `LICENSE` for the spec `FirebaseCoreDiagnostics (1.3.0)`
# Filter out `LogsManager` missing LICENSE because of the bug - https://github.com/leavez/cocoapods-binary/pull/122
filtered_pod_install_output=$(echo "${pod_install_output}" | grep -v 'LICENSE.*LogsManager')
if [[ "${filtered_pod_install_output}" == *LICENSE* ]]; then
    echo "Fixing broken Pods cache"
    rm -rf "Pods"
    pod cache clean --all
    pod install
fi

echo "Fixing warnings"
fixWarnings
