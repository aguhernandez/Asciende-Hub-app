#!/bin/bash
set -e

# 1. Instalar dependencias de Node
npm install

# 2. Sincronizar Capacitor (esto reconstruye lo que borramos)
npx cap sync ios

# 3. Dar permisos si es necesario
exit 0
