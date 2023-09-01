#!/usr/bin/env bash

notify-send "Search an offline copy off the arch-wiki"

wikidir="/usr/share/doc/arch-wiki/html/"
lang="en/"

languages() {
    langs="$(find ${wikidir} -maxdepth 1 -type d -not -path "${wikidir}")"
    choice=$(printf '%s\n' "${langs[@]}" \
        | sed 's/.*\///' \
        | sort -g \
        | rofi -dmenu -i -selected-row 1 -p  'Language: ' "$@") || exit 1

    if [ "$choice" ]; then
        lang=$(printf '%s\n' "${choice}/")
        wikipages "$@"
    else
        echo "Program terminated." && exit 0
    fi
}

wikipages() {
    wikidocs="$(find ${wikidir}"${lang}" -iname "*.html")"
    choice=$(printf '%s\n' "${wikidocs[@]}" \
        | cut -d '/' -f8- \
        | sed -e 's/_/ /g' -e 's/.html//g' \
        | sort -g \
        | rofi -dmenu -i -selected-row 1 -p 'Arch Wiki Docs: ' "$@") || exit 1

    if [ "$choice" ]; then
        article=$(printf '%s\n' "${wikidir}${lang}${choice}.html" | sed 's/ /_/g')
        firefox "$article"
    else
        echo "Program terminated." && exit 0
    fi
}

wikipages "en"
