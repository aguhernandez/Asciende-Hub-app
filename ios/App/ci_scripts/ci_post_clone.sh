#!/bin/zsh

# 1. Rutas
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/homebrew/bin:$PATH"

echo "🚀 SCRIPT DETECTADO EN IOS/APP/CI_SCRIPTS"

# 2. Subir 3 niveles para llegar a la raíz donde está package.json
cd ../../..
echo "📍 Raíz del proyecto: $(pwd)"

# 3. Instalación
npm install
npx cap sync ios

# 4. Volver a bajar para los Pods
cd ios/App
pod install --repo-update

echo "✅ FIN DEL SCRIPT"