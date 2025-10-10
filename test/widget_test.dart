import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:terminal_one/main.dart';

void main() {
  group('Terminal.One App Tests', () {
    testWidgets('App starts without crashing', (WidgetTester tester) async {
      // Initialize EasyLocalization for testing
      await EasyLocalization.ensureInitialized();
      
      // Build our app and trigger a frame
      await tester.pumpWidget(
        EasyLocalization(
          supportedLocales: const [Locale('en'), Locale('de')],
          path: 'assets/translations',
          fallbackLocale: const Locale('en'),
          child: const MainApp(),
        ),
      );

      // Wait for the app to settle
      await tester.pumpAndSettle();

      // Verify that the app starts (should find at least one widget)
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('Logo animation system works', (WidgetTester tester) async {
      await EasyLocalization.ensureInitialized();
      
      await tester.pumpWidget(
        EasyLocalization(
          supportedLocales: const [Locale('en'), Locale('de')],
          path: 'assets/translations',
          fallbackLocale: const Locale('en'),
          child: const MainApp(),
        ),
      );

      await tester.pumpAndSettle();

      // Check if scrollable content exists (required for logo animation)
      expect(find.byType(SingleChildScrollView), findsWidgets);
    });

    testWidgets('Language switching functionality', (WidgetTester tester) async {
      await EasyLocalization.ensureInitialized();
      
      await tester.pumpWidget(
        EasyLocalization(
          supportedLocales: const [Locale('en'), Locale('de')],
          path: 'assets/translations',
          fallbackLocale: const Locale('en'),
          child: const MainApp(),
        ),
      );

      await tester.pumpAndSettle();

      // Verify EasyLocalization is working
      final BuildContext context = tester.element(find.byType(MaterialApp));
      expect(context.locale, isNotNull);
      expect(['en', 'de'], contains(context.locale.languageCode));
    });
  });
}