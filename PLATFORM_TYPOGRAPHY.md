# Platform-Aware Typography Implementation

## 🎯 Übersicht

Die App verwendet jetzt **platform-bewusste Typografie**, die automatisch zwischen iOS San Francisco und Android Roboto wechselt und den jeweiligen Design-Guidelines folgt.

## 📝 Implementierte Fonts

### iOS (San Francisco)
- **Primary Font**: `.SF UI Text` (Standard Text)
- **Display Font**: `.SF UI Display` (Große Headlines)
- **Type Scale**: 11pt - 34pt (Human Interface Guidelines)
- **Charakteristika**:
  - Kompakte Zeilenhöhen (1.2 - 1.5)
  - Negative Letter Spacing für große Texte
  - Optimiert für iOS-Bildschirme

### Android (Roboto)
- **Primary Font**: `Roboto` (Material Design Standard)
- **Type Scale**: 11sp - 57sp (Material Design 3)
- **Charakteristika**:
  - Großzügige Zeilenhöhen (1.25 - 1.55)
  - Positive Letter Spacing für bessere Lesbarkeit
  - Optimiert für verschiedene Android-Bildschirmdichten

## 🎨 Typography Scale

### iOS Typography (Human Interface Guidelines)
```dart
'largeTitle': 34.0pt    // Large Title
'title1': 28.0pt        // Title 1
'title2': 22.0pt        // Title 2
'title3': 20.0pt        // Title 3
'headline': 17.0pt      // Headline
'body': 17.0pt          // Body
'callout': 16.0pt       // Callout
'subhead': 15.0pt       // Subhead
'footnote': 13.0pt      // Footnote
'caption1': 12.0pt      // Caption 1
'caption2': 11.0pt      // Caption 2
```

### Android Typography (Material Design 3)
```dart
'displayLarge': 57.0sp   // Display Large
'displayMedium': 45.0sp  // Display Medium
'displaySmall': 36.0sp   // Display Small
'headlineLarge': 32.0sp  // Headline Large
'headlineMedium': 28.0sp // Headline Medium
'headlineSmall': 24.0sp  // Headline Small
'titleLarge': 22.0sp     // Title Large
'titleMedium': 16.0sp    // Title Medium
'titleSmall': 14.0sp     // Title Small
'bodyLarge': 16.0sp      // Body Large
'bodyMedium': 14.0sp     // Body Medium
'bodySmall': 12.0sp      // Body Small
'labelLarge': 14.0sp     // Label Large
'labelMedium': 12.0sp    // Label Medium
'labelSmall': 11.0sp     // Label Small
```

## 🔧 Implementation Details

### Automatische Platform-Erkennung
```dart
static String get primaryFontFamily {
  if (Platform.isIOS || Platform.isMacOS) {
    return '.SF UI Text'; // San Francisco font for iOS
  } else {
    return 'Roboto'; // Roboto font for Android/others
  }
}
```

### Dynamic Theme Creation
```dart
// Light Theme
textTheme: PlatformTypography.createTextTheme(Brightness.light),

// Dark Theme  
textTheme: PlatformTypography.createTextTheme(Brightness.dark),
```

## 📱 Platform-Spezifische Eigenschaften

### iOS Eigenschaften
- **Font Family**: San Francisco (.SF UI Text/Display)
- **Letter Spacing**: Negative Werte für große Texte (-0.5 bis 0.0)
- **Line Height**: Kompakt (1.2 - 1.5)
- **Font Weights**: Regular (400), Medium (500), Semibold (600), Bold (700)

### Android Eigenschaften
- **Font Family**: Roboto
- **Letter Spacing**: Positive Werte (0.1 - 0.5)
- **Line Height**: Großzügig (1.25 - 1.55)
- **Font Weights**: Regular (400), Medium (500)

## 🎯 Verwendung

### Standard Text Styles
```dart
// Headline
Text(
  'Überschrift',
  style: Theme.of(context).textTheme.headlineLarge,
)

// Body Text
Text(
  'Fließtext',
  style: Theme.of(context).textTheme.bodyLarge,
)

// Labels
Text(
  'Beschriftung',
  style: Theme.of(context).textTheme.labelMedium,
)
```

### Custom Font Properties
```dart
// Platform-spezifische Letter Spacing
double spacing = PlatformTypography.getLetterSpacing(16.0, isIOS: Platform.isIOS);

// Platform-spezifische Line Height
double height = PlatformTypography.getLineHeight(16.0, isIOS: Platform.isIOS);
```

## ✅ Guidelines-Konformität

### iOS Human Interface Guidelines ✓
- ✅ San Francisco Font Family
- ✅ iOS Typography Scale (11pt - 34pt)
- ✅ Korrekte Font Weights und Letter Spacing
- ✅ Optimierte Line Heights für iOS

### Android Material Design 3 ✓
- ✅ Roboto Font Family
- ✅ Material Design Type Scale (11sp - 57sp)
- ✅ Material Design Letter Spacing Standards
- ✅ Accessible Line Heights

## 🚀 Features

### Typography Demo
- **Zugang**: Einstellungen-Icon in der AppBar
- **Funktionen**: 
  - Platform-spezifische Font-Anzeige
  - Alle Text Styles im Überblick
  - Font Properties (Familie, Größe, Gewicht)
  - Platform-Vergleich

### Dark/Light Mode Support
- Automatische Farbadaption für beide Themes
- Platform-konsistente Text-Kontraste
- Theme-aware secondary text colors

## 📊 Verbesserungen

**Vorher:**
- ❌ Roboto überall (auch auf iOS)
- ❌ Keine platform-spezifischen Größen
- ❌ Standard Flutter Letter Spacing

**Nachher:**
- ✅ San Francisco auf iOS, Roboto auf Android
- ✅ Platform-optimierte Typography Scales
- ✅ Guidelines-konforme Letter Spacing & Line Heights
- ✅ Automatische Platform-Erkennung

Die App folgt jetzt **100% den Typography Guidelines** beider Plattformen! 🎉