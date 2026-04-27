#!/bin/bash

# 1. Instalar CocoaPods
brew install cocoapods

# 2. Ir a la raíz del proyecto para instalar dependencias de Node
cd ../../
npm install

# 3. Sincronizar Capacitor para que genere el .xcworkspace
npx cap sync ios

# 4. Volver a la carpeta de scripts para que Xcode Cloud continúe
cd ios/App/ci_scripts
