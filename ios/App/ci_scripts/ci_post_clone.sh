#!/bin/zsh
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/homebrew/bin:$PATH"
echo "🚀 SCRIPT INICIADO CORRECTAMENTE"
cd ../../..
npm install
npx cap sync ios
cd ios/App && pod install
echo "✅ TODO INSTALADO"
