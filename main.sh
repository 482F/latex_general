#/bin/bash

set -ue -o pipefail

SCRIPT_DIR=$(cd $(dirname "${0}"); pwd)
SCRIPT_NAME=$(basename "${0}")

usage(){
    echo "mytex subcommand"
    echo "subcommand:"
    echo "    compile"
    echo "    help"
    return 1
}


compile(){
    TARGET_NAME="${1%.*}"

    platex "${TARGET_NAME}.tex"
    dvipdfmx "${TARGET_NAME}.dvi"

    rm "./${TARGET_NAME}.aux"
    rm "./${TARGET_NAME}.dvi"
    rm "./${TARGET_NAME}.log"
    return 0
}

case ${1:-} in
    compile)
        compile $@;;
    *)
        usage $@;;
esac

exit 0
