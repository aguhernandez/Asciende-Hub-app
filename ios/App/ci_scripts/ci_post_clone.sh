#!/bin/zsh

set -e

echo "🚀 CI_POST_CLONE: Preparando entorno V22"

# 1. Detectar arquitectura y bajar Node
ARCH=$(uname -m)
NODE_VER="v22.13.1"
NODE_PLATFORM=$([ "$ARCH" = "arm64" ] && echo "darwin-arm64" || echo "darwin-x64")

curl -OL "https://nodejs.org/dist/$NODE_VER/node-$NODE_VER-$NODE_PLATFORM.tar.gz"
tar -xzf "node-$NODE_VER-$NODE_PLATFORM.tar.gz"
export PATH="$(pwd)/node-$NODE_VER-$NODE_PLATFORM/bin:$PATH"

echo "✅ Node: $(node -v)"

# 2. Ir a la raíz
cd "$(dirname "$0")/../../.."

# 3. Instalación de dependencias
echo "📦 Instalando dependencias de Node..."
npm install --force

# 4. CONSTRUIR EL PROYECTO WEB (Paso vital)
# Esto crea la carpeta /dist que Capacitor está pidiendo
echo "🏗️ Construyendo proyecto web..."
npm run build

# 5. Sincronizar Capacitor
echo "🔄 Sincronizando Capacitor..."
npx cap sync ios

# 6. Instalar Pods nativos
echo "📱 Instalando Pods..."
cd ios/App
pod install

echo "--- ✅ TODO LISTO PARA COMPILAR ---"
