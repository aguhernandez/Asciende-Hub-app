#!/bin/bash
set -e

# 1. Creamos carpetas vacías para que Xcode no se queje al principio
mkdir -p node_modules/@capacitor/camera
mkdir -p node_modules/@capacitor/geolocation
mkdir -p node_modules/@capacitor/push-notifications

# 2. Instalamos lo que realmente hace falta
brew install cocoapods
npm install
npx cap sync ios
