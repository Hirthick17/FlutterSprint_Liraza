# Complete Android SDK Setup Guide - Ultra Detailed

## 🎯 What We're Going to Do

We need to install Android SDK so you can build APK files. Think of it like installing Microsoft Office to create Word documents - you need the right software to create Android apps.

**Time needed:** 30-45 minutes  
**Internet required:** Yes (2-3 GB download)  
**Difficulty:** Easy (just follow each step)

---

## 📥 PART 1: Download and Install Android Studio

### Step 1.1: Download Android Studio

1. **Open your web browser** (Chrome, Edge, etc.)

2. **Go to this website:**
   ```
   https://developer.android.com/studio
   ```

3. **You'll see a big green button** that says:
   ```
   Download Android Studio Hedgehog | 2023.1.1
   ```
   (The version name might be different - that's okay!)

4. **Click the green download button**

5. **A popup will appear** asking you to agree to terms:
   - ✅ Check the box "I have read and agree..."
   - Click **"Download Android Studio for Windows"**

6. **Save the file** (usually goes to your Downloads folder)
   - File name: `android-studio-2023.1.1.26-windows.exe` (or similar)
   - Size: About 1 GB

7. **Wait for download to complete** (5-10 minutes depending on internet speed)

---

### Step 1.2: Install Android Studio

1. **Find the downloaded file**
   - Open **File Explorer**
   - Go to **Downloads** folder
   - Look for `android-studio-...exe`

2. **Double-click the installer file**

3. **Windows might ask "Do you want to allow this app to make changes?"**
   - Click **"Yes"**

4. **Android Studio Setup window appears:**

   **Screen 1: Welcome**
   - Click **"Next"**

   **Screen 2: Choose Components**
   - ✅ Make sure BOTH boxes are checked:
     - Android Studio
     - Android Virtual Device
   - Click **"Next"**

   **Screen 3: Configuration Settings**
   - Just click **"Next"** (use default location)

   **Screen 4: Choose Start Menu Folder**
   - Click **"Install"**

5. **Installation begins** (takes 5-10 minutes)
   - You'll see a progress bar
   - Wait for it to say "Completed"

6. **When done:**
   - ✅ Check "Start Android Studio"
   - Click **"Finish"**

---

### Step 1.3: First Launch Setup

Android Studio will now open for the first time:

1. **Import Settings screen:**
   - Select **"Do not import settings"**
   - Click **"OK"**

2. **Welcome screen:**
   - Click **"Next"**

3. **Install Type:**
   - Select **"Standard"** (recommended)
   - Click **"Next"**

4. **Select UI Theme:**
   - Choose **"Light"** or **"Darcula"** (your preference)
   - Click **"Next"**

5. **Verify Settings:**
   - You'll see a list of components to download
   - Total download: ~2 GB
   - Click **"Next"**

6. **License Agreement:**
   - Click **"Accept"** for each license
   - Click **"Finish"**

7. **Downloading Components:**
   - This takes 10-20 minutes
   - You'll see progress bars for:
     - Android SDK Platform
     - Android SDK Build-Tools
     - Android Emulator
   - **Wait for "Finish" button to appear**
   - Click **"Finish"**

8. **You'll see the Android Studio welcome screen**
   - Don't create a project yet!

---

## 🔧 PART 2: Install Required SDK Packages

### Step 2.1: Open SDK Manager

1. **On the Android Studio welcome screen:**
   - Look for **"More Actions"** button (bottom right area)
   - Click it
   - Select **"SDK Manager"**

   **Alternative if you don't see "More Actions":**
   - Click **"Configure"** (bottom right)
   - Select **"SDK Manager"**

2. **SDK Manager window opens**

---

### Step 2.2: Install SDK Platforms

You're now in the SDK Manager. You'll see two tabs at the top:
- **SDK Platforms** (selected by default)
- **SDK Tools**

**In the SDK Platforms tab:**

1. **Look at the list of Android versions**
   - You'll see: Android 14, Android 13, Android 12, etc.

2. **Find "Android 13.0 (Tiramisu)"**
   - API Level: 33
   - ☐ There's a checkbox on the left

3. **Click the checkbox** next to "Android 13.0 (Tiramisu)"
   - It should now show: ☑

4. **Optional but recommended:**
   - Also check ☑ "Android 12.0 (S)" - API Level 31

5. **At the bottom right, you'll see:**
   - "X packages selected for update"
   - Don't click anything yet!

---

### Step 2.3: Install SDK Tools

1. **Click the "SDK Tools" tab** (at the top)

2. **You'll see a list of tools**
   - Some might already be checked ☑
   - Some will be unchecked ☐

3. **Check these boxes** (if not already checked):

   **MUST HAVE (Required):**
   
   ☑ **Android SDK Build-Tools 33.0.0**
   - Look for "Android SDK Build-Tools"
   - Make sure version 33.0.0 or higher is checked
   
   ☑ **Android SDK Command-line Tools (latest)**
   - Should say "latest" in parentheses
   
   ☑ **Android SDK Platform-Tools**
   - Usually already checked
   
   ☑ **Android Emulator**
   - For testing (recommended)

4. **At the bottom right:**
   - Look for a checkbox: ☐ "Show Package Details"
   - **Check this box** ☑
   - Now you can see version numbers

5. **Verify Build-Tools version:**
   - Expand "Android SDK Build-Tools"
   - Make sure **33.0.0** is checked
   - If you see 34.0.0 or higher, that's fine too

---

### Step 2.4: Apply Changes

1. **Click "Apply" button** (bottom right)

2. **Confirm Change window appears:**
   - Shows list of packages to install
   - Shows total download size (usually 500 MB - 1 GB)
   - Click **"OK"**

3. **License Agreement:**
   - You'll see license text
   - Click **"Accept"**
   - Click **"Next"**

4. **Component Installer:**
   - Shows progress bars
   - "Downloading..."
   - "Installing..."
   - **This takes 10-20 minutes**
   - ☕ Good time for a coffee break!

5. **When all done:**
   - Progress bars complete
   - Click **"Finish"**

6. **Back in SDK Manager:**
   - You should see ☑ checkmarks next to installed items
   - Click **"OK"** to close SDK Manager

---

## 🌍 PART 3: Set Environment Variables

This tells Windows where to find Android SDK.

### Step 3.1: Find SDK Location

1. **In Android Studio SDK Manager** (if you closed it, reopen it):
   - At the very top, you'll see:
     ```
     Android SDK Location: C:\Users\YourName\AppData\Local\Android\Sdk
     ```

2. **Copy this path** (select it and press Ctrl+C)
   - Example: `C:\Users\hirth\AppData\Local\Android\Sdk`
   - **Write it down** or keep it copied!

---

### Step 3.2: Set ANDROID_HOME Variable

1. **Press Windows key + R** (opens Run dialog)

2. **Type:** `sysdm.cpl`

3. **Press Enter**

4. **System Properties window opens:**
   - Click **"Advanced"** tab (at the top)
   - Click **"Environment Variables"** button (at bottom)

5. **Environment Variables window opens:**
   - You'll see two sections:
     - User variables (top)
     - System variables (bottom)

6. **In the "System variables" section (bottom):**
   - Click **"New..."** button

7. **New System Variable window:**
   - **Variable name:** Type exactly: `ANDROID_HOME`
   - **Variable value:** Paste the SDK location you copied earlier
     - Example: `C:\Users\hirth\AppData\Local\Android\Sdk`
   - Click **"OK"**

---

### Step 3.3: Update Path Variable

Still in the Environment Variables window:

1. **In "System variables" section:**
   - Scroll down and find **"Path"**
   - Click on **"Path"** to select it
   - Click **"Edit..."** button

2. **Edit Environment Variable window opens:**
   - You'll see a list of paths

3. **Click "New"** button (top right)

4. **Add these paths ONE AT A TIME:**
   
   **First path:**
   - Type: `%ANDROID_HOME%\platform-tools`
   - Press Enter or click "New" again
   
   **Second path:**
   - Type: `%ANDROID_HOME%\cmdline-tools\latest\bin`
   - Press Enter
   
   **Third path:**
   - Type: `%ANDROID_HOME%\tools`
   - Press Enter
   
   **Fourth path:**
   - Type: `%ANDROID_HOME%\tools\bin`
   - Press Enter

5. **Click "OK"** on Edit Environment Variable window

6. **Click "OK"** on Environment Variables window

7. **Click "OK"** on System Properties window

---

### Step 3.4: Restart Everything

**IMPORTANT:** Changes won't work until you restart!

1. **Close ALL terminal/PowerShell windows**

2. **Close Android Studio**

3. **Restart your computer** (recommended)
   - Or at minimum, close and reopen PowerShell

---

## ✅ PART 4: Verify Installation

### Step 4.1: Check Flutter Doctor

1. **Open PowerShell:**
   - Press Windows key
   - Type: `powershell`
   - Press Enter

2. **Type this command:**
   ```powershell
   flutter doctor
   ```

3. **Press Enter**

4. **Wait for results** (takes 10-20 seconds)

---

### Step 4.2: Understand the Results

You should see something like this:

```
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel stable, 3.10.6)
[✓] Android toolchain - develop for Android devices (Android SDK version 33.0.0)
[✓] Chrome - develop for the web
[✓] Android Studio (version 2023.1)
[✓] VS Code (version 1.85.0)
[!] Connected device
    ! No devices available
```

**What to look for:**

✅ **GOOD - You see this:**
```
[✓] Android toolchain - develop for Android devices (Android SDK version 33.0.0)
```
**Meaning:** Android SDK is installed correctly! ✅

❌ **BAD - You see this:**
```
[✗] Android toolchain - develop for Android devices
    ✗ Unable to locate Android SDK
```
**Meaning:** Environment variables not set correctly
**Solution:** Go back to Part 3 and double-check ANDROID_HOME

⚠️ **WARNING - You see this:**
```
[!] Android toolchain - develop for Android devices
    ! Some Android licenses not accepted
```
**Meaning:** Need to accept licenses (we'll do this next)

---

### Step 4.3: Accept Android Licenses

1. **In PowerShell, type:**
   ```powershell
   flutter doctor --android-licenses
   ```

2. **Press Enter**

3. **You'll see:**
   ```
   Review licenses that have not been accepted (y/N)?
   ```

4. **Type:** `y`

5. **Press Enter**

6. **For each license:**
   - You'll see license text
   - At the bottom: `Accept? (y/N):`
   - Type: `y`
   - Press Enter
   - Repeat for all licenses (usually 5-7 licenses)

7. **When done, you'll see:**
   ```
   All SDK package licenses accepted
   ```

8. **Run flutter doctor again:**
   ```powershell
   flutter doctor
   ```

9. **Now Android toolchain should show ✓**

---

## 🏗️ PART 5: Build Your APK

### Step 5.1: Navigate to Your Project

1. **In PowerShell, type:**
   ```powershell
   cd d:\OneDrive\Desktop\FlutterSpring\flutter_application_1
   ```

2. **Press Enter**

---

### Step 5.2: Clean and Get Dependencies

1. **Type:**
   ```powershell
   flutter clean
   ```

2. **Press Enter** (wait for it to finish)

3. **Type:**
   ```powershell
   flutter pub get
   ```

4. **Press Enter** (wait for it to finish)

---

### Step 5.3: Build the APK

1. **Type:**
   ```powershell
   flutter build apk --release
   ```

2. **Press Enter**

3. **You'll see:**
   ```
   Running Gradle task 'assembleRelease'...
   ```

4. **Wait 2-5 minutes** (first build takes longer)

5. **If successful, you'll see:**
   ```
   ✓ Built build\app\outputs\flutter-apk\app-release.apk (15.2MB)
   ```

6. **🎉 Congratulations! Your APK is ready!**

---

### Step 5.4: Find Your APK

1. **Open File Explorer**

2. **Navigate to:**
   ```
   d:\OneDrive\Desktop\FlutterSpring\flutter_application_1\build\app\outputs\flutter-apk\
   ```

3. **You'll see:**
   - `app-release.apk` ← This is your app!

4. **File size:** Usually 10-20 MB

---

## 🚨 Troubleshooting Common Errors

### Error 1: "Android SDK not found"

**What you see:**
```
[✗] Android toolchain
    ✗ Unable to locate Android SDK
```

**Solution:**
1. Open PowerShell
2. Type: `echo %ANDROID_HOME%`
3. Press Enter
4. If it shows blank or wrong path:
   - Go back to Part 3
   - Re-do environment variables
   - **Restart computer**

---

### Error 2: "cmdline-tools component is missing"

**What you see:**
```
✗ cmdline-tools component is missing
```

**Solution:**
1. Open Android Studio
2. More Actions → SDK Manager
3. SDK Tools tab
4. Check ☑ "Android SDK Command-line Tools (latest)"
5. Click Apply
6. Close and reopen PowerShell
7. Try `flutter doctor` again

---

### Error 3: "Gradle build failed"

**What you see:**
```
FAILURE: Build failed with an exception.
```

**Solution:**
```powershell
cd android
.\gradlew clean
cd ..
flutter clean
flutter pub get
flutter build apk --release
```

---

### Error 4: "License not accepted"

**What you see:**
```
[!] Some Android licenses not accepted
```

**Solution:**
```powershell
flutter doctor --android-licenses
```
Type `y` for each license

---

## 📋 Quick Checklist

Before building APK, verify:

- [ ] Android Studio installed
- [ ] SDK Platform 33 installed (in SDK Manager)
- [ ] Build-Tools 33.0.0 installed (in SDK Manager)
- [ ] Command-line Tools installed (in SDK Manager)
- [ ] Platform-Tools installed (in SDK Manager)
- [ ] ANDROID_HOME environment variable set
- [ ] Path variable updated with 4 Android paths
- [ ] Computer restarted (or at least PowerShell restarted)
- [ ] `flutter doctor` shows ✓ for Android toolchain
- [ ] All licenses accepted

---

## 🎯 Summary

**What you installed:**
- Android Studio (IDE)
- Android SDK Platform 33 (Android libraries)
- Build-Tools (APK compiler)
- Command-line Tools (Flutter needs this)
- Platform-Tools (ADB for testing)

**What you configured:**
- ANDROID_HOME variable (tells Windows where SDK is)
- Path variable (makes tools accessible)

**What you can now do:**
- Build APK files
- Test on Android devices
- Distribute your app

---

## 🆘 Still Having Issues?

1. **Run detailed diagnostics:**
   ```powershell
   flutter doctor -v
   ```

2. **Copy the full output**

3. **Share it for help** (paste in a message)

4. **Common final checks:**
   - Did you restart computer after setting environment variables?
   - Is ANDROID_HOME exactly: `C:\Users\YourName\AppData\Local\Android\Sdk`?
   - Did you accept all licenses?

---

**You've got this! Follow each step carefully and you'll have your APK ready to share! 🚀**
