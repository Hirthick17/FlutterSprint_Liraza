# LIRAZA - AI-Powered Mental Health Support App

<div align="center">

![LIRAZA Logo](https://img.shields.io/badge/LIRAZA-Mental%20Health-FF1493?style=for-the-badge)
![Flutter](https://img.shields.io/badge/Flutter-3.10+-02569B?style=for-the-badge&logo=flutter)
![Firebase](https://img.shields.io/badge/Firebase-Enabled-FFCA28?style=for-the-badge&logo=firebase)

**Your AI-powered companion for mental wellness**

[Download APK](#download) • [Features](#features) • [Setup](#setup) • [Contributing](#contributing)

</div>

---

## 🌟 Features

- **🎯 AI Mood Tracking** - Track your emotions with intelligent insights powered by Google Gemini AI
- **📊 Visual Analytics** - Beautiful charts showing emotional patterns and mood trends
- **💡 Smart Habit Suggestions** - Personalized recommendations based on your mental health journey
- **👥 Therapist Directory** - Find and connect with mental health professionals
- **💬 AI Chat Support** - 24/7 conversational support for mental wellness
- **📅 Habit Calendar** - Track daily habits and build consistency

---

## 📱 Download

### Android APK
**[Download Latest Release](https://github.com/YOUR_USERNAME/liraza-app/releases/latest/download/app-release.apk)**

### Installation Instructions
1. Download the APK file
2. Enable "Install from Unknown Sources" in your Android settings
3. Open the APK file and tap "Install"
4. Launch LIRAZA and start your mental wellness journey!

---

## 🛠️ Setup for Development

### Prerequisites
- Flutter SDK 3.10 or higher
- Android Studio (for Android development)
- Xcode (for iOS development, Mac only)
- Firebase account
- Google Gemini API key

### Installation Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/YOUR_USERNAME/liraza-app.git
   cd liraza-app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**
   - Create a new Firebase project at [Firebase Console](https://console.firebase.google.com/)
   - Add Android/iOS apps to your Firebase project
   - Download `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
   - Place them in the appropriate directories:
     - Android: `android/app/google-services.json`
     - iOS: `ios/Runner/GoogleService-Info.plist`

4. **Set up Gemini API**
   - Get your API key from [Google AI Studio](https://makersuite.google.com/app/apikey)
   - Update `lib/core/constants/app_constants.dart`:
     ```dart
     static const String geminiApiKey = 'YOUR_API_KEY_HERE';
     ```

5. **Run the app**
   ```bash
   # For web
   flutter run -d chrome
   
   # For Android
   flutter run -d android
   
   # For iOS
   flutter run -d ios
   ```

---

## 📦 Building for Production

### Android APK

**Prerequisites:**
- Android SDK installed
- ANDROID_HOME environment variable set

**Build command:**
```bash
flutter build apk --release
```

**Output:** `build/app/outputs/flutter-apk/app-release.apk`

### Android App Bundle (for Play Store)
```bash
flutter build appbundle --release
```

### iOS (Mac only)
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

**Deploy to:**
- **Vercel**: `vercel deploy`
- **Netlify**: Upload `build/web` folder
- **Firebase Hosting**: `firebase deploy`
- **GitHub Pages**: Copy `build/web` to `docs` folder

---

## 🚀 Deployment

### GitHub Pages (Recommended for Landing Page)

1. **Build the web version** (optional)
   ```bash
   flutter build web --release
   cp -r build/web/* docs/
   ```

2. **Push to GitHub**
   ```bash
   git add .
   git commit -m "Deploy landing page"
   git push origin main
   ```

3. **Enable GitHub Pages**
   - Go to Repository Settings → Pages
   - Source: Deploy from branch `main`
   - Folder: `/docs`
   - Save

4. **Access your site**
   - URL: `https://YOUR_USERNAME.github.io/liraza-app/`

### Creating a Release

1. **Build the APK** (see above)

2. **Create GitHub Release**
   - Go to Releases → Create new release
   - Tag: `v1.0.0`
   - Title: `LIRAZA v1.0.0 - Initial Release`
   - Upload `app-release.apk`
   - Add release notes

3. **Update landing page**
   - Update download link in `docs/index.html`
   - Replace `YOUR_USERNAME` with your GitHub username

---

## 🔧 Configuration

### Firebase Setup
Enable the following services in Firebase Console:
- **Authentication** (Email/Password, Google Sign-In)
- **Cloud Firestore** (for mood logs and user data)
- **Cloud Functions** (for AI processing)
- **Analytics** (optional)

### Environment Variables
Update these files with your credentials:
- `lib/core/constants/app_constants.dart` - Gemini API key
- `android/app/google-services.json` - Firebase Android config
- `ios/Runner/GoogleService-Info.plist` - Firebase iOS config

---

## 📂 Project Structure

```
lib/
├── core/
│   ├── animations/        # Reusable animations
│   ├── constants/         # App constants and API keys
│   ├── services/          # AI and backend services
│   └── theme/            # Colors and text styles
├── features/
│   ├── chat/             # AI chat functionality
│   ├── dashboard/        # Analytics and insights
│   ├── habits/           # Habit tracking
│   ├── home/             # Home screen and mood tracking
│   ├── profile/          # User profile
│   └── therapist_directory/  # Therapist listings
└── main.dart             # App entry point
```

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- **Google Gemini AI** - For powering intelligent mood insights
- **Firebase** - For backend infrastructure
- **Flutter** - For the amazing cross-platform framework
- **fl_chart** - For beautiful data visualizations

---

## 📧 Contact

For questions or support, please open an issue on GitHub.

---

<div align="center">

**Made with 💖 for mental health awareness**

⭐ Star this repo if you find it helpful!

</div>
