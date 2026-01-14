# 🚀 Deployment Guide for LIRAZA

## 1. Vercel Deployment (Recommended)

LIRAZA is optimized for Vercel deployment with `canvaskit` for high performance.

### Prerequisites
*   A [Vercel Account](https://vercel.com)
*   [Vercel CLI](https://vercel.com/docs/cli) installed (`npm i -g vercel`) OR connect via GitHub.

### Option A: Deploy via CLI (Fastest)

1.  **Open Terminal** in the project folder:
    ```bash
    cd d:\OneDrive\Desktop\FlutterSpring\flutter_application_1
    ```

2.  **Run Vercel**:
    ```bash
    vercel
    ```
    *   Follow the prompts (Yes to everything).
    *   It will detect `vercel.json` and configure automatically.

3.  **Production Deploy**:
    ```bash
    vercel --prod
    ```

### Option B: Deploy via GitHub

1.  Push your code to a GitHub repository.
2.  Go to Vercel Dashboard -> "New Project".
3.  Import your repository.
4.  **Build Settings**:
    *   Framework Preset: **Other**
    *   Build Command: `flutter build web --release --web-renderer canvaskit`
    *   Output Directory: `build/web`
5.  Click **Deploy**.

---

## 2. Firebase Configuration (Required for Auth)

For the Login/Sign-up to work on the deployed site, you must:

1.  **Add Domain to Firebase**:
    *   Go to [Firebase Console](https://console.firebase.google.com) -> Authentication -> Settings -> Authorized Domains.
    *   Add your Vercel domain (e.g., `liraza.vercel.app`).

2.  **Update Config**:
    *   Ensure `lib/firebase_options.dart` has your actual Firebase keys.
    *   If you deployed without keys, the app will load but Auth will fail.
