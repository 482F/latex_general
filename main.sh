#/bin/bash

set -ue -o pipefail

SCRIPT_PATH=$(readlink "${0}" || (echo $(cd $(dirname "${0}"); pwd)/$(basename "${0}")))
SCRIPT_DIR=$(dirname "${SCRIPT_PATH}")
SCRIPT_NAME=$(basename "${SCRIPT_PATH}")

usage(){
    echo "mytex subcommand"
    echo "subcommand:"
    echo "    compile"
    echo "    help"
    return 1
}

install(){
    sudo ln -s "${SCRIPT_DIR}/${SCRIPT_NAME}" "/usr/local/bin/mytex"
    return 0
}

init(){
    cp -n "${SCRIPT_DIR}/template.tex" "./main.tex"
    return 0
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
    install)
        install $@;;
    init)
        init $@;;
    compile)
        compile $@;;
    *)
        usage $@;;
esac

exit 0
