import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:terminal_one/screens/home_screen.dart';
import 'l10n/app_localizations.dart';
import 'themes/app_theme.dart';
import 'providers/theme_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:device_frame/device_frame.dart';
import 'components/web_status_bar.dart';


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
    Widget app = ListenableBuilder(
      listenable: _themeProvider,
      builder: (context, child) {
        return MaterialApp(
          title: 'Terminal One',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: _themeProvider.themeMode,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('de'),
            Locale('fr'),
            Locale('it'),
            Locale('pt'),
            Locale('af'),
          ],
          home: HomeScreen(themeProvider: _themeProvider),
        );
      },
    );
    if (kIsWeb && (defaultTargetPlatform == TargetPlatform.macOS || defaultTargetPlatform == TargetPlatform.windows || defaultTargetPlatform == TargetPlatform.linux)) {
      return Directionality(
        textDirection: TextDirection.ltr,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 559, // 430 * 1.3
              maxHeight: 1211, // 932 * 1.3
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: DeviceFrame(
                device: Devices.ios.iPhone16Pro,
                screen: Column(
                  children: [
                    const WebStatusBar(),
                    Expanded(child: app),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return app;
    }
  }
}
