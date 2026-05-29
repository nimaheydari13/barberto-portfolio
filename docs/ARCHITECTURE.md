# 🏗️ Architecture Overview

## Overview

Barberto uses a **layered architecture** with clear separation of concerns:

```
┌─────────────────────────────────────┐
│         Presentation Layer          │
│  (Screens, Widgets, UI Components)  │
├─────────────────────────────────────┤
│      State Management Layer          │
│     (Riverpod Providers, Notifiers)  │
├─────────────────────────────────────┤
│       Service/Domain Layer           │
│  (API Services, Business Logic)      │
├─────────────────────────────────────┤
│         Data Layer                  │
│  (Appwrite, Local Storage, Cache)    │
└─────────────────────────────────────┘
```

## Directory Structure

### `lib/`
Main application code

### `lib/main.dart`
App entry point with Riverpod setup:
```dart
runApp(
  ProviderScope(  // Riverpod setup
    child: MaterialApp(...)
  ),
);
```

### `lib/config/`
**Environment Configuration**
- `environment.dart` - Config variables using `--dart-define`

### `lib/constants/`
**App Constants**
- `routes.dart` - Named routes and navigation logic

### `lib/providers/`
**Riverpod Providers**
- State management for global app state
- Examples: `userProvider`, `themeModeProvider`, `barbersProvider`

### `lib/services/`
**Business Logic & API**

#### Core Services
- `api_service.dart` - Base HTTP client with Appwrite integration

#### Modular Services (Domain-specific)
- `user_service.dart` - User authentication and management
- `barber_service.dart` - Barber operations
- `store_service.dart` - Product/store management
- `content_service.dart` - App content and versioning
- `cache_service.dart` - Caching layer

### `lib/screens/`
**UI Screens**

```
screens/
├── auth/
│   ├── login_screen.dart
│   └── signup_screen.dart
├── home/
│   └── home_screen.dart
└── profile/
    └── profile_screen.dart
```

### `lib/widgets/`
**Reusable UI Components**
- Custom buttons, text fields, cards, etc.

### `lib/theme/`
**Theme Configuration**
- `theme.dart` - Light and dark theme definitions

### `lib/utils/`
**Helper Functions**
- `responsive_extensions.dart` - Responsive design utilities
- Helper functions for common operations

## Design Patterns

### 1. Service Locator Pattern

Services use singleton pattern for easy access:

```dart
// Access anywhere in the app
final user = await UserService.instance.getUser();
```

### 2. Riverpod Providers

All state is managed through Riverpod providers:

```dart
// Simple provider
final userProvider = FutureProvider<User>((ref) async {
  return await UserService.instance.getUser();
});

// Usage in widgets
class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return user.when(
      data: (user) => Text(user.name),
      loading: () => CircularProgressIndicator(),
      error: (err, stack) => Text('Error: $err'),
    );
  }
}
```

### 3. Cache Service Pattern

Caching with automatic expiry:

```dart
final cachedData = CacheService.instance.getCachedData(
  'key',
  () => expensiveAsyncOperation(),
  expiryMinutes: 10,
);
```

### 4. Error Handling

Consistent error handling across services:

```dart
try {
  final result = await service.operation();
} on AppwriteException catch (e) {
  // Handle API errors
  print('API Error: ${e.message}');
} catch (e) {
  // Handle unexpected errors
  print('Unexpected error: $e');
}
```

## Data Flow

### User Authentication Flow

```
1. User enters credentials
   ↓
2. LoginScreen calls UserService.login()
   ↓
3. UserService makes API call via ApiService
   ↓
4. Appwrite authenticates and returns token
   ↓
5. Token saved to secure storage
   ↓
6. AuthProvider notifies listeners
   ↓
7. Navigation updates to home screen
```

### Data Fetch Flow

```
1. Widget calls ref.watch(userProvider)
   ↓
2. Riverpod checks if data is cached
   ↓
3. If not cached, calls provider function
   ↓
4. Provider calls UserService
   ↓
5. UserService calls CacheService first
   ↓
6. If not in cache, hits API via ApiService
   ↓
7. Response cached with expiry
   ↓
8. Data returned and widget rebuilds
```

## Performance Optimizations

### 1. Lazy Loading
Screens and data are loaded only when needed:
- Home screen doesn't load store until user visits it
- Barber details only fetch when tapped

### 2. Smart Caching
All API responses cached with configurable expiry:
- User profile: 10 minutes
- Barber list: 5 minutes
- Store items: 15 minutes

### 3. State Preservation
Widget state preserved across navigation:
```dart
class HomeScreen extends StatefulWidget {
  // AutomaticKeepAliveClientMixin preserves state
  _HomeScreenState createState() => _HomeScreenState();
}
```

### 4. Responsive Design
Adaptive layouts for different screen sizes:
```dart
if (isDesktop(context)) {
  return DesktopLayout();
} else if (isTablet(context)) {
  return TabletLayout();
} else {
  return MobileLayout();
}
```

## Testing Strategy

### Unit Tests
- Service logic
- Utility functions
- Data models

### Widget Tests
- Individual UI components
- Form validation
- State changes

### Integration Tests
- Full user flows
- API integration
- Navigation

## Dependencies

### Core
- `flutter_riverpod` - State management
- `provider` - Change notifiers
- `appwrite` - Backend

### UI
- `flutter_svg` - Vector graphics
- `curved_navigation_bar` - Custom nav

### Utilities
- `flutter_secure_storage` - Secure token storage
- `geolocator` - Location services
- `google_maps_flutter` - Maps integration

## Security Considerations

1. **Token Storage**: Using `flutter_secure_storage` for secure storage
2. **HTTPS Only**: All API calls use HTTPS
3. **Input Validation**: All user inputs validated
4. **Error Messages**: Never expose sensitive data in errors
5. **Session Management**: Server-side validation for all sessions

## Scalability

The architecture supports growth:
- **New Services**: Add to `lib/services/` without affecting others
- **New Providers**: Add to `lib/providers/` for new state
- **New Screens**: Add to `lib/screens/` with consistent patterns
- **Backend Changes**: Abstract via services, easy to swap implementations

---

**This architecture provides a solid foundation for a scalable, maintainable Flutter application.**
