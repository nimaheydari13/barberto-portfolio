# 🛠️ Project Setup Guide

This document outlines the steps to set up and run the Barberto Flutter project.

## 📦 Prerequisites

- **Flutter SDK**: Version 3.35.4 (latest stable)
- **Dart SDK**: Version 3.9.2
- **Git**: For version control
- **Android Studio** or **VS Code**: With Flutter extensions
- **Java JDK**: For Android builds
- **Appwrite Account** (optional): For full backend functionality

## 🧰 Installation Steps

### 1. Clone the Repository

```bash
git clone https://github.com/nimaheydari13/barberto-portfolio.git
cd barberto-portfolio
```

### 2. Install Flutter Dependencies

```bash
flutter pub get
```

### 3. Configure Environment Variables (Optional)

If you want to integrate with Appwrite:

```bash
# Copy the example environment file
cp .env.example .env

# Edit .env with your Appwrite credentials
```

### 4. Run the App

**For Android/iOS emulator:**
```bash
flutter run
```

**For web (Chrome):**
```bash
flutter run -d chrome
```

**For a specific device:**
```bash
flutter devices  # List available devices
flutter run -d <device_id>
```

## 🔧 Android Configuration

Ensure `android/app/build.gradle` contains:

```groovy
android {
    compileSdkVersion 34
    
    defaultConfig {
        minSdkVersion 21
        targetSdkVersion 34
    }
}
```

## 🧪 Testing

### Run All Tests
```bash
flutter test
```

### Run Specific Test File
```bash
flutter test test/services/api_service_test.dart
```

### Generate Coverage Report
```bash
flutter test --coverage
```

## 📱 Building for Production

### Android APK
```bash
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk
```

### Android App Bundle (Play Store)
```bash
flutter build appbundle --release
# Output: build/app/outputs/bundle/release/app-release.aab
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release --no-tree-shake-icons
# Output: build/web/
```

## 🔄 Version Management with FVM (Optional)

To ensure consistent Flutter versions across machines:

```bash
# Install FVM
dart pub global activate fvm

# Install the specific Flutter version
fvm install 3.35.4

# Use this version for the project
fvm use 3.35.4

# Run Flutter commands with FVM
fvm flutter run
```

## 🧩 Project Structure

```
lib/
├── main.dart                 # Entry point
├── config/
│   └── environment.dart      # Config
├── constants/
│   └── routes.dart           # Routes
├── providers/                # Riverpod providers
├── services/                 # API services
├── screens/                  # UI screens
├── widgets/                  # Reusable widgets
├── theme/                    # Theme config
└── utils/                    # Helper functions
```

## 📚 Next Steps

1. **Explore the Architecture**: Check out `docs/architecture.md`
2. **Learn State Management**: See `docs/riverpod-guide.md`
3. **Understand the Services**: Review `docs/api-modularization.md`
4. **Check Deployment**: Read `docs/deployment.md`

## ⚠️ Troubleshooting

### Build fails with plugin errors
```bash
flutter clean
flutter pub get
flutter run
```

### iOS build fails
```bash
cd ios
pod install --repo-update
cd ..
flutter run
```

### Web build fails
```bash
flutter clean
flutter pub get
flutter build web --release --no-tree-shake-icons
```

## 🆘 Getting Help

- Check Flutter documentation: https://flutter.dev/docs
- Review Appwrite docs: https://appwrite.io/docs
- Open an issue in this repository

---

**Happy coding!** 🚀
