# Yi Jing Oracle - Applications Mobiles Natives

Ce guide explique comment transformer l'application PWA en applications natives Android (APK) et iOS (IPA) en utilisant **Capacitor**.

## Option 1 : PWA (Recommandé - Le plus simple)

La PWA fonctionne directement depuis le navigateur et peut être "installée" sur l'écran d'accueil.

### Installation PWA

**Android :**
1. Ouvrir l'application dans Chrome
2. Appuyer sur le menu ⋮ (3 points)
3. Sélectionner "Ajouter à l'écran d'accueil"

**iPhone/iPad :**
1. Ouvrir l'application dans Safari
2. Appuyer sur le bouton Partager ⬆️
3. Sélectionner "Sur l'écran d'accueil"

### Avantages PWA
- ✅ Aucun compte développeur requis
- ✅ Mises à jour automatiques
- ✅ Fonctionne hors-ligne
- ✅ Installation instantanée
- ✅ Taille réduite

---

## Option 2 : Application Native avec Capacitor

Pour créer de vraies applications APK/IPA distribuables.

### Prérequis

```bash
# Node.js 18+ requis
node --version

# Installation globale de Capacitor CLI
npm install -g @capacitor/cli

# Pour Android : Android Studio + SDK
# Pour iOS : Xcode (Mac uniquement) + CocoaPods
```

### Étape 1 : Initialiser le projet

```bash
# Créer un nouveau dossier projet
mkdir yijing-app && cd yijing-app

# Initialiser npm
npm init -y

# Installer Capacitor
npm install @capacitor/core @capacitor/cli

# Initialiser Capacitor
npx cap init "Yi Jing Oracle" "fr.cybermind.yijing" --web-dir=www

# Créer le dossier www et copier les fichiers
mkdir www
cp /chemin/vers/index.html www/
cp /chemin/vers/manifest.json www/
cp /chemin/vers/sw.js www/
cp -r /chemin/vers/icons www/
```

### Étape 2 : Ajouter les plateformes

```bash
# Android
npm install @capacitor/android
npx cap add android

# iOS (Mac uniquement)
npm install @capacitor/ios
npx cap add ios
```

### Étape 3 : Configurer capacitor.config.ts

```typescript
import { CapacitorConfig } from '@capacitor/cli';

const config: CapacitorConfig = {
  appId: 'fr.cybermind.yijing',
  appName: 'Yi Jing Oracle',
  webDir: 'www',
  server: {
    androidScheme: 'https'
  },
  plugins: {
    SplashScreen: {
      launchShowDuration: 2000,
      backgroundColor: '#8B4513',
      showSpinner: false
    }
  }
};

export default config;
```

### Étape 4 : Synchroniser et compiler

```bash
# Synchroniser les fichiers web
npx cap sync

# Ouvrir Android Studio
npx cap open android

# Ou ouvrir Xcode (Mac)
npx cap open ios
```

### Étape 5 : Générer l'APK (Android)

Dans Android Studio :
1. Build → Generate Signed Bundle / APK
2. Sélectionner APK
3. Créer ou utiliser un keystore existant
4. Sélectionner "release"
5. L'APK sera dans `android/app/release/`

### Étape 6 : Générer l'IPA (iOS)

Dans Xcode :
1. Product → Archive
2. Distribute App → Ad Hoc ou App Store
3. Suivre les instructions de signature

---

## Structure du Projet Capacitor

```
yijing-app/
├── www/                      # Fichiers web (copiés depuis PWA)
│   ├── index.html
│   ├── manifest.json
│   ├── sw.js
│   └── icons/
├── android/                  # Projet Android Studio
│   ├── app/
│   │   ├── src/main/
│   │   │   ├── AndroidManifest.xml
│   │   │   └── res/
│   │   │       ├── mipmap-hdpi/
│   │   │       ├── mipmap-mdpi/
│   │   │       ├── mipmap-xhdpi/
│   │   │       ├── mipmap-xxhdpi/
│   │   │       └── mipmap-xxxhdpi/
│   │   └── build.gradle
│   └── build.gradle
├── ios/                      # Projet Xcode
│   └── App/
│       ├── App/
│       │   ├── Info.plist
│       │   └── Assets.xcassets/
│       └── App.xcodeproj
├── capacitor.config.ts
├── package.json
└── node_modules/
```

---

## Icônes pour les App Stores

### Android (res/mipmap-*)

| Dossier | Taille |
|---------|--------|
| mipmap-mdpi | 48x48 |
| mipmap-hdpi | 72x72 |
| mipmap-xhdpi | 96x96 |
| mipmap-xxhdpi | 144x144 |
| mipmap-xxxhdpi | 192x192 |

### iOS (Assets.xcassets)

| Usage | Taille |
|-------|--------|
| iPhone Notification | 40x40 |
| iPhone Settings | 58x58, 87x87 |
| iPhone Spotlight | 80x80, 120x120 |
| iPhone App | 120x120, 180x180 |
| iPad App | 152x152, 167x167 |
| App Store | 1024x1024 |

### Script de génération automatique

```bash
# Générer toutes les tailles depuis icon-512.png
npx capacitor-assets generate --iconBackgroundColor '#8B4513'
```

---

## Configuration Android (AndroidManifest.xml)

```xml
<manifest>
    <application
        android:allowBackup="true"
        android:icon="@mipmap/ic_launcher"
        android:label="Yi Jing Oracle"
        android:roundIcon="@mipmap/ic_launcher_round"
        android:theme="@style/AppTheme">
        
        <!-- Permissions -->
        <uses-permission android:name="android.permission.INTERNET" />
        
        <activity
            android:name=".MainActivity"
            android:screenOrientation="portrait"
            android:exported="true">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
    </application>
</manifest>
```

---

## Configuration iOS (Info.plist)

```xml
<key>CFBundleDisplayName</key>
<string>Yi Jing Oracle</string>

<key>CFBundleName</key>
<string>Yi Jing</string>

<key>UIStatusBarStyle</key>
<string>UIStatusBarStyleLightContent</string>

<key>UIViewControllerBasedStatusBarAppearance</key>
<false/>

<key>UISupportedInterfaceOrientations</key>
<array>
    <string>UIInterfaceOrientationPortrait</string>
</array>
```

---

## Publication

### Google Play Store

1. Créer un compte développeur (25$ une fois)
2. Créer une fiche application
3. Uploader l'APK signé ou Android App Bundle
4. Remplir les informations (description, screenshots)
5. Soumettre pour examen

### Apple App Store

1. Créer un compte Apple Developer (99$/an)
2. Créer un App ID dans le Developer Portal
3. Créer une fiche dans App Store Connect
4. Uploader l'IPA via Xcode ou Transporter
5. Soumettre pour examen

---

## Commandes Utiles

```bash
# Vérifier la configuration
npx cap doctor

# Synchroniser après modifications web
npx cap sync

# Copier uniquement les fichiers web
npx cap copy

# Mettre à jour Capacitor
npm update @capacitor/core @capacitor/cli @capacitor/android @capacitor/ios

# Lancer sur émulateur Android
npx cap run android

# Lancer sur simulateur iOS
npx cap run ios
```

---

## Dépannage

### "SDK location not found" (Android)
Créer `local.properties` dans `android/` :
```
sdk.dir=/Users/VOTRE_NOM/Library/Android/sdk
```

### Icônes floues sur Android
Utiliser des icônes vectorielles (SVG) ou régénérer en haute résolution.

### Écran blanc au démarrage
Vérifier que `www/index.html` existe et que `webDir` est correct dans `capacitor.config.ts`.

---

## Crédits

- **Yi Jing Oracle** - Application de divination
- **Grilles La Livrée d'Hermès** - Anibal Edelbert Amiot
- **Framework** - Capacitor by Ionic
