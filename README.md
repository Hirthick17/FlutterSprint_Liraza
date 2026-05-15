# LIRAZA - AI-Powered Mental Health Support App

<div align="center">

![LIRAZA Logo](https://img.shields.io/badge/LIRAZA-Mental%20Health-FF1493?style=for-the-badge)
![Flutter](https://img.shields.io/badge/Flutter-3.10+-02569B?style=for-the-badge&logo=flutter)
![Firebase](https://img.shields.io/badge/Firebase-Enabled-FFCA28?style=for-the-badge&logo=firebase)

**Your AI-powered companion for mental wellness**

</div>

# LIRAZA - AI-Powered Mental Health Support App

## Description

LIRAZA is an AI-powered mental health support mobile application built with Flutter. The app provides users with intelligent mood tracking powered by Google Gemini AI, visual analytics for emotional patterns, personalized habit suggestions, a therapist directory to find mental health professionals, 24/7 AI chat support for mental wellness, and a habit calendar to track daily habits and build consistency.

The application aims to make mental wellness support more accessible through technology, combining modern UI/UX design with powerful AI capabilities to provide personalized mental health guidance.

## Technologies

| Category | Technologies Used |
|----------|-------------------|
| **Framework** | Flutter 3.10+ |
| **Backend** | Firebase (Auth, Firestore, Cloud Functions, Analytics) |
| **AI/ML** | Google Gemini AI |
| **State Management** | Riverpod |
| **Database** | Supabase |
| **UI/Charts** | FL Chart, Google Fonts, Shimmer, Lottie |
| **Authentication** | Firebase Auth, Google Sign-In |
| **APIs** | Google Generative AI, Google APIs |

### Key Dependencies

- `firebase_core`, `firebase_auth`, `cloud_firestore`, `cloud_functions`, `firebase_analytics`
- `google_sign_in`, `google_generative_ai`, `googleapis`, `googleapis_auth`
- `flutter_riverpod` for state management
- `fl_chart` for data visualization
- `supabase_flutter` for database operations
- `lottie` for animations
- `shared_preferences` for local storage

## Process

The development process followed these key phases:

1. **Project Setup**: Initialized Flutter project with proper folder structure and configured dependencies
2. **Firebase Integration**: Set up Firebase project with Authentication, Firestore, and Cloud Functions
3. **Core Architecture**: Implemented clean architecture with features organized in separate modules (auth, chat, dashboard, habits, home, onboarding, profile, splash, therapist_directory)
4. **State Management**: Configured Riverpod for reactive state management across the app
5. **AI Integration**: Integrated Google Gemini AI for mood tracking insights and chat support
6. **UI Implementation**: Built responsive screens with custom theming, animations (Lottie), and loading states (Shimmer)
7. **Supabase Setup**: Added Supabase backend for additional data storage and real-time capabilities

## What I Learned From This Project

- **Full-Stack Mobile Development**: Gained experience with end-to-end mobile app development using Flutter and Firebase
- **AI Integration**: Learned how to integrate Google Gemini AI for generating intelligent insights and conversational support
- **State Management**: Mastered Riverpod for managing application state across multiple features
- **Firebase Services**: Deep understanding of Firebase Auth, Firestore, Cloud Functions, and Analytics
- **Clean Architecture**: Implemented separation of concerns with features, services, providers, and widgets organized properly
- **UI/UX Design**: Created polished user interfaces with custom themes, animations, and visual feedback
- **API Security**: Learned best practices for securing API keys and handling sensitive configuration
- **Cross-Platform Considerations**: Adapted features for web compatibility by removing platform-specific dependencies

## How to Run This Project

### Prerequisites

- Flutter SDK 3.10 or higher
- Android Studio (for Android) or Xcode (for iOS, Mac only)
- Firebase account
- Google Gemini API key

### Installation Steps

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd flutter_application_1
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**
   - Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
   - Add Android/iOS apps to your Firebase project
   - Download `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
   - Place them in the appropriate directories:
     - Android: `android/app/google-services.json`
     - iOS: `ios/Runner/GoogleService-Info.plist`

4. **Set up Gemini API**
   - Get your API key from [Google AI Studio](https://makersuite.google.com/app/apikey)
   - Update `lib/core/constants/app_constants.dart` with your API key

5. **Run the app**
   ```bash
   # For web
   flutter run -d chrome
   
   # For Android
   flutter run -d android
   
   # For iOS
   flutter run -d ios
   ```

## APK Export

**APK export is not possible** from this workspace. The project is configured for development and web deployment, but the build artifacts for Android APK generation are not available in this environment.

To build an APK for production:
- Use `flutter build apk --release` on a properly configured local machine with Android SDK installed
- Ensure you have configured your signing keys for release builds
- The debug APK can be generated with `flutter build apk --debug` for testing purposes

