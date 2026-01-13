# 🌸 LIRAZA - AI Mental Health Companion

[![Flutter](https://img.shields.io/badge/Flutter-3.38.6-02569B?logo=flutter)](https://flutter.dev)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Live Demo](https://img.shields.io/badge/Demo-Live-success)](https://YOUR_USERNAME.github.io/flutter_application_1/)

**LIRAZA** is an AI-powered mental health support application designed to provide 24/7 emotional support, mood tracking, and personalized guidance. Built with Flutter for cross-platform compatibility.

![LIRAZA Banner](assets/images/banner.png)

## ✨ Features

### 🤖 AI Chat Companion
- Real-time AI conversations for emotional support
- Empathetic responses powered by Google Gemini AI
- 24/7 availability for mental health guidance

### 📊 Mental Health Dashboard
- Track your mood over time
- Visualize emotional patterns with beautiful charts
- Get personalized insights based on your data
- Monitor your mental health score

### 👨‍⚕️ Therapist Directory
- Find licensed therapists in your area
- Filter by specialty (Anxiety, Depression, Stress Management)
- View ratings and reviews
- Easy appointment booking

### 👤 User Profile
- Track your progress and streaks
- View your mental health statistics
- Manage account settings
- Privacy controls

## 🎨 Design

LIRAZA features a beautiful **magenta gradient theme** with:
- Modern Material 3 design
- Smooth animations and transitions
- Intuitive navigation
- Responsive layouts for all screen sizes

## 🚀 Live Demo

**[Try LIRAZA Now →](https://YOUR_USERNAME.github.io/flutter_application_1/)**

## 📱 Screenshots

| Splash Screen | Auth Screen | Home Dashboard |
|--------------|-------------|----------------|
| ![Splash](screenshots/splash.png) | ![Auth](screenshots/auth.png) | ![Home](screenshots/home.png) |

| AI Chat | Analytics | Profile |
|---------|-----------|---------|
| ![Chat](screenshots/chat.png) | ![Dashboard](screenshots/dashboard.png) | ![Profile](screenshots/profile.png) |

## 🛠️ Tech Stack

- **Framework:** Flutter 3.38.6
- **Language:** Dart
- **State Management:** Riverpod
- **Backend:** Firebase (Auth, Firestore, Functions)
- **AI:** Google Gemini API
- **UI:** Material 3, Google Fonts (Poppins)
- **Charts:** FL Chart
- **Animations:** Lottie

## 📦 Dependencies

```yaml
dependencies:
  flutter_riverpod: ^2.6.1
  firebase_core: ^3.6.0
  firebase_auth: ^5.3.1
  cloud_firestore: ^5.4.4
  google_generative_ai: ^0.4.6
  google_fonts: ^6.2.1
  fl_chart: ^0.69.0
  lottie: ^3.1.3
```

## 🏃‍♂️ Getting Started

### Prerequisites

- Flutter SDK 3.10.7 or higher
- Dart SDK
- Android Studio / VS Code
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/YOUR_USERNAME/flutter_application_1.git
   cd flutter_application_1
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   
   For Web:
   ```bash
   flutter run -d chrome
   ```
   
   For Android:
   ```bash
   flutter run
   ```
   
   For Windows:
   ```bash
   flutter run -d windows
   ```

## 🌐 Web Deployment

This app is deployed on GitHub Pages. To deploy your own version:

1. **Build for web**
   ```bash
   flutter build web --release --base-href "/flutter_application_1/"
   ```

2. **Deploy to GitHub Pages**
   ```bash
   git add build/web
   git commit -m "Deploy to GitHub Pages"
   git push origin main
   ```

3. **Enable GitHub Pages**
   - Go to repository Settings → Pages
   - Source: Deploy from a branch
   - Branch: main → /build/web
   - Save

## 🔧 Configuration

### Firebase Setup

1. Create a Firebase project at [console.firebase.google.com](https://console.firebase.google.com)
2. Add your Firebase configuration to:
   - `lib/firebase_options.dart` (auto-generated with FlutterFire CLI)
3. Enable Authentication and Firestore in Firebase Console

### Google Gemini API

1. Get your API key from [Google AI Studio](https://makersuite.google.com/app/apikey)
2. Add to your environment or secure storage

## 📂 Project Structure

```
lib/
├── main.dart                 # App entry point
├── core/
│   ├── theme/               # App theme, colors, text styles
│   └── constants/           # App constants
└── features/
    ├── splash/              # Splash screen
    ├── auth/                # Authentication
    ├── home/                # Home dashboard
    ├── chat/                # AI chat interface
    ├── dashboard/           # Analytics dashboard
    ├── therapist_directory/ # Therapist listings
    └── profile/             # User profile
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Google Fonts for the beautiful Poppins font
- Firebase for backend infrastructure
- Google Gemini for AI capabilities
- Flutter team for the amazing framework

## 📧 Contact

**Project Link:** [https://github.com/YOUR_USERNAME/flutter_application_1](https://github.com/YOUR_USERNAME/flutter_application_1)

---

<div align="center">
  <p>Made with ❤️ and Flutter</p>
  <p>© 2026 LIRAZA. All rights reserved.</p>
</div>
