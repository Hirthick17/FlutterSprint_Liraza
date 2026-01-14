# Building Android APK - Complete Guide

## Prerequisites

### 1. Install Android Studio
Download from: https://developer.android.com/studio

### 2. Install Android SDK
1. Open Android Studio
2. Go to: Tools → SDK Manager
3. Install:
   - Android SDK Platform (API 33 or higher)
   - Android SDK Build-Tools
   - Android SDK Command-line Tools
   - Android SDK Platform-Tools

### 3. Set Environment Variables

**Windows:**
```powershell
# Add to System Environment Variables
ANDROID_HOME = C:\Users\YOUR_USERNAME\AppData\Local\Android\Sdk

# Add to Path:
%ANDROID_HOME%\platform-tools
%ANDROID_HOME%\tools
%ANDROID_HOME%\tools\bin
```

**Mac/Linux:**
```bash
# Add to ~/.bashrc or ~/.zshrc
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
```

### 4. Verify Installation
```bash
flutter doctor
```

Should show:
```
[✓] Android toolchain - develop for Android devices
```

---

## Building the APK

### Step 1: Clean Build
```bash
flutter clean
flutter pub get
```

### Step 2: Build Release APK
```bash
flutter build apk --release
```

### Step 3: Locate APK
The APK will be at:
```
build/app/outputs/flutter-apk/app-release.apk
```

### Optional: Build Split APKs (smaller size)
```bash
flutter build apk --split-per-abi --release
```

This creates 3 APKs:
- `app-armeabi-v7a-release.apk` (32-bit ARM)
- `app-arm64-v8a-release.apk` (64-bit ARM)
- `app-x86_64-release.apk` (64-bit x86)

---

## Troubleshooting

### Error: "No Android SDK found"
**Solution:**
1. Install Android Studio
2. Set ANDROID_HOME environment variable
3. Restart terminal/IDE
4. Run `flutter doctor`

### Error: "Gradle build failed"
**Solution:**
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter build apk --release
```

### Error: "SDK location not found"
**Solution:**
Create `android/local.properties`:
```
sdk.dir=C:\\Users\\YOUR_USERNAME\\AppData\\Local\\Android\\Sdk
```

### Error: "License not accepted"
**Solution:**
```bash
flutter doctor --android-licenses
```
Accept all licenses.

---

## App Signing (Optional)

For production releases, you should sign your APK.

### 1. Create Keystore
```bash
keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

### 2. Configure Signing
Create `android/key.properties`:
```
storePassword=YOUR_PASSWORD
keyPassword=YOUR_PASSWORD
keyAlias=upload
storeFile=C:/path/to/upload-keystore.jks
```

### 3. Update `android/app/build.gradle`
```gradle
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

android {
    signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
            storePassword keystoreProperties['storePassword']
        }
    }
    buildTypes {
        release {
            signingConfig signingConfigs.release
        }
    }
}
```

### 4. Build Signed APK
```bash
flutter build apk --release
```

---

## Uploading to GitHub Releases

### 1. Create Release on GitHub
- Go to your repository
- Click "Releases" → "Create a new release"
- Tag: `v1.0.0`
- Title: `LIRAZA v1.0.0 - Initial Release`

### 2. Upload APK
- Drag and drop `app-release.apk`
- Add release notes

### 3. Publish Release
- Click "Publish release"

### 4. Get Download Link
```
https://github.com/YOUR_USERNAME/liraza-app/releases/latest/download/app-release.apk
```

Update this link in `docs/index.html`

---

## Testing the APK

### On Emulator
```bash
flutter build apk --release
flutter install
```

### On Physical Device
1. Enable Developer Options on your Android device
2. Enable USB Debugging
3. Connect device via USB
4. Run:
```bash
flutter build apk --release
flutter install
```

Or manually:
1. Copy APK to device
2. Open file manager
3. Tap APK file
4. Install

---

## Quick Commands Reference

```bash
# Clean build
flutter clean && flutter pub get

# Build release APK
flutter build apk --release

# Build app bundle (for Play Store)
flutter build appbundle --release

# Build split APKs
flutter build apk --split-per-abi --release

# Check Flutter setup
flutter doctor -v

# List connected devices
flutter devices

# Install on connected device
flutter install
```

---

## Next Steps

1. ✅ Build APK successfully
2. ✅ Test on device/emulator
3. ✅ Upload to GitHub Releases
4. ✅ Update landing page download link
5. ✅ Share with users!

---

## Resources

- [Flutter Build Modes](https://docs.flutter.dev/testing/build-modes)
- [Android App Signing](https://developer.android.com/studio/publish/app-signing)
- [Flutter Deployment](https://docs.flutter.dev/deployment/android)
