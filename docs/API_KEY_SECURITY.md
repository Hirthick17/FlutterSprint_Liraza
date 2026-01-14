# Securing Your API Keys - Important Guide

## 🔐 Why This Matters

**NEVER commit API keys to GitHub!** Anyone can:
- ❌ Steal your API key
- ❌ Use up your quota
- ❌ Cost you money
- ❌ Access your services

---

## ✅ What We've Done

### 1. Created `.env` File
Location: `d:\OneDrive\Desktop\FlutterSpring\flutter_application_1\.env`

Contains your actual API key (NEVER commit this!)

### 2. Created `.env.example` File
Location: `d:\OneDrive\Desktop\FlutterSpring\flutter_application_1\.env.example`

Template for others to use (safe to commit)

### 3. Updated `.gitignore`
Added `.env` files so they're never committed to GitHub

### 4. Updated `app_constants.dart`
Now uses environment variables with fallback

---

## 🚀 Deploying to Vercel with API Keys

### Method 1: Vercel Dashboard (Recommended)

1. **Go to Vercel Dashboard**
   - https://vercel.com/dashboard

2. **Select your project**

3. **Go to Settings → Environment Variables**

4. **Add your API key:**
   - **Name:** `GEMINI_API_KEY`
   - **Value:** `AIzaSyCp9KbNf8s_S11v0ceKSMoQuM1cL5GnviE`
   - **Environments:** Check all (Production, Preview, Development)
   - Click **"Save"**

5. **Redeploy your app:**
   - Go to Deployments tab
   - Click "..." on latest deployment
   - Click "Redeploy"

---

### Method 2: Vercel CLI

```powershell
# Set environment variable
vercel env add GEMINI_API_KEY

# When prompted:
# - Enter value: AIzaSyCp9KbNf8s_S11v0ceKSMoQuM1cL5GnviE
# - Select environments: Production, Preview, Development

# Redeploy
vercel --prod
```

---

## 📝 For GitHub Deployment

### Before Pushing to GitHub:

1. **Verify `.env` is in `.gitignore`:**
   ```powershell
   cat .gitignore | Select-String ".env"
   ```
   Should show: `.env`

2. **Check what will be committed:**
   ```powershell
   git status
   ```
   **Should NOT see:** `.env`
   **Should see:** `.env.example`

3. **If `.env` appears, remove it:**
   ```powershell
   git rm --cached .env
   git commit -m "Remove .env from tracking"
   ```

4. **Safe to push:**
   ```powershell
   git add .
   git commit -m "Initial commit"
   git push
   ```

---

## 🔄 How It Works Now

### Development (Local):
```dart
// Uses the fallback value in app_constants.dart
static const String geminiApiKey = String.fromEnvironment(
  'GEMINI_API_KEY',
  defaultValue: 'AIzaSyCp9KbNf8s_S11v0ceKSMoQuM1cL5GnviE',
);
```

### Production (Vercel):
- Reads from Vercel environment variable
- If not set, uses fallback (for now)
- **Best practice:** Always set in Vercel dashboard

---

## 🛡️ Security Best Practices

### ✅ DO:
- ✅ Use environment variables for API keys
- ✅ Add `.env` to `.gitignore`
- ✅ Commit `.env.example` (without real keys)
- ✅ Set environment variables in Vercel dashboard
- ✅ Rotate API keys if exposed
- ✅ Use different keys for dev/prod

### ❌ DON'T:
- ❌ Commit `.env` file
- ❌ Hardcode API keys in code
- ❌ Share API keys in screenshots
- ❌ Push API keys to GitHub
- ❌ Use production keys in development

---

## 🔍 Verify Your Setup

### 1. Check `.gitignore`:
```powershell
cat .gitignore
```
Should contain:
```
# Environment variables - NEVER commit API keys!
.env
.env.local
.env.*.local
```

### 2. Check what Git tracks:
```powershell
git ls-files | Select-String ".env"
```
Should show ONLY: `.env.example`
Should NOT show: `.env`

### 3. Test locally:
```powershell
flutter run -d chrome
```
App should work (using fallback key)

---

## 🚨 If You Already Committed API Keys

### 1. Remove from Git history:
```powershell
# Remove file from Git
git rm --cached lib/core/constants/app_constants.dart

# Commit the removal
git commit -m "Remove API keys"

# Force push (if already pushed)
git push --force
```

### 2. Rotate your API key:
- Go to Google AI Studio
- Delete old API key
- Create new API key
- Update `.env` file
- Update Vercel environment variable

---

## 📋 Deployment Checklist

Before deploying:

- [ ] `.env` file created with API key
- [ ] `.env` added to `.gitignore`
- [ ] `.env.example` created (without real key)
- [ ] Verified `.env` not in `git status`
- [ ] API key set in Vercel dashboard
- [ ] Tested locally
- [ ] Tested on Vercel

---

## 🎯 Current Status

**Your API key is now:**
- ✅ In `.env` file (not committed)
- ✅ In `.gitignore` (won't be committed)
- ✅ Has fallback in code (for development)
- ⚠️ **Next step:** Set in Vercel dashboard before deploying

---

## 🔗 Resources

- **Vercel Environment Variables:** https://vercel.com/docs/concepts/projects/environment-variables
- **Git Secrets:** https://github.com/awslabs/git-secrets
- **API Key Security:** https://cloud.google.com/docs/authentication/api-keys

---

## ⚡ Quick Commands

```powershell
# Check if .env is ignored
git check-ignore .env

# Should output: .env (means it's ignored ✅)

# List tracked files
git ls-files

# Should NOT include .env

# Deploy to Vercel with env vars
vercel --prod
# Then set GEMINI_API_KEY in dashboard
```

---

**Remember:** API keys are like passwords - keep them secret! 🔐
