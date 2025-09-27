import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:terminal_one/screens/home_screen.dart';
import 'l10n/app_localizations.dart';
import 'themes/app_theme.dart';
import 'providers/theme_provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final authProvider = AuthProvider();
  // Warten bis geladen
  while (!authProvider.isInitialized) {
    await Future.delayed(const Duration(milliseconds: 10));
  }
  authProvider.addListener(() {
    debugPrint(authProvider.isLoggedIn
      ? '✅ User is logged in.'
      : '🔒 No user logged in.');
  });
  debugPrint(authProvider.isLoggedIn
    ? '✅ User is logged in.'
    : '🔒 No user logged in.');
  runApp(
    ChangeNotifierProvider.value(
      value: authProvider,
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final ThemeProvider _themeProvider = ThemeProvider();

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _themeProvider,
      builder: (context, child) {
        return MaterialApp(
          title: 'Terminal One',
          
          // Theme configuration
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: _themeProvider.themeMode,
          
          // Localization configuration
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'), // English
            Locale('de'), // German
            Locale('fr'), // French
            Locale('it'), // Italian
            Locale('pt'), // Portuguese
            Locale('af'), // Afrikaans
          ],

          home: HomeScreen(themeProvider: _themeProvider),
        );
      },
    );
  }
}
