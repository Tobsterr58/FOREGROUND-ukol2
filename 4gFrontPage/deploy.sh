#!/usr/bin/env sh

# zastaví skript pri akejkoľvek chybe
set -e

# 1. Zostavenie aplikácie (build)
npm run build

# 2. Presun do výstupného adresára
cd dist

# 3. Inicializácia nového git repozitára v dist priečinku
git init
git checkout -b main
git add -A
git commit -m 'deploy'

# 4. Nahranie na gh-pages vetvu
# Použijeme už tvoj správny odkaz na repozitár (tobsterr58)
git push -f https://github.com/tobsterr58/FOREGROUND-ukol2.git main:gh-pages

cd -