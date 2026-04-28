#!/bin/zsh

# Salir inmediatamente si un comando falla
set -e

echo "🚀 CI_POST_CLONE: Iniciando configuración del entorno..."

# 1. Configuración de Node.js
ARCH=$(uname -m)
NODE_VER="v22.13.1"
NODE_PLATFORM=$([ "$ARCH" = "arm64" ] && echo "darwin-arm64" || echo "darwin-x64")

echo "downloader: Instalando Node.js $NODE_VER para $NODE_PLATFORM..."
curl -OL "https://nodejs.org/dist/$NODE_VER/node-$NODE_VER-$NODE_PLATFORM.tar.gz"
tar -xzf "node-$NODE_VER-$NODE_PLATFORM.tar.gz"
export PATH="$(pwd)/node-$NODE_VER-$NODE_PLATFORM/bin:$PATH"

# Verificar Node
node -v
npm -v

# 2. Ir a la raíz del proyecto
# ci_scripts está en ios/App/ci_scripts, así que subimos 3 niveles
cd "$(dirname "$0")/../../.."

echo "📦 Instalando dependencias de NPM..."
npm install --force

echo "🏗️ Generando Build Web..."
npm run build

echo "🔄 Sincronizando Capacitor..."
# Usamos npx para asegurar que usamos la versión del proyecto
npx cap sync ios

# 3. Instalación de CocoaPods
echo "📱 Configurando CocoaPods..."
cd ios/App

# Xcode Cloud a veces requiere que seamos específicos con el PATH de los Pods
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

# Forzar la instalación de los Pods
# Limpiamos rastro por si acaso
rm -rf Pods
rm -f Podfile.lock

echo "Installing Pods..."
pod install

echo "--- ✅ CI_POST_CLONE FINALIZADO CON ÉXITO ---"