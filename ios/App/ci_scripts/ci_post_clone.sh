#!/bin/zsh

# 1. Cargar el PATH de las herramientas comunes de macOS y Homebrew
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

# 2. Intentar cargar Node si está instalado vía Homebrew (común en Xcode Cloud)
if [ -d "/usr/local/opt/node/bin" ]; then
    export PATH="/usr/local/opt/node/bin:$PATH"
fi

echo "🚀 SCRIPT INICIADO"
echo "📍 Ubicación: $(pwd)"

# 3. Ir a la raíz (donde está package.json)
cd ../../..
echo "📍 Raíz: $(pwd)"

# 4. Instalar dependencias (Usamos la ruta completa para estar seguros)
echo "📦 Instalando dependencias..."
npm install

# 5. Sincronizar Capacitor
echo "🔄 Sincronizando..."
npx cap sync ios

# 6. Instalar Pods (Entrando a la carpeta correcta)
echo "⾒ Instalando Pods..."
cd ios/App
pod install

echo "✅ PROCESO COMPLETADO"