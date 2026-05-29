import 'package:barberto/services/auth/auth_manager.dart';
import 'package:provider/provider.dart' as provider;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../services/api_service_notifier.dart'; // Import AuthProvider
import '../theme/theme.dart';
import '../constants/routes.dart'; // Make sure this is correct
import 'providers/theme_notifier.dart';

Future<void> main() async {
  // Ensure Flutter is initialized before running the app
  WidgetsFlutterBinding.ensureInitialized();

  // Try to load .env file, but don't fail if it's not available (web deployment)
  try {
    await dotenv.load();
  } catch (e) {
    print('Warning: Could not load .env file: $e');
    // Continue execution - AppConstants will use fallback values
  }

  runApp(
    ProviderScope(
      child: provider.MultiProvider(
        providers: [
          provider.ChangeNotifierProvider<AuthProvider>(
            create: (context) =>
                AuthProvider(), // <-- Just create, no manual call
          ),
          provider.ChangeNotifierProvider<ApiServiceNotifier>(
            create: (context) => ApiServiceNotifier(),
          ),
        ],
        child: Consumer(
          builder: (context, ref, _) {
            final isDarkMode = ref.watch(isDarkModeProvider);
            return MaterialApp(
              title: 'Barberto',
              theme: lightMode,
              darkTheme: darkMode,
              themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
              debugShowCheckedModeBanner: false,
              onGenerateRoute: (settings) => AppRoutes.onGenerateRoute(settings,
                  provider.Provider.of<AuthProvider>(context, listen: false)),
              home: provider.Consumer<AuthProvider>(
                builder: (context, authProvider, _) =>
                    AuthManager(authProvider: authProvider),
              ),
            );
          },
        ),
      ),
    ),
  );
}
