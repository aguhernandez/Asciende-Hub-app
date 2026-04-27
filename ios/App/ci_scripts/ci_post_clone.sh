#!/bin/bash
set -e

# 1. Navegar a la raíz del proyecto (donde está package.json)
# Desde ios/App/ci_scripts/ bajamos 3 niveles
cd ../../..

echo "📍 Estamos en: $(pwd)"

# 2. Instalar todo
npm install
npx cap sync ios

# 3. Instalar los Pods (Esto arregla el error de 'import Capacitor')
cd ios/App
pod install

echo "✅ Todo instalado"
