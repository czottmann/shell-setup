#!/usr/local/bin/bash

for CFG in \
  fish/config.fish \
  peco/config.json \
; do
  echo "Creating symlink to configs/${CFG} in ~/.config/${CFG}"
  LINKED_FILE="${HOME}/.config/${CFG}"
  DIR_NAME=$(dirname "${LINKED_FILE}")
  [[ ! -d "${DIR_NAME}" ]] && mkdir -p "${DIR_NAME}"
  [[ -f "${LINKED_FILE}" ]] && mv "${LINKED_FILE}" "${LINKED_FILE}.old"
  ln -s "$(pwd)/configs/${CFG}" "${LINKED_FILE}"
done

# Symlinking dotfiles
for F in dotfiles/.*; do
  if [[ -f "$F" ]]; then
    echo "Creating symlink: $F ➔ ${LINKED_FILE}"
    LINKED_FILE="${HOME}/$( basename ${F} )"
    [[ -f "${LINKED_FILE}" ]] && mv "${LINKED_FILE}" "${LINKED_FILE}.old"
    ln -s "$(pwd)/$F" "${LINKED_FILE}"
  fi
done
