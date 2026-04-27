#!/bin/zsh
set -e

# Subir a la raíz
cd ../../..

# Configurar el PATH
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

echo "🚀 Iniciando instalación de dependencias..."

# 1. Instalar dependencias de Node
npm install

# 2. Sincronizar Capacitor
npx cap sync ios

# 3. Instalar Pods
cd ios/App
pod install

echo "✅ Script terminado con éxito"
