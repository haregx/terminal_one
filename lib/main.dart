import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'themes/app_theme.dart';
import 'providers/theme_provider.dart';
import 'core/app_routes.dart';
import 'package:flutter/foundation.dart';
import 'package:device_frame/device_frame.dart';
import 'components/web_status_bar.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Easy Localization initialisieren
  await EasyLocalization.ensureInitialized();
  
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
    EasyLocalization(
      supportedLocales: const [
        Locale('de'),
        Locale('en'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('de'),
      startLocale: const Locale('de'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: authProvider),
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ],
        child: const MainApp(),
      ),
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
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        // Use centralized routing
        initialRoute: AppRoutes.home,
        onGenerateRoute: AppRoutes.generateRoute,
        // Remove explicit home parameter
      ),
    );
    if (kIsWeb && (defaultTargetPlatform == TargetPlatform.macOS || defaultTargetPlatform == TargetPlatform.windows || defaultTargetPlatform == TargetPlatform.linux)) {
      return Directionality(
        textDirection: ui.TextDirection.ltr,
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
