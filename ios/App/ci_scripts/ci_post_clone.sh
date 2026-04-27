#!/bin/zsh

# 1. Configurar rutas de comando
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/homebrew/bin:$PATH"

echo "🚀 Iniciando configuración de entorno..."

# 2. Verificar si Node existe, si no, instalarlo vía Homebrew
if ! command -v npm &> /dev/null; then
    echo "⚠️ NPM no encontrado. Intentando instalar Node..."
    brew install node
else
    echo "✅ Node/NPM detectado"
fi

# 3. Ir a la raíz del proyecto
cd ../../..
echo "📍 Directorio raíz: $(pwd)"

# 4. Instalar dependencias de Node
echo "📦 Instalando dependencias del proyecto..."
npm install

# 5. Sincronizar Capacitor (Crea la carpeta de Pods y plugins)
echo "🔄 Sincronizando Capacitor..."
npx cap sync ios

# 6. Instalar Pods (Lo que Xcode necesita para 'import Capacitor')
echo "⾒ Instalando CocoaPods..."
cd ios/App
pod install

echo "✅ Script finalizado con éxito"