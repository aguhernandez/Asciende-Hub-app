#!/bin/zsh

echo "🛠️ Pre-build: Forzando esquema y vinculación de Workspace..."

# Este comando le dice a Xcode Cloud que el proyecto NO es independiente,
# sino que depende del Workspace de CocoaPods.
xcodebuild -list -workspace ../App.xcworkspace