#!/bin/zsh
echo "🚀 SCRIPT DESDE IOS/CI_SCRIPTS"
cd ..
npm install
npx cap sync ios
cd ios/App && pod install
