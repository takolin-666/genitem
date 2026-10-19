#!/bin/bash

DRIVE=""

for vol in "/" /Volumes/*/; do
  if [ -x "${vol}ollama/ollama" ]; then
    DRIVE="$vol"
    break
  fi
done

if [ -z "$DRIVE" ]; then
  echo "Recherche sur tous les volumes (peut prendre un moment)..." >&2

  for vol in "/" /Volumes/*/; do
    t=$(find "$vol" -maxdepth 6 -type f -name "ollama" -perm +111 2>/dev/null \
        | awk -F/ '$(NF-1)=="ollama"' | head -n 1)

    if [ -n "$t" ]; then
      DRIVE=$(dirname "$(dirname "$t")")
      echo "Installation trouvée : $DRIVE" >&2
      break
    fi
  done
fi

if [ -z "$DRIVE" ]; then
  echo "Non trouvé à la racine d'un volume, recherche dans ton dossier utilisateur..." >&2

  t=$(find "$HOME" -type f -name "ollama" -perm +111 2>/dev/null \
      | awk -F/ '$(NF-1)=="ollama"' | head -n 1)

  if [ -n "$t" ]; then
    cheminLong=$(dirname "$(dirname "$t")")

    if [ ${#cheminLong} -gt 60 ]; then
      COURT="/tmp/ollama-drive"
      ln -sfn "$cheminLong" "$COURT"
      DRIVE="$COURT"
      echo "Chemin trop long, lien symbolique créé : $DRIVE (vers $cheminLong)" >&2
    else
      DRIVE="$cheminLong"
    fi
  fi
fi

if [ -z "$DRIVE" ]; then
  echo "Installation introuvable, vérifie que le dossier ollama existe bien quelque part." >&2
  exit 1
fi

export OLLAMA_MODELS="$DRIVE/ollama/models"

exec "$DRIVE/ollama/ollama" serve
