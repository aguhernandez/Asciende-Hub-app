#!/bin/bash
set -e

# Crear carpeta public por si Git no la subió bien
mkdir -p public
touch public/index.html

npm install
npx cap sync ios

# Forzar copia a la carpeta interna de la App por si Xcode se pierde
cp capacitor.config.json ios/App/App/ 2>/dev/null || true
cp config.xml ios/App/App/ 2>/dev/null || true
cp -R public/ ios/App/App/ 2>/dev/null || true

echo "✅ Listo"
