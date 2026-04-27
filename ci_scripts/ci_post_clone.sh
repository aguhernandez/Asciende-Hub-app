#!/bin/bash
set -e

# 1. Asegurarnos de estar en la raíz del repositorio
# (Xcode Cloud a veces inicia en subcarpetas)
cd "$(dirname "$0")/.." 2>/dev/null || cd ..

echo "📍 Estamos en: $(pwd)"

# 2. Instalar dependencias de Node
echo "Installing npm dependencies..."
npm install

# 3. Crear una carpeta 'public' vacía si no existe
# (Esto evita el error de "public couldn't be opened")
if [ ! -d "public" ]; then
  mkdir public
  echo "index.html" > public/index.html
fi

# 4. Sincronizar Capacitor
echo "Syncing Capacitor..."
npx cap sync ios

echo "✅ Script finalizado con éxito"
exit 0
