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

# 2. Ir a la raíz del proyecto
cd "$(dirname "$0")/../../.."

# 3. Instalación de dependencias y Build Web
echo "📦 Instalando dependencias de Node..."
npm install --force

echo "🏗️ Construyendo proyecto web..."
npm run build

# 4. Sincronizar Capacitor
echo "🔄 Sincronizando Capacitor..."
npx cap sync ios

# 5. Instalación de Pods (Aquí es donde ocurre la magia)
echo "📱 Instalando CocoaPods..."
cd ios/App
if [ -f "Podfile" ]; then
    pod install
else
    echo "⚠️ Error: No se encontró el Podfile"
    exit 1
fi

echo "--- ✅ PROCESO FINALIZADO CON ÉXITO ---"
