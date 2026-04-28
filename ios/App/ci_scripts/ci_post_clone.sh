#!/bin/zsh

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/homebrew/bin:$PATH"
echo "🚀 CI_POST_CLONE: Forzando presencia de archivos"

# 1. Ir a la raíz
cd ../../..

# 2. Crear las rutas de los manifiestos que Xcode Cloud valida agresivamente
# Esto engaña al validador de Xcode para que crea que el paquete existe
mkdir -p node_modules/@capacitor/camera
touch node_modules/@capacitor/camera/Package.swift

mkdir -p node_modules/@capacitor/geolocation
touch node_modules/@capacitor/geolocation/Package.swift

mkdir -p node_modules/@capacitor/push-notifications
touch node_modules/@capacitor/push-notifications/Package.swift

# 3. Ahora sí, instalación real (esto sobreescribirá los archivos vacíos con los reales)
echo "📦 Instalando dependencias reales..."
npm install --force
npx cap sync ios

# 4. Instalar Pods
cd ios/App
pod install

echo "✅ PROCESO COMPLETADO"
