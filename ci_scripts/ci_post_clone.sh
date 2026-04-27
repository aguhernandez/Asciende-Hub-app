#!/bin/bash
set -e

# IMPORTANTE: Moverse a la raíz del proyecto (Asciende_HUB_V1.0)
cd ..

echo "📍 Estamos en: $(pwd)"

# Crear carpeta 'public' vacía para que Capacitor no se queje
mkdir -p public
touch public/index.html

# Instalar dependencias
npm install

# Sincronizar
npx cap sync ios

echo "✅ Listo"
