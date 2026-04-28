#!/bin/zsh
set -e
echo "🚀 CI_POST_CLONE: Iniciando..."
ARCH=$(uname -m)
NODE_VER="v22.13.1"
NODE_PLATFORM=$([ "$ARCH" = "arm64" ] && echo "darwin-arm64" || echo "darwin-x64")
curl -OL "https://nodejs.org/dist/$NODE_VER/node-$NODE_VER-$NODE_PLATFORM.tar.gz"
tar -xzf "node-$NODE_VER-$NODE_PLATFORM.tar.gz"
export PATH="$(pwd)/node-$NODE_VER-$NODE_PLATFORM/bin:$PATH"
cd "$(dirname "$0")/../../.."
echo "📦 Instalando dependencias..."
npm install --force
echo "🏗️ Build Web..."
npm run build
echo "🔄 Sync Capacitor..."
npx cap sync ios
echo "📱 Instalando Pods..."
cd ios/App
pod install
echo "--- ✅ ÉXITO ---"
