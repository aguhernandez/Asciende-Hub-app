#!/bin/zsh

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/homebrew/bin:$PATH"

# 1. Ir a la raíz
cd ../../..

# 2. Crear archivos Package.swift mínimos pero VÁLIDOS
# Esto evita el error de "is empty"
PACKAGE_CONTENT='// swift-tools-version: 5.9
import PackageDescription
let package = Package(name: "Temp", products: [], targets: [])'

mkdir -p node_modules/@capacitor/camera
echo "$PACKAGE_CONTENT" > node_modules/@capacitor/camera/Package.swift

mkdir -p node_modules/@capacitor/geolocation
echo "$PACKAGE_CONTENT" > node_modules/@capacitor/geolocation/Package.swift

mkdir -p node_modules/@capacitor/push-notifications
echo "$PACKAGE_CONTENT" > node_modules/@capacitor/push-notifications/Package.swift

# 3. Instalación de emergencia de Node
echo "📦 Ejecutando npm install..."
npm install --force

# 4. Sincronizar y forzar la resolución nosotros mismos
npx cap sync ios

echo "✅ SCRIPT FINALIZADO"
