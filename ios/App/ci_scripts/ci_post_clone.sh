#!/bin/zsh

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/homebrew/bin:$PATH"
echo "🚀 INICIO DE REPARACIÓN DE DEPENDENCIAS"

# 1. Ir a la raíz
cd ../../..

# 2. Crear carpetas base para que SPM no de error de "not found"
mkdir -p node_modules/@capacitor/camera
mkdir -p node_modules/@capacitor/geolocation
mkdir -p node_modules/@capacitor/push-notifications

# 3. Instalación de Node
echo "📦 Instalando Node Modules..."
npm install --force

# 4. Sincronizar Capacitor y REGENERAR archivos de ayuda
echo "🔄 Sincronizando Capacitor..."
npx cap sync ios

# 5. Forzar a Xcode a reconocer los paquetes recién instalados
echo "🛠 Forzando resolución de paquetes..."
xcodebuild -resolvePackageDependencies -project ios/App/App.xcodeproj -scheme App

# 6. Pods
cd ios/App
pod install

echo "✅ PROCESO COMPLETADO"
