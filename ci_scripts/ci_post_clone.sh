#!/bin/bash
set -e

# 1. Navegar a la raíz del proyecto (un nivel arriba de ci_scripts)
cd "$(dirname "$0")/.."

echo "📍 Directorio actual: $(pwd)"

# 2. Verificar que estamos en el lugar correcto (donde está package.json)
if [ ! -f "package.json" ]; then
    echo "❌ Error: No se encontró package.json en $(pwd)"
    exit 1
fi

# 3. Instalar dependencias de Node
echo "Installing npm dependencies..."
npm install

# 4. Crear carpeta 'public' si no existe para evitar el error de Capacitor
if [ ! -d "public" ]; then
    mkdir public
    touch public/index.html
    echo "Created dummy public folder"
fi

# 5. Sincronizar Capacitor
echo "Syncing Capacitor..."
npx cap sync ios

echo "✅ Proceso completado con éxito"
