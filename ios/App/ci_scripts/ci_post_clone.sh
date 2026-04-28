#!/bin/zsh

# 1. Path y Echo inicial
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/homebrew/bin:$PATH"
echo "🚀 INICIO DE SCRIPT EN: $(pwd)"

# 2. Navegar a la raíz con seguridad
# Intentamos subir 3 niveles (ios/App/ci_scripts -> ios/App -> ios -> raiz)
cd ../../..

# 3. VALIDACIÓN CRUCIAL: ¿Estamos en la raíz?
if [ ! -f "package.json" ]; then
    echo "❌ ERROR: No se encontró package.json en $(pwd). El script falló al navegar."
    exit 1
fi

echo "✅ Estamos en la raíz. Iniciando instalaciones..."

# 4. Instalaciones (Añadimos --ci para que sea más rápido y limpio)
npm install
npx cap sync ios

# 5. Pods
cd ios/App
pod install

echo "✅ SCRIPT COMPLETADO CON ÉXITO"
