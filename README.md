# 📱 Barberto - Flutter Barber Booking App

![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)
![Flutter Version](https://img.shields.io/badge/Flutter-3.35.4-blue.svg)
![Dart Version](https://img.shields.io/badge/Dart-3.9.2-blue.svg)

> A feature-rich Flutter mobile application for barber shop booking, appointment management, and location-based discovery. Built with modern architecture, optimized performance, and scalable design patterns.

## 🌟 Key Features

### Core Functionality
- ✅ **Secure Authentication** with Appwrite + enhanced session validation
- ✅ **Appointment Scheduling** with real-time updates
- ✅ **Location-Based Discovery** - Find barbers by state, city, and area
- ✅ **User Profiles** with profile pictures and preferences
- ✅ **Barber Profiles** with services, ratings, and reviews
- ✅ **Store/Product Catalog** with inventory management

### Technical Achievements
- 🚀 **70-90% Bandwidth Reduction** - Optimized Appwrite API usage through intelligent caching
- 🎯 **Smart Caching System** with lazy loading and state preservation
- 🌙 **Dark Mode Support** with seamless theme switching
- 📐 **Fully Responsive** - Mobile, tablet, and desktop support
- 🧩 **Modular Architecture** - Separable service layers (UserService, BarberService, StoreService, etc.)
- ⚡ **State Management** - Riverpod-based reactive architecture
- 🔒 **Enhanced Security** - Web session management with server-side validation

## 🛠️ Technology Stack

| Layer | Technology | Version |
|-------|-----------|----------|
| **Framework** | Flutter | 3.35.4 |
| **Language** | Dart | 3.9.2 |
| **Backend** | Appwrite | 19.1.0 |
| **State Management** | Riverpod | 2.5.1 |
| **Authentication** | Appwrite + Secure Storage | Latest |
| **UI Components** | Material Design 3 | Latest |
| **Maps** | Google Maps Flutter | 2.13.1 |
| **Forms** | Custom Widgets | — |

## 📦 Architecture Overview

```
lib/
├── main.dart                 # App entry point with Riverpod setup
├── config/
│   └── environment.dart      # Environment configuration
├── constants/
│   └── routes.dart           # Named routes and navigation
├── providers/
│   ├── theme_notifier.dart   # Dark mode state
│   └── auth_notifier.dart    # Auth state management
├── services/
│   ├── api_service.dart      # Core API client
│   ├── user_service.dart     # User operations
│   ├── barber_service.dart   # Barber operations
│   ├── store_service.dart    # Store/product operations
│   └── cache_service.dart    # Caching layer
├── screens/
│   ├── auth/
│   │   ├── login_screen.dart
│   │   └── signup_screen.dart
│   ├── home/
│   │   └── home_screen.dart
│   └── profile/
│       └── profile_screen.dart
├── widgets/
│   └── custom_widgets.dart
├── theme/
│   └── theme.dart            # Light & dark themes
└── utils/
    ├── responsive_extensions.dart
    └── helpers.dart
```

## 🚀 Getting Started

### Prerequisites
- **Flutter SDK**: 3.35.4 or higher
- **Dart SDK**: 3.9.2 or higher
- **Android Studio** or **VS Code** with Flutter extensions
- **Git**: For version control
- **Appwrite Account**: For backend services (optional for development)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/nimaheydari13/barberto-portfolio.git
   cd barberto-portfolio
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Set up environment variables** (if using Appwrite)
   ```bash
   # Create .env file with your Appwrite credentials
   cp .env.example .env
   # Edit .env with your actual values
   ```

4. **Run the app**
   ```bash
   # For Android/iOS
   flutter run
   
   # For Web
   flutter run -d chrome
   ```

### Android Configuration

Ensure your `android/app/build.gradle` has:
```groovy
android {
    compileSdkVersion 34
    defaultConfig {
        minSdkVersion 21
        targetSdkVersion 34
    }
}
```

## 🏗️ Architecture Highlights

### 1. **Modular Service Architecture**
Services are separated by domain:
- `UserService` - Authentication and user management
- `BarberService` - Barber profile and operations
- `StoreService` - Products and inventory
- `ContentService` - App constants and versioning
- `CacheService` - Centralized caching with expiry

**Benefits**: Easy to test, maintain, and scale independently.

### 2. **Riverpod State Management**
```dart
// Example: User provider
final userProvider = FutureProvider<User>((ref) async {
  return await UserService.instance.getUser();
});

// Usage in widgets
final user = ref.watch(userProvider);
```

### 3. **Smart Caching System**
- Automatic cache expiry (configurable)
- Lazy loading for expensive operations
- State preservation across navigation
- Manual refresh options

```dart
// Cached API call
final cachedBarbers = CacheService.instance.getCachedData(
  'barbers_list',
  () => BarberService.instance.getBarbers(),
  expiryMinutes: 10,
);
```

### 4. **Responsive Design**
Built-in responsive utilities for mobile, tablet, and desktop:

```dart
getAdaptiveIconSize(32);      // Scales icon based on screen size
getAdaptivePadding(...);      // Responsive padding
getAdaptiveFontSize(16);      // Responsive text
isDesktop(context);           // Device detection
```

### 5. **Enhanced Authentication**
- Server-side session validation
- Automatic recovery from invalid sessions
- Web-optimized for browser cache clearing
- Cross-platform compatibility

## 📊 Performance Optimizations

### Bandwidth Reduction: 70-90%

| Optimization | Before | After | Reduction |
|--|--|--|--|
| ProfileScreen API calls | 5-6 calls/rebuild | 4 cached calls | ~80% |
| Store loading | Always loads | Lazy loading | 100% |
| App constants | Multiple calls | Single cached | ~90% |
| Navigation overhead | Full reload | State preserved | ~75% |
| **Overall** | High usage | Optimized | **70-90%** |

## 🧪 Testing

```bash
# Run unit tests
flutter test

# Run with coverage
flutter test --coverage

# Run specific test file
flutter test test/services/api_service_test.dart
```

## 📚 Documentation

Comprehensive documentation is included for various aspects:

- **[Routing & Authentication Flow](docs/routing-auth-flow.md)** - App navigation and auth patterns
- **[State Management with Riverpod](docs/riverpod-guide.md)** - Provider patterns and best practices
- **[API Service Architecture](docs/api-modularization.md)** - How services are organized
- **[Performance Optimization](docs/performance-guide.md)** - Caching and bandwidth reduction
- **[Responsive Design](docs/responsive-design.md)** - Multi-platform support

## 🚀 Deployment

### Web Deployment
```bash
# Build for web
flutter build web --release --no-tree-shake-icons

# Output is in: build/web/
```

### Android Deployment
```bash
# Build APK
flutter build apk --release

# Build App Bundle (for Play Store)
flutter build appbundle --release
```

### iOS Deployment
```bash
# Build IPA
flutter build ios --release
```

## 💡 Key Implementation Patterns

### Error Handling
```dart
try {
  final user = await UserService.instance.getUser();
} on AppwriteException catch (e) {
  print('API Error: ${e.message}');
} catch (e) {
  print('Unexpected error: $e');
}
```

### Loading States
```dart
final userAsync = ref.watch(userProvider);

userAsync.when(
  data: (user) => UserProfile(user: user),
  loading: () => LoadingWidget(),
  error: (err, stack) => ErrorWidget(error: err),
);
```

### Navigation with Routes
```dart
Navigator.pushNamed(context, AppRoutes.profile, arguments: userId);
```

## 🔐 Security Best Practices

- ✅ Secure token storage using `flutter_secure_storage`
- ✅ Server-side session validation
- ✅ HTTPS only for API calls
- ✅ Environment variables for sensitive config
- ✅ Input validation on all forms
- ✅ Proper error handling without exposing sensitive data

## 🤝 Contributing

This is a portfolio project. If you'd like to:
- **Study the code**: Feel free to explore and learn from the implementation
- **Use patterns**: Adapt the architecture patterns for your own projects
- **Ask questions**: Open an issue for any questions about the implementation

## 📄 License

MIT License - See [LICENSE](LICENSE) file for details

## 👨‍💻 Author

**Nima** - Founder & Lead Developer

## 📞 Get in Touch

If you have questions about the architecture, patterns, or implementation:
- Open an issue in this repository
- Check the documentation in `docs/` folder

---

## 🎯 What You'll Learn

This codebase demonstrates:
- ✅ Modern Flutter architecture with Riverpod
- ✅ Service-oriented API design
- ✅ Performance optimization techniques
- ✅ Responsive design patterns
- ✅ State management best practices
- ✅ Secure authentication flows
- ✅ Real-world caching strategies
- ✅ Multi-platform deployment

**Made with ❤️ by Nima**
