#!/bin/zsh

set -e

echo "🚀 CI_POST_CLONE: Iniciando..."

# 1. Preparar Node v22
ARCH=$(uname -m)
NODE_VER="v22.13.1"
NODE_PLATFORM=$([ "$ARCH" = "arm64" ] && echo "darwin-arm64" || echo "darwin-x64")

curl -OL "https://nodejs.org/dist/$NODE_VER/node-$NODE_VER-$NODE_PLATFORM.tar.gz"
tar -xzf "node-$NODE_VER-$NODE_PLATFORM.tar.gz"
export PATH="$(pwd)/node-$NODE_VER-$NODE_PLATFORM/bin:$PATH"

# 2. Ir a la raíz
cd "$(dirname "$0")/../../.."

# 3. Instalación y Build Web
echo "📦 Instalando dependencias..."
npm install --force

echo "🏗️ Ejecutando Build Web..."
npm run build

# 4. Sincronizar Capacitor
echo "🔄 Sincronizando Capacitor..."
npx cap sync ios

# 5. Instalación de Pods (Solo si el archivo existe)
echo "📱 Verificando CocoaPods..."
cd ios/App
if [ -f "Podfile" ]; then
    echo "📄 Podfile encontrado. Ejecutando pod install..."
    pod install
else
    echo "ℹ️ No se encontró Podfile. Capacitor está usando Swift Package Manager. Saltando..."
fi

echo "--- ✅ PROCESO FINALIZADO CON ÉXITO ---"
