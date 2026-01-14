# Deploying LIRAZA to GitHub Pages

## Quick Start

### 1. Push Code to GitHub

```bash
# Initialize git (if not already done)
git init

# Add all files
git add .

# Commit
git commit -m "Initial commit - LIRAZA Mental Health App"

# Add remote (replace YOUR_USERNAME and REPO_NAME)
git remote add origin https://github.com/YOUR_USERNAME/liraza-app.git

# Push to GitHub
git push -u origin main
```

### 2. Enable GitHub Pages

1. Go to your repository on GitHub
2. Click **Settings** tab
3. Scroll to **Pages** section (left sidebar)
4. Under **Source**:
   - Branch: `main`
   - Folder: `/docs`
   - Click **Save**

5. Wait 1-2 minutes for deployment

6. Your landing page will be live at:
   ```
   https://YOUR_USERNAME.github.io/liraza-app/
   ```

---

## Updating the Landing Page

### Update Download Link

Edit `docs/index.html` and replace:
```html
<a href="https://github.com/YOUR_USERNAME/liraza-app/releases/latest/download/app-release.apk" class="download-btn">
```

With your actual GitHub username.

### Update GitHub Link

Replace:
```html
<a href="https://github.com/YOUR_USERNAME/liraza-app" class="github-link">View on GitHub</a>
```

---

## Creating Your First Release

### 1. Build APK
Follow the instructions in `BUILD_APK_GUIDE.md` to build your APK.

### 2. Create Release on GitHub

1. Go to your repository
2. Click **Releases** (right sidebar)
3. Click **Create a new release**

4. Fill in details:
   - **Tag**: `v1.0.0`
   - **Title**: `LIRAZA v1.0.0 - Initial Release`
   - **Description**:
     ```markdown
     # LIRAZA v1.0.0 - Initial Release
     
     ## 🎉 Features
     - AI-powered mood tracking
     - Visual analytics dashboard
     - Personalized habit suggestions
     - Therapist directory
     - AI chat support
     
     ## 📱 Installation
     1. Download the APK below
     2. Enable "Install from Unknown Sources"
     3. Install and enjoy!
     
     ## 🐛 Known Issues
     - None yet!
     ```

5. **Upload APK**:
   - Drag and drop `app-release.apk` into the assets section

6. Click **Publish release**

### 3. Get Download URL

After publishing, your APK download URL will be:
```
https://github.com/YOUR_USERNAME/liraza-app/releases/download/v1.0.0/app-release.apk
```

Or use latest:
```
https://github.com/YOUR_USERNAME/liraza-app/releases/latest/download/app-release.apk
```

---

## Deploying Web Version (Optional)

If you want to deploy the actual Flutter web app:

### 1. Build Web Version
```bash
flutter build web --release
```

### 2. Copy to docs folder
```bash
# Windows PowerShell
Copy-Item -Recurse build\web\* docs\

# Mac/Linux
cp -r build/web/* docs/
```

### 3. Update index.html

The web version will replace your landing page. If you want both:
- Rename current `docs/index.html` to `docs/download.html`
- Copy web build to `docs/`
- Update links accordingly

### 4. Push to GitHub
```bash
git add docs/
git commit -m "Deploy web version"
git push
```

---

## Custom Domain (Optional)

### 1. Buy a Domain
From providers like:
- Namecheap
- GoDaddy
- Google Domains

### 2. Configure DNS

Add these records:
```
Type: A
Host: @
Value: 185.199.108.153

Type: A
Host: @
Value: 185.199.109.153

Type: A
Host: @
Value: 185.199.110.153

Type: A
Host: @
Value: 185.199.111.153

Type: CNAME
Host: www
Value: YOUR_USERNAME.github.io
```

### 3. Add CNAME File

Create `docs/CNAME`:
```
yourdomain.com
```

### 4. Update GitHub Pages Settings

In GitHub Pages settings:
- Custom domain: `yourdomain.com`
- Enforce HTTPS: ✓

---

## Updating Your Site

### Update Landing Page
```bash
# Edit docs/index.html
# Then:
git add docs/index.html
git commit -m "Update landing page"
git push
```

Changes will be live in 1-2 minutes.

### New Release
1. Build new APK
2. Create new release (e.g., `v1.1.0`)
3. Upload new APK
4. Landing page will automatically link to latest release

---

## Troubleshooting

### Page Not Loading
- Wait 2-3 minutes after enabling GitHub Pages
- Check Settings → Pages shows green checkmark
- Clear browser cache

### 404 Error
- Ensure `/docs` folder exists in `main` branch
- Check `docs/index.html` exists
- Verify GitHub Pages is enabled

### Download Link Broken
- Ensure release is published (not draft)
- Check APK is uploaded to release
- Verify URL matches your username/repo

---

## Analytics (Optional)

Add Google Analytics to track downloads:

1. Get tracking ID from Google Analytics

2. Add to `docs/index.html` before `</head>`:
```html
<!-- Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-XXXXXXXXXX"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'G-XXXXXXXXXX');
</script>
```

---

## Complete Checklist

- [ ] Code pushed to GitHub
- [ ] GitHub Pages enabled (`/docs` folder)
- [ ] Landing page accessible online
- [ ] APK built successfully
- [ ] First release created
- [ ] APK uploaded to release
- [ ] Download link updated in landing page
- [ ] Tested download and installation
- [ ] README updated with correct links
- [ ] Shared with users!

---

## Your URLs

After setup, you'll have:

- **Landing Page**: `https://YOUR_USERNAME.github.io/liraza-app/`
- **GitHub Repo**: `https://github.com/YOUR_USERNAME/liraza-app`
- **Latest APK**: `https://github.com/YOUR_USERNAME/liraza-app/releases/latest/download/app-release.apk`

---

## Next Steps

1. Follow `BUILD_APK_GUIDE.md` to build your APK
2. Create your first GitHub release
3. Share your landing page URL with users!

🎉 **Congratulations! Your app is now live and downloadable!**
