#!/bin/zsh

# 1. Salir si hay error
set -e

echo "🚀 CI_POST_CLONE: Localizando Node nativo..."

# 2. Forzar las rutas exactas de Xcode Cloud donde vive Node
# Apple suele tenerlo en /usr/local/bin o lo gestiona vía nvm
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/homebrew/bin:$PATH"

# 3. TRUCO FINAL: Si npm no se ve, intentamos cargarlo desde el directorio de nvm de Apple
if ! command -v npm &> /dev/null; then
    echo "🔍 Node no está en el PATH básico, cargando NVM de Apple..."
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    
    # Si después de intentar cargar NVM sigue sin funcionar, usamos la ruta directa
    nvm use --lts || echo "⚠️ NVM no encontró versión, siguiendo..."
fi

# 4. Verificar si ahora sí lo vemos
echo "✅ Node: $(node -v 2>/dev/null || echo 'No encontrado')"
echo "✅ NPM: $(npm -v 2>/dev/null || echo 'No encontrado')"

# 5. Ir a la raíz (3 niveles arriba)
cd "$(dirname "$0")/../../.."

# 6. INSTALACIÓN
echo "📦 Instalando Node Modules..."
npm install --force

echo "🔄 Sincronizando Capacitor..."
npx cap sync ios

# 7. PODS
echo "📱 Instalando Pods..."
cd ios/App
pod install

echo "--- ✅ SCRIPT TERMINADO ---"
