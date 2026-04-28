#!/bin/zsh

set -e

echo "🚀 CI_POST_CLONE: Instalación manual de Node Portátil"

# 1. Descargar Node binario (versión LTS 20) directamente
# Usamos el binario de macOS ARM64 porque Xcode Cloud corre en Apple Silicon
NODE_VER="v20.11.1"
NODE_PLATFORM="darwin-arm64"
curl -OL "https://nodejs.org/dist/$NODE_VER/node-$NODE_VER-$NODE_PLATFORM.tar.gz"

# 2. Descomprimirlo
tar -xzf "node-$NODE_VER-$NODE_PLATFORM.tar.gz"

# 3. Configurar el PATH para usar este Node
export PATH="$(pwd)/node-$NODE_VER-$NODE_PLATFORM/bin:$PATH"

echo "✅ Node activado: $(node -v)"
echo "✅ NPM activado: $(npm -v)"

# 4. Ir a la raíz del proyecto
cd ../../..

# 5. Instalación normal de Capacitor
echo "📦 Instalando dependencias de Node..."
npm install --force

echo "🔄 Sincronizando Capacitor..."
npx cap sync ios

# 6. Pods
echo "📱 Instalando Pods..."
cd ios/App
pod install

echo "--- ✅ SCRIPT COMPLETADO CON ÉXITO ---"
