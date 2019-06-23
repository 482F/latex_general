#/bin/bash

set -ue -o pipefail

SCRIPT_DIR=$(cd $(dirname "${0}"); pwd)
TARGET_TEX="${1}"
TARGET_DVI="${TARGET_TEX%.*}.dvi"

platex "${TARGET_TEX}"
dvipdfmx "${TARGET_DVI}"

exit 0
