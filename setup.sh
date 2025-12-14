#!/bin/bash

# =====================================================
# Yi Jing Oracle - Script de Configuration Native Apps
# =====================================================

echo "╔══════════════════════════════════════════════════╗"
echo "║   Yi Jing Oracle - Configuration des Apps        ║"
echo "╚══════════════════════════════════════════════════╝"
echo ""

# Vérifier Node.js
if ! command -v node &> /dev/null; then
    echo "❌ Node.js n'est pas installé"
    echo "   Installez Node.js 18+ depuis https://nodejs.org"
    exit 1
fi

NODE_VERSION=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
if [ "$NODE_VERSION" -lt 18 ]; then
    echo "❌ Node.js $NODE_VERSION détecté, version 18+ requise"
    exit 1
fi

echo "✅ Node.js $(node -v) détecté"

# Créer le dossier www
echo ""
echo "📁 Création de la structure..."
mkdir -p www/icons

# Copier les fichiers
cp index.html www/
cp manifest.json www/
cp sw.js www/
cp -r icons/* www/icons/

echo "✅ Fichiers copiés dans www/"

# Installer les dépendances
echo ""
echo "📦 Installation des dépendances..."
npm install

echo ""
echo "╔══════════════════════════════════════════════════╗"
echo "║   Configuration terminée !                       ║"
echo "╚══════════════════════════════════════════════════╝"
echo ""
echo "Prochaines étapes :"
echo ""
echo "  📱 Pour Android :"
echo "     npm install @capacitor/android"
echo "     npx cap add android"
echo "     npx cap open android"
echo ""
echo "  🍎 Pour iOS (Mac uniquement) :"
echo "     npm install @capacitor/ios"
echo "     npx cap add ios"
echo "     npx cap open ios"
echo ""
echo "  🔄 Après modifications :"
echo "     npx cap sync"
echo ""
