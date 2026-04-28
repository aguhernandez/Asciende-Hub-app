#!/bin/zsh

set -e

echo "🚀 CI_POST_CLONE: Detectando arquitectura y descargando Node..."

# 1. Detectar arquitectura
ARCH=$(uname -m)
NODE_VER="v20.11.1"

if [ "$ARCH" = "arm64" ]; then
    NODE_PLATFORM="darwin-arm64"
else
    NODE_PLATFORM="darwin-x64"
fi

echo "Architecture detected: $ARCH. Downloading $NODE_PLATFORM..."

# 2. Descargar y extraer
curl -OL "https://nodejs.org/dist/$NODE_VER/node-$NODE_VER-$NODE_PLATFORM.tar.gz"
tar -xzf "node-$NODE_VER-$NODE_PLATFORM.tar.gz"

# 3. Configurar PATH
export PATH="$(pwd)/node-$NODE_VER-$NODE_PLATFORM/bin:$PATH"

echo "✅ Node activado: $(node -v)"
echo "✅ NPM activado: $(npm -v)"

# 4. Ir a la raíz del proyecto
cd "$(dirname "$0")/../../.."

# 5. Instalación de Capacitor
echo "📦 Instalando dependencias de Node..."
npm install --force

echo "🔄 Sincronizando Capacitor..."
npx cap sync ios

# 6. Pods
echo "📱 Instalando Pods..."
cd ios/App
pod install

echo "--- ✅ SCRIPT COMPLETADO CON ÉXITO ---"
