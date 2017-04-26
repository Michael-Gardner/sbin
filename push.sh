#!/bin/bash

## FUNCTION BLOCK
function usage()
{
    echo "-s: <script>  execute script on remote targets"
    echo "-o: <object>  send object to remote targets"
    echo "-t: <targets> specify targets"
    echo "-u: <user>    alternate user for remote targets"
    echo "-h:           help"
    exit 0
}

## DEFAULTS
object=""
script=""
targets=()
user="${USER}"
verbose=0

while getopts ":o:s:t:u:hv" opt; do
    case ${opt} in
        o)
            object="${OPTARG}"
            ;;
        s)
            script="${OPTARG}"
            ;;
        t)
            targets=(${targets[@]} ${OPTARG})
            ;;
        u)
            user="${OPTARG}"
            ;;
        \?)
            echo "Invalid option: -${OPTARG}" >&2
            exit 1
            ;;
        :)
            echo "Option -${OPTARG} requires an argument" >&2
            exit 1
            ;;
        v)
            verbose=1
            ;;
        h)
            usage
            ;;
    esac
done

if [[ "${#targets[@]}" -eq 0 ]]; then
    ## load ip list
    OFS=${IFS}
    IFS='\n'
    targets=($(cat ~/ip.list))
    IFS=${OFS}
fi

for element in ${targets[@]}; do
    if [[ ! -z "${script}" ]]; then
        [[ ${verbose} -eq 1 ]] && echo "${script}" >&2
        ssh -tt -i ~/.ssh/hpcc_key_pair ${user}@${element} "${script}"
    fi
    if [[ ! -z "${object}" ]]; then
        scp -i ~/.ssh/hpcc_key_pair ${object} ${user}@${element}:/tmp
    fi
done

