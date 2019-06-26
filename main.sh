#/bin/bash

set -ue -o pipefail

readonly SCRIPT_PATH=$(readlink "${0}" || (echo $(cd $(dirname "${0}"); pwd)/$(basename "${0}")))
readonly SCRIPT_DIR=$(dirname "${SCRIPT_PATH}")
readonly SCRIPT_NAME=$(basename "${SCRIPT_PATH}")

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
    local _target_name="${1%.*}"

    platex "${_target_name}.tex"
    dvipdfmx "${_target_name}.dvi"

    rm "./${_target_name}.aux"
    rm "./${_target_name}.dvi"
    rm "./${_target_name}.log"
    return 0
}

readonly SUBCOMMAND=${1:-}

shift 1

case ${SUBCOMMAND} in
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
