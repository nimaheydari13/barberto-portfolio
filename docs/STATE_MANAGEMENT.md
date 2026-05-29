# 📊 State Management with Riverpod

Barberto uses **Riverpod** for all state management needs. This guide explains the patterns and best practices.

## What is Riverpod?

Riverpod is a reactive state management solution for Flutter that:
- Eliminates "Provider Hell" (deeply nested providers)
- Has no context requirement
- Provides compile-time safety
- Enables powerful code generation

## Provider Types

### 1. FutureProvider - Async Data

For async operations like API calls:

```dart
final userProvider = FutureProvider<User>((ref) async {
  final user = await UserService.instance.getUser();
  return user;
});

// Usage
final user = ref.watch(userProvider);
user.when(
  data: (user) => Text(user.name),
  loading: () => Loader(),
  error: (err, stack) => ErrorWidget(),
);
```

### 2. StateProvider - Mutable State

For simple mutable state:

```dart
final counterProvider = StateProvider<int>((ref) => 0);

// Usage
final count = ref.watch(counterProvider);
ref.read(counterProvider.notifier).state++;
```

### 3. StateNotifierProvider - Complex State

For complex state logic:

```dart
class UserNotifier extends StateNotifier<User> {
  UserNotifier() : super(User.empty());
  
  Future<void> updateUser(User user) async {
    state = user;
    await UserService.instance.saveUser(user);
  }
}

final userNotifierProvider = StateNotifierProvider<UserNotifier, User>(
  (ref) => UserNotifier(),
);
```

### 4. Provider - Computed Values

For derived state:

```dart
final userEmailProvider = Provider<String>((ref) {
  final user = ref.watch(userProvider);
  return user.when(
    data: (user) => user.email,
    loading: () => 'Loading...',
    error: (_, __) => 'Error',
  );
});
```

## Common Patterns

### Pattern 1: Refresh Data

```dart
// In your widget
ref.refresh(userProvider);

// Or get the provider and invalidate
ref.invalidate(userProvider);
```

### Pattern 2: Combine Providers

```dart
final userWithBarbersProvider = FutureProvider<(User, List<Barber>)>((ref) async {
  final user = await ref.watch(userProvider.future);
  final barbers = await ref.watch(barbersProvider.future);
  return (user, barbers);
});
```

### Pattern 3: Filter/Search

```dart
final searchQueryProvider = StateProvider<String>((ref) => '');

final filteredBarbersProvider = FutureProvider<List<Barber>>((ref) async {
  final query = ref.watch(searchQueryProvider);
  final allBarbers = await ref.watch(barbersProvider.future);
  
  if (query.isEmpty) return allBarbers;
  return allBarbers.where((b) => b.name.contains(query)).toList();
});
```

### Pattern 4: Cache with Manual Refresh

```dart
final cachedUserProvider = FutureProvider<User>((ref) async {
  // This caches the result and only refetches when explicitly invalidated
  final result = await UserService.instance.getUser();
  return result;
});

// To refresh
ref.refresh(cachedUserProvider);
```

## Using in Widgets

### ConsumerWidget

For read-only access to providers:

```dart
class UserProfileWidget extends ConsumerWidget {
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

### ConsumerStatefulWidget

For stateful widgets that need Riverpod:

```dart
class UserFormWidget extends ConsumerStatefulWidget {
  @override
  ConsumerState<UserFormWidget> createState() => _UserFormWidgetState();
}

class _UserFormWidgetState extends ConsumerState<UserFormWidget> {
  late TextEditingController _nameController;
  
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }
  
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    
    return ElevatedButton(
      onPressed: () async {
        await ref.read(userProvider.notifier).updateUser(
          user.copyWith(name: _nameController.text),
        );
      },
      child: Text('Update'),
    );
  }
  
  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
```

## Error Handling

```dart
final safeUserProvider = FutureProvider<User?>((ref) async {
  try {
    return await UserService.instance.getUser();
  } on AppwriteException catch (e) {
    print('API Error: ${e.message}');
    return null;
  } catch (e) {
    print('Unexpected error: $e');
    return null;
  }
});
```

## Performance Tips

### 1. Use .select() for Partial Updates

```dart
// Instead of watching the entire user
final user = ref.watch(userProvider);

// Watch only the name
final userName = ref.watch(
  userProvider.select((user) => user.maybeWhen(
    data: (u) => u.name,
    orElse: () => '',
  ))
);
```

### 2. Use read() for One-time Access

```dart
// In an event handler, use read instead of watch
ElevatedButton(
  onPressed: () {
    final user = ref.read(userProvider);
    print(user);
  },
  child: Text('Click'),
)
```

### 3. Lazy Load Data

```dart
final heavyDataProvider = FutureProvider<HeavyData>((ref) {
  // Only fetch when explicitly watched
  return HeavyService.instance.fetchData();
});
```

## Testing

```dart
test('user provider returns user', () async {
  final container = ProviderContainer();
  
  final user = await container.read(userProvider.future);
  
  expect(user.name, 'John');
});
```

## Resources

- [Riverpod Docs](https://riverpod.dev)
- [Riverpod GitHub](https://github.com/rrousselGit/riverpod)

---

**Master Riverpod to write scalable, testable Flutter apps!**
