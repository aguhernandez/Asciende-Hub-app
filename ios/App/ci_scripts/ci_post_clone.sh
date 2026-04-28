#!/bin/zsh

# 1. Configurar el entorno
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/homebrew/bin:$PATH"
echo "🚀 INICIANDO MODO RECOVERY (COCOAPODS)"

# 2. Ir a la raíz del proyecto
cd ../../..

# 3. Instalación de Node (Esto crea la carpeta node_modules)
echo "📦 Instalando dependencias de Node..."
npm install --force

# 4. Sincronizar Capacitor (Esto inyecta los plugins en el Podfile)
echo "🔄 Sincronizando Capacitor..."
npx cap sync ios

# 5. Instalar los Pods nativos
echo "📱 Instalando Pods..."
cd ios/App
pod install

echo "✅ PROCESO COMPLETADO CON ÉXITO"
