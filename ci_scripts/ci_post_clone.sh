#!/bin/zsh

# 1. Asegurar el PATH para encontrar Node y Homebrew
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/homebrew/bin:$PATH"

echo "🚀 INICIANDO REPARACIÓN DE CAPACITOR"

# 2. Ir a la raíz del proyecto
cd ../../..
echo "📍 Raíz: $(pwd)"

# 3. Limpieza profunda (Eliminar lo que pueda estar corrupto)
echo "🧹 Limpiando carpetas viejas..."
rm -rf node_modules package-lock.json ios/App/Pods ios/App/Podfile.lock

# 4. Instalación de Node si falta (Paso de seguridad)
if ! command -v npm &> /dev/null; then
    echo "⚠️ Instalando Node vía Brew..."
    brew install node
fi

# 5. Reinstalación total
echo "📦 Instalando dependencias de Node..."
npm install

echo "🔄 Sincronizando Capacitor (Generando archivos de iOS)..."
npx cap sync ios

# 6. Forzar actualización de CocoaPods
echo "⾒ Instalando Pods..."
cd ios/App
pod install --repo-update

echo "✅ PROCESO FINALIZADO"# Force Build Mon Apr 27 18:48:06 EAT 2026
# Build forzado el Mon Apr 27 18:59:14 EAT 2026
