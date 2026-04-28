#!/bin/zsh

# 1. Definir rutas
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/homebrew/bin:$PATH"
echo "🚀 INICIO TOTAL DEL SCRIPT CUSTOM"

# 2. Ir a la raíz y asegurar que estamos donde está el package.json
cd ../../..
echo "📍 Directorio raíz: $(pwd)"

# 3. Limpieza profunda (para evitar conflictos de versiones)
rm -rf node_modules package-lock.json ios/App/Pods ios/App/Podfile.lock

# 4. Instalación limpia con permisos de administrador de node
echo "📦 Instalando dependencias de Node..."
npm install --force

# 5. Sincronizar Capacitor
echo "🔄 Sincronizando Capacitor..."
npx cap sync ios

# 6. Instalar Pods con actualización de repositorio
echo "⾒ Instalando Pods en ios/App..."
cd ios/App
pod install --repo-update

echo "✅ SCRIPT FINALIZADO - TODO LISTO PARA XCODE"
