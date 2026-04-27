#!/bin/bash
set -e

# 1. Encontrar la raíz del proyecto dinámicamente
# Buscamos hacia atrás hasta encontrar el package.json
until [ -f package.json ] || [ "$PWD" = "/" ]; do
    cd ..
done

echo "📍 Raíz detectada en: $(pwd)"

# 2. Instalar dependencias usando la ruta completa de npm
# Xcode Cloud a veces requiere que usemos comandos de entorno
export PATH=$PATH:/usr/local/bin

echo "📦 Instalando dependencias de Node..."
npm install

echo "🔄 Sincronizando Capacitor..."
npx cap sync ios

# 3. Ir a la carpeta de iOS e instalar Pods
cd ios/App
echo "CP Instalando CocoaPods..."
pod install

echo "✅ Todo listo para compilar"
