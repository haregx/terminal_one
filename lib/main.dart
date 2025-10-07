import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:terminal_one/screens/home/home_screen_router.dart';
import 'l10n/app_localizations.dart';
import 'themes/app_theme.dart';
import 'providers/theme_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:device_frame/device_frame.dart';
import 'components/web_status_bar.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Splash Screen beibehalten bis App fertig geladen ist
  FlutterNativeSplash.preserve(widgetsBinding: WidgetsFlutterBinding.ensureInitialized());
  
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
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: authProvider),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
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
  // ThemeProvider wird jetzt über Provider bereitgestellt
  
  @override
  void initState() {
    super.initState();
    
    // Status Bar Einstellungen aktivieren
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.top,
      SystemUiOverlay.bottom,
    ]);
    
    // Splash Screen entfernen sobald die App bereit ist
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FlutterNativeSplash.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    Widget app = AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light, // Immer weiße Icons
        statusBarBrightness: Brightness.dark, // iOS
        systemNavigationBarColor: Colors.transparent,
      ),
      child: MaterialApp(
        title: 'Terminal One',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeProvider.themeMode,
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
        home: const HomeScreenRouter(),
      ),
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
