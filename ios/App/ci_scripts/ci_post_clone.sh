#!/bin/zsh

# 1. Salir si hay errores
set -e

# 2. Intentar cargar Node desde las rutas donde suele esconderse en Xcode Cloud
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/homebrew/bin:$PATH"

# 3. Si npm no aparece, intentamos activarlo manualmente
if ! command -v npm &> /dev/null; then
    echo "🔍 Buscando Node en rutas alternativas..."
    # Intentar cargar NVM si existe
    [ -s "$HOME/.nvm/nvm.sh" ] && \. "$HOME/.nvm/nvm.sh"
    [ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"
fi

# 4. Verificación final. Si sigue sin estar, usamos un instalador más rápido que Brew
if ! command -v npm &> /dev/null; then
    echo "🚀 Instalando Node rápidamente..."
    curl -fsSL https://fnm.vercel.app/install | bash -s -- --install-dir "./.fnm" --skip-shell
    export PATH="$(pwd)/.fnm:$PATH"
    eval "$(./.fnm/fnm env)"
    fnm install --latest
fi

echo "✅ Node version: $(node -v)"
echo "✅ NPM version: $(npm -v)"

# 5. Ir a la raíz y trabajar
cd "$(dirname "$0")/../../.."
echo "📍 Carpeta: $(pwd)"

echo "📦 npm install..."
npm install --force

echo "🔄 cap sync..."
npx cap sync ios

echo "📱 pods..."
cd ios/App
pod install

echo "--- ✅ TODO LISTO ---"
