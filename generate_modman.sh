#!/bin/sh

rm modman && touch modman

function send_to_modman() {
    local file

    for file in "$@"; do
        echo "${file} ${file/src\//}" >> modman
    done
}

function send_directory_to_modman() {
    local directory sub_directories sub_directory

    for directory in $(echo "$1" | tr " " "\n"); do
        sub_directories=$(find ${directory} -type d -depth 1)
        if test "${sub_directories}" = ""; then
            if test "$(find ${directory} -type f -depth 1 ! -name '.?*')" = ""; then
                send_to_modman "${directory}"
            else
                send_to_modman $(find ${directory} -type f)
            fi
        else
            send_to_modman $(find ${directory} -type f -depth 1)
            for sub_directry in "${sub_directories}"; do
                send_directory_to_modman "${sub_directry}"
            done
        fi
    done
}

send_to_modman $(find src -type f -depth 1)
send_to_modman $(find src/app/code/core/Mage -depth 1)
send_to_modman $(find src/app/code/core/Zend -depth 1)

send_directory_to_modman "src/app/design/adminhtml/default/default"
send_directory_to_modman "src/app/design/frontend/base/default"
send_directory_to_modman "src/app/design/frontend/base/default"
send_directory_to_modman "src/app/design/frontend/default/blank"
send_directory_to_modman "src/app/design/frontend/default/default"
send_directory_to_modman "src/app/design/frontend/default/iphone"
send_directory_to_modman "src/app/design/frontend/default/modern"
send_directory_to_modman "src/app/design/frontend/rwd/default"
send_directory_to_modman "src/app/design/install/default/default"

send_to_modman $(find src/app/etc -type f -depth 1)
send_to_modman "src/app/etc/modules/*"

send_directory_to_modman "src/app/locale"

send_to_modman "src/app/.htaccess"
send_to_modman "src/app/Mage.php"

send_to_modman "src/downloader/*"
send_directory_to_modman "src/errors"
send_to_modman "src/includes/*"

send_directory_to_modman "src/js"

send_to_modman $(find src/lib -depth 1)

send_directory_to_modman "src/media"

send_to_modman "src/pkginfo"
send_to_modman "src/shell/*"

send_directory_to_modman "src/skin/adminhtml/default/default"
send_directory_to_modman "src/skin/frontend/base/default"
send_directory_to_modman "src/skin/frontend/default/blank"
send_directory_to_modman "src/skin/frontend/default/blue"
send_directory_to_modman "src/skin/frontend/default/default"
send_directory_to_modman "src/skin/frontend/default/french"
send_directory_to_modman "src/skin/frontend/default/german"
send_directory_to_modman "src/skin/frontend/default/iphone"
send_directory_to_modman "src/skin/frontend/default/modern"
send_directory_to_modman "src/skin/frontend/rwd/default"
send_directory_to_modman "src/skin/install/default/default"

send_directory_to_modman "src/var"
