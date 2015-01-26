#!/usr/local/bin/bash

# Symlinking fish config
echo "Creating symlink to configs/config.fish in ~/.config/fish/…"
LINKED_FILE="${HOME}/.config/fish/config.fish"
[[ ! -d "${HOME}/.config/fish" ]] && mkdir -p
[[ -f "${LINKED_FILE}" ]] && mv "${LINKED_FILE}" "${LINKED_FILE}.old"
ln -s "$(pwd)/configs/config.fish" "${LINKED_FILE}"

# Symlinking dotfiles
for F in dotfiles/.*; do
  if [[ -f "$F" ]]; then
    echo "Creating symlink: $F ➔ ${LINKED_FILE}"
    LINKED_FILE="${HOME}/$( basename ${F} )"
    [[ -f "${LINKED_FILE}" ]] && mv "${LINKED_FILE}" "${LINKED_FILE}.old"
    ln -s "$(pwd)/$F" "${LINKED_FILE}"
  fi
done
