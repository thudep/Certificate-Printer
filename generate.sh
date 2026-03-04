#!/usr/bin/env bash

processBar()
{
    local current=$1
    local total=$2
    local name=$3
    local title=$4
    local content=$5
    local percentage=$((current*100/total))
    printf "\r[INF] Processing: $name, $title, $content - $current/$total ($percentage%%)"
}

# Read Parameters
while getopts ":s:t:h" opts; do
    case ${opts} in
        s)  secret=$OPTARG
            echo "[INF] Using Secret: $secret"
            ;;
        t)  template=$OPTARG
            echo "[INF] Using template: $template"
            ;;
        h)
            echo "Usage: $0 [-s <secret>] [-t <template>]"
            echo
            echo "Options:"
            echo "  -s <secret>     Provide secret key manually."
            echo "                  If not specified, the script reads from secret.txt."
            echo
            echo "  -t <template>   Specify Typst template file."
            echo "                  Default: award.typ"
            echo
            echo "  -h              Show this help message and exit."
            exit 0
            ;;
        \?) echo "[ERR] Invalid option: $OPTARG, Use -h for help"
            exit 1
            ;;
    esac
done

if [ -z "$secret" ]; then
    echo "[INF] No secret provided. Using default key in secret.txt"
    if [ -f secret.txt ]; then
        secret=$(cat secret.txt)
        if [ -z "$secret" ]; then
            echo "[ERR] secret.txt is empty"
            exit 1
        fi
        echo "[INF] Using Secret: $secret"
    else
        echo "[ERR] secret.txt not found"
        exit 1
    fi
fi

if [ -z "$template" ]; then
    template="award.typ"
    echo "[INF] No template specified. Using default: $template"
fi

# Run the script

mkdir -p output

whole=$(wc -l < list.csv)
process=0

while IFS=',' read -r name title content; do
    echo "$name" > name.typ
    echo "$title" > title.typ
    echo "$content" > content.typ

    combined="${name}${title}${content}${secret}"
    echo -n "$combined" \
        | tr -d '[:space:]' \
        | sha256sum \
        | awk '{print $1}' \
        | xxd -r -p \
        | base32 \
        | tr -d '=' \
        | tr 'A-Z' 'A-Z' \
        | cut -c1-10 \
        > fingerprint.typ

    typst compile "$template" "output/${name}-${title}-${content}.pdf"

    process=$((process+1))
    processBar $process $whole "$name" "$title" "$content"
done < list.csv

echo
echo "[INF] Completed"
