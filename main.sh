#/bin/bash

set -ue -o pipefail

SCRIPT_DIR=$(cd $(dirname "${0}"); pwd)
TARGET_NAME="${1%.*}"

platex "${TARGET_NAME}.tex"
dvipdfmx "${TARGET_NAME}.dvi"

rm "./${TARGET_NAME}.aux"
rm "./${TARGET_NAME}.dvi"
rm "./${TARGET_NAME}.log"

exit 0
