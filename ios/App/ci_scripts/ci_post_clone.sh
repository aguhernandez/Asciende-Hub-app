#!/bin/zsh

# Salir si algo falla
set -e

echo "📍 Buscando raíz del proyecto..."
cd ../../..

# Forzar el PATH para encontrar Node/npm en Xcode Cloud
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

echo "📍 Directorio actual: $(pwd)"

# 1. Instalar dependencias
echo "📦 Ejecutando npm install..."
npm install

# 2. Sincronizar Capacitor
echo "🔄 Sincronizando Capacitor..."
npx cap sync ios

# 3. Instalar Pods
echo "⾒ Instalando CocoaPods..."
cd ios/App
pod install

echo "✅ Script finalizado con éxito"
echo "Re-disparando Build"