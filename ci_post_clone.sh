#!/bin/bash
set -e

echo "🚀 Iniciando configuración en la raíz..."

# 1. Crear carpetas que Xcode busca desesperadamente
mkdir -p public
touch public/index.html
mkdir -p node_modules/@capacitor/camera
mkdir -p node_modules/@capacitor/geolocation
mkdir -p node_modules/@capacitor/push-notifications

# 2. Instalar todo
npm install
npx cap sync ios

echo "✅ Entorno preparado."

