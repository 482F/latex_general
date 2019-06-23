#/bin/bash

set -ue -o pipefail

SCRIPT_DIR=$(cd $(dirname "${0}"); pwd)
TARGET_NAME="${1%.*}"

platex "${TARGET_NAME}.tex"
dvipdfmx "${TARGET_NAME}.dvi"

exit 0
