#!/bin/bash
set -e

# 1. Instalar dependencias de Node (esto crea node_modules)
npm install

# 2. Instalar CocoaPods y sincronizar Capacitor
brew install cocoapods
npx cap sync ios

echo "Capacitor sync completed successfully!"
