#!/bin/zsh

# 1. Salir si hay errores
set -e

# 2. Forzar la búsqueda de Node y NPM en las rutas estándar de Xcode Cloud
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/homebrew/bin:$PATH"

# 3. Verificar si NPM existe antes de seguir
if ! command -v npm &> /dev/null; then
    echo "❌ ERROR: npm no encontrado. Intentando usar Homebrew..."
    # A veces Node está en brew en estas máquinas
    brew install node || { echo "❌ No se pudo instalar Node"; exit 1; }
fi

echo "🚀 INICIANDO INSTALACIÓN (PATH: $PATH)"

# 4. Ir a la raíz del proyecto (3 niveles arriba desde ci_scripts)
cd "$(dirname "$0")/../../.."
echo "📍 Directorio actual: $(pwd)"

# 5. Instalaciones
echo "📦 Ejecutando npm install..."
npm install --force

echo "🔄 Ejecutando npx cap sync ios..."
npx cap sync ios

# 6. Pods (Ruta absoluta para evitar errores de navegación)
echo "📱 Instalando Pods nativos..."
cd ios/App
pod install

echo "✅ SCRIPT FINALIZADO CORRECTAMENTE"
