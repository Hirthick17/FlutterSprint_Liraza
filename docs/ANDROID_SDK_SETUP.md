# Android Studio SDK Installation - Step-by-Step Guide

## Step 1: Download and Install Android Studio

1. **Download Android Studio**
   - Go to: https://developer.android.com/studio
   - Click "Download Android Studio"
   - Accept terms and download

2. **Install Android Studio**
   - Run the installer
   - Choose "Standard" installation
   - Accept all default settings
   - Wait for installation to complete

---

## Step 2: Open SDK Manager

After Android Studio is installed:

1. **Open Android Studio**
2. Click on **"More Actions"** (or **"Configure"** on older versions)
3. Select **"SDK Manager"**

**Alternative path:**
- File → Settings → Appearance & Behavior → System Settings → Android SDK

---

## Step 3: Install Required SDK Packages

### SDK Platforms Tab

Check and install these:

- ✅ **Android 13.0 (Tiramisu)** - API Level 33
  - Android SDK Platform 33
  
- ✅ **Android 12.0 (S)** - API Level 31
  - Android SDK Platform 31

**Recommended:** Also install API 30, 29 for compatibility

### SDK Tools Tab

Click on **"SDK Tools"** tab and check these:

#### Essential Tools (MUST INSTALL):

1. ✅ **Android SDK Build-Tools 33.0.0** (Aor latest)
   - Required for building APKs

2. ✅ **Android SDK Command-line Tools (latest)**
   - Required for Flutter

3. ✅ **Android SDK Platform-Tools**
   - Includes ADB (Android Debug Bridge)

4. ✅ **Android Emulator**
   - For testing (optional but recommended)

5. ✅ **Android SDK Tools (Obsolete)**
   - Check "Show Package Details" at bottom right
   - May be needed for some Flutter operations

#### Optional but Recommended:

6. ⭕ **Intel x86 Emulator Accelerator (HAXM installer)**
   - For faster emulator (Intel CPUs only)

7. ⭕ **Google Play services**
   - If using Google services

---

## Step 4: Apply Changes

1. Click **"Apply"** button at bottom right
2. Accept license agreements
3. Click **"OK"** to start download
4. Wait for installation (may take 10-30 minutes)
5. Click **"Finish"** when done

---

## Step 5: Set Environment Variables

### Windows:

1. **Find SDK Location**
   - In SDK Manager, note the "Android SDK Location" at top
   - Usually: `C:\Users\YOUR_USERNAME\AppData\Local\Android\Sdk`

2. **Set ANDROID_HOME**
   - Press `Win + R`, type `sysdm.cpl`, press Enter
   - Go to "Advanced" tab → "Environment Variables"
   - Under "System variables", click "New"
   - Variable name: `ANDROID_HOME`
   - Variable value: `C:\Users\YOUR_USERNAME\AppData\Local\Android\Sdk`
   - Click OK

3. **Update Path**
   - Find "Path" in System variables
   - Click "Edit"
   - Click "New" and add these (one at a time):
     ```
     %ANDROID_HOME%\platform-tools
     %ANDROID_HOME%\tools
     %ANDROID_HOME%\tools\bin
     %ANDROID_HOME%\cmdline-tools\latest\bin
     ```
   - Click OK on all dialogs

4. **Restart Terminal/PowerShell**
   - Close all terminal windows
   - Open new PowerShell

---

## Step 6: Verify Installation

Open PowerShell and run:

```powershell
flutter doctor
```

**Expected output:**
```
[✓] Flutter (Channel stable, 3.10.x)
[✓] Android toolchain - develop for Android devices (Android SDK version 33.0.0)
[✓] Chrome - develop for the web
[✓] Android Studio (version 2023.x)
[✓] VS Code (version 1.x)
[✓] Connected device (1 available)
```

**If you see:**
```
[!] Android toolchain - develop for Android devices
    ✗ Android SDK file not found: ...\platforms\android-33\android.jar
```

**Solution:**
- Go back to SDK Manager
- Install "Android SDK Platform 33"

---

## Step 7: Accept Licenses

Run this command:

```powershell
flutter doctor --android-licenses
```

- Type `y` and press Enter for each license
- Accept all licenses

---

## Step 8: Test APK Build

Navigate to your project and try building:

```powershell
cd d:\OneDrive\Desktop\FlutterSpring\flutter_application_1
flutter clean
flutter pub get
flutter build apk --release
```

**If successful, you'll see:**
```
✓ Built build\app\outputs\flutter-apk\app-release.apk (XX.XMB)
```

---

## Quick Checklist

Use this to verify you have everything:

### SDK Platforms:
- [ ] Android 13.0 (API 33) ✅ REQUIRED
- [ ] Android 12.0 (API 31) ⭕ Recommended

### SDK Tools:
- [ ] Android SDK Build-Tools 33.0.0 ✅ REQUIRED
- [ ] Android SDK Command-line Tools ✅ REQUIRED
- [ ] Android SDK Platform-Tools ✅ REQUIRED
- [ ] Android Emulator ⭕ Recommended

### Environment:
- [ ] ANDROID_HOME variable set ✅ REQUIRED
- [ ] Path updated with SDK folders ✅ REQUIRED
- [ ] Terminal restarted ✅ REQUIRED

### Verification:
- [ ] `flutter doctor` shows Android toolchain ✓
- [ ] All licenses accepted
- [ ] APK builds successfully

---

## Common Issues & Solutions

### Issue 1: "Android SDK not found"
**Solution:**
- Verify ANDROID_HOME path is correct
- Restart terminal/PowerShell
- Run `flutter doctor -v` to see detailed error

### Issue 2: "cmdline-tools component is missing"
**Solution:**
- SDK Manager → SDK Tools tab
- Install "Android SDK Command-line Tools (latest)"

### Issue 3: "License not accepted"
**Solution:**
```powershell
flutter doctor --android-licenses
```
Accept all with `y`

### Issue 4: "Build-tools version not found"
**Solution:**
- SDK Manager → SDK Tools tab
- Check "Show Package Details"
- Install "Android SDK Build-Tools 33.0.0"

### Issue 5: "Gradle build failed"
**Solution:**
```powershell
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter build apk --release
```

---

## Minimum Requirements Summary

**Absolutely Required:**
1. Android SDK Platform 33
2. Android SDK Build-Tools 33.0.0
3. Android SDK Command-line Tools
4. Android SDK Platform-Tools
5. ANDROID_HOME environment variable
6. Path updated

**Total Download Size:** ~2-3 GB
**Installation Time:** 15-30 minutes

---

## After Installation

Once everything is installed:

1. **Build your APK:**
   ```powershell
   flutter build apk --release
   ```

2. **Find your APK:**
   ```
   build\app\outputs\flutter-apk\app-release.apk
   ```

3. **Test on device:**
   - Enable USB debugging on Android phone
   - Connect via USB
   - Run: `flutter install`

4. **Upload to GitHub:**
   - Follow `DEPLOYMENT_GUIDE.md`
   - Create release and upload APK

---

## Visual Reference

When in SDK Manager, you should see checkmarks (✓) next to:

**SDK Platforms tab:**
```
☑ Android 13.0 (Tiramisu)
  ☑ Android SDK Platform 33
  ☑ Sources for Android 33
```

**SDK Tools tab:**
```
☑ Android SDK Build-Tools 33.0.0
☑ Android SDK Command-line Tools (latest)
☑ Android SDK Platform-Tools
☑ Android Emulator
```

---

## Need Help?

If you encounter issues:

1. Run `flutter doctor -v` for detailed diagnostics
2. Check Android Studio → Help → About to verify version
3. Verify SDK location in SDK Manager matches ANDROID_HOME
4. Restart computer after setting environment variables

**Still stuck?** Share the output of `flutter doctor -v` for specific troubleshooting.
