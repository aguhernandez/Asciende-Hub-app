#!/zsh
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/homebrew/bin:$PATH"
echo "🚀 INICIANDO CI_POST_CLONE"
cd ../../..
npm install
npx cap sync ios
cd ios/App && pod install
echo "✅ SCRIPT FINALIZADO"
# Nuevo inicio
