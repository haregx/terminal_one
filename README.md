# Terminal.One


A modern Flutter application featuring advanced glassmorphism UI design, comprehensive internationalization, and seamless cross-platform functionality.

## ✨ Key Features

### � Modern UI/UX Design
- **Logo Animation System**: Dynamic logo behavior with smooth scroll-based transitions
  - Logo displays in content header and migrates to AppBar when scrolling
  - ValueNotifier-based implementation for optimal performance (50px scroll threshold)
  - Consistent animation behavior across Home and Settings screens
- **Glassmorphism Interface**: Beautiful glass-like components with optimized transparency effects
  - Theme-aware blur effects: Light mode (8 sigma), Dark mode (15 sigma)
  - Removed Glass effects from non-interactive informational cards
  - Enhanced visual feedback for interactive elements
- **Animated Dashboard**: Interactive quick actions and statistics with smooth transitions
- **Responsive Layout**: Optimized for all screen sizes from mobile to desktop
- **Theme System**: Comprehensive light/dark mode with automatic system detection
- **Background Integration**: Dynamic background images with theme-aware opacity

### 🌍 Complete Internationalization
- **Enhanced Language Switching**: Real-time toggle between German and English
  - Modal bottom sheet selection interface with EasyLocalization integration
  - Success confirmation with localized messages and persistent storage
  - Proper initialization handling for Widget lifecycle safety
- **Easy Localization**: JSON-based translation system with parametrized messages
- **Contextual Translation**: Smart locale detection with fallback mechanisms
- **Dynamic Content**: Time-based and user-specific localized content

### 🔐 Authentication & User Management
- **Secure Authentication**: Complete login/register flow with API integration
- **Profile Management**: Internationalized user profile with customizable settings
- **Password Recovery**: Dedicated password reset functionality
- **Enhanced Settings Screen**: Logo animation and improved UX
  - Large logo in header area matching Home screen behavior
  - Removed Glass effects from informational header sections
  - Improved visual hierarchy and user experience
- **State Persistence**: Robust authentication state with secure storage

### 📱 Cross-Platform Excellence
- **Native Performance**: 60fps animations and optimized rendering across platforms
- **Platform Compliance**: iOS design guidelines and Material Design 3 integration
- **Responsive Web**: Full-featured web application with touch and desktop support
- **Desktop Ready**: Windows and macOS native applications with proper window management

### 🚀 Performance & Architecture
- **Performance Optimizations**: Enhanced widget caching and reduced rebuilds
  - Performance monitoring tools and analyzers
  - Optimized Glass morphism effects and blur calculations
  - Fixed EasyLocalization initialization and dependency errors
- **Modern Color API**: Updated to latest Flutter color system (withAlpha)
- **Efficient State Management**: Provider-based architecture with optimized rebuilds
- **Memory Optimization**: Smart widget lifecycle and resource management
- **Error Handling**: Comprehensive error boundaries and user feedback systems

## 🛠️ Technical Stack

### Core Framework
- **Flutter 3.35.5**: Latest stable with null safety and modern APIs
- **Dart 3.5.0**: Advanced language features and performance optimizations
- **Easy Localization 3.0.7**: Comprehensive internationalization system

### Key Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  easy_localization: ^3.0.7
  provider: ^6.1.1
  lucide_icons: ^0.294.0
  http: ^1.1.2
  flutter_secure_storage: ^9.2.2
  shared_preferences: ^2.2.2

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
  flutter_launcher_icons: ^0.13.1
  flutter_native_splash: ^2.4.1
```
- **flutter_launcher_icons**: App icon generation
- **flutter_native_splash**: Native splash screen creation
- **Analysis Options**: Strict linting and code quality

## 🏗️ Architecture

### Project Structure
```
lib/
├── api_services/          # API communication layer
│   ├── auth/             # Authentication services
│   └── https_post_service.dart
├── components/           # Reusable UI components
│   ├── buttons/         # Custom button components
│   ├── inputs/          # Form input components
│   └── snackbars/       # Custom snackbar implementations
├── core/                # Core application logic
│   ├── app_routes.dart  # Centralized routing system
│   └── platform_*.dart  # Platform abstraction
├── data/                # Data models and providers
│   ├── quick_actions_data.dart  # Dashboard actions
│   └── stats_data.dart         # Statistics data
├── providers/           # State management
│   ├── auth_provider.dart
│   └── theme_provider.dart
├── screens/             # Application screens
│   ├── auth/           # Authentication screens
│   ├── common/         # Shared screens (settings, etc.)
│   └── home/           # Main application screens
├── themes/             # Theme definitions
├── utils/              # Utility functions
├── widgets/            # Custom widgets
│   ├── dashboard/      # Dashboard components
│   └── glassmorphism_scaffold.dart
└── main.dart          # Application entry point
```

### Internationalization Structure
```
assets/
├── translations/
│   ├── de.json         # German translations
│   └── en.json         # English translations
├── background/         # Background images
└── images/            # App assets
```

### Design Patterns
- **Provider Pattern**: Global state management with reactive updates
- **Repository Pattern**: Clean API service architecture
- **Localization Pattern**: Easy Localization with JSON-based translations
- **Service Layer**: Clean API communication architecture
- **Component Architecture**: Reusable, composable UI components
- **Mixin Pattern**: Cross-cutting concerns and shared functionality

## 🎯 Key Components

### Core UI Components

**Logo Animation System**
- Dynamic logo behavior with smooth scroll-based transitions
- Logo appears in content header and migrates to AppBar (50px threshold)
- ValueNotifier-based implementation for optimal performance
- Consistent animation across Home and Settings screens
- 300ms animation duration with ScrollController integration

**GlassmorphismScaffold**
- Custom scaffold with optimized glassmorphism effects
- Theme-aware blur: Light mode (8 sigma), Dark mode (15 sigma)
- Transparent AppBar with automatic background handling
- Removed Glass effects from non-interactive informational cards

**Enhanced Settings Screen**
- Logo animation system matching Home screen behavior
- Improved visual hierarchy and user experience
- Real-time language switching with modal selection interface
- EasyLocalization integration with persistent storage

**SimpleDashboard**
- Internationalized dashboard with quick actions
- Responsive grid layout for different screen sizes
- Real-time statistics and activity feed

**ThemeToggle**
- Advanced theme switching (Light/Dark/System)
- Persistent theme preferences with SharedPreferences
- Smooth transitions between theme modes

### Internationalization Components

**Enhanced Language Switching**
- Real-time toggle between German and English languages
- Modal bottom sheet selection with success confirmation
- EasyLocalization integration with `context.setLocale()`
- Safe Widget lifecycle initialization for dependency handling

**Easy Localization Integration**
- Runtime language switching with persistent storage
- Parametrized translations with named arguments
- Context-aware fallback system for missing keys

**Localized Data Models**
- `QuickActionData` with `getLocalizedTitle()` method
- `StatData` with `getLocalizedLabel()` method (fixed API)
- Backward compatibility with fallback text

### Advanced Features

**Performance Optimizations**
- Fixed EasyLocalization initialization and dependency errors
- Enhanced widget caching and reduced rebuilds
- Performance monitoring tools and analyzers
- Optimized Glass morphism calculations

**Responsive Code Input**
- Configurable length PIN/code entry system
- Real-time validation and completion detection
- Platform-specific input handling

**Glass Card System**
- Consistent glass morphism across all components
- Animated transitions with delay support
- Touch feedback and hover states

## 🚀 Getting Started

### Prerequisites
- **Flutter SDK**: 3.35.5 or higher
- **Dart SDK**: 3.5.0 or higher
- **iOS Development**: Xcode 15+ and iOS Simulator
- **Android Development**: Android Studio with Android SDK 21+

### Quick Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/haregx/terminal_one.git
   cd terminal_one
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Set up translations** (Easy Localization)
   ```bash
   # Translations are automatically loaded from assets/translations/
   # No additional setup required - JSON files are included
   ```

4. **Generate app icons** (optional)
   ```bash
   flutter pub run flutter_launcher_icons
   ```

5. **Generate splash screens** (optional)
   ```bash
   flutter pub run flutter_native_splash:create
   ```

6. **Run the application**
   ```bash
   flutter run
   ```

### Platform-Specific Setup

**iOS Setup**
```bash
cd ios
pod install
cd ..
flutter run -d ios
```

**Android Setup**
```bash
flutter run -d android
```

**Web Setup**
```bash
flutter run -d web-server --web-port 8080
```

### Build for Production

**iOS Release:**
```bash
flutter build ios --release
open ios/Runner.xcworkspace
# Use Xcode to archive and distribute
```

**Android APK:**
```bash
flutter build apk --release --split-per-abi
```

**Android App Bundle:**
```bash
flutter build appbundle --release
```

**Web Production:**
```bash
flutter build web --release --web-renderer canvaskit
```

**Desktop (macOS):**
```bash
flutter build macos --release
```

**Desktop (Windows):**
```bash
flutter build windows --release
```

## � Internationalization

### Adding New Languages

1. **Create translation file**
   ```bash
   # Add new file: assets/translations/fr.json
   ```

2. **Update main.dart**
   ```dart
   return EasyLocalization(
     supportedLocales: [
       Locale('en'),
       Locale('de'), 
       Locale('fr'), // Add new locale
     ],
     // ...
   );
   ```

3. **Add translations**
   ```json
   {
     "common": {
       "ok": "D'accord",
       "cancel": "Annuler"
     }
   }
   ```

### Translation Usage
```dart
// Simple translation
Text('common.ok'.tr())

// Parametrized translation
Text('profile.member_since'.tr(namedArgs: {'year': '2025'}))

// Fallback with manual locale detection
Text(context.locale.languageCode == 'de' ? 'Deutsch' : 'English')
```

## 🎨 Customization

### Theme System
The app features a comprehensive theme system with persistent preferences:

```dart
// Set specific theme mode
themeProvider.setThemeMode(ThemeMode.dark);

// Toggle between light and dark
themeProvider.toggleTheme();

// Check current theme
bool isDark = Theme.of(context).brightness == Brightness.dark;

// Use theme-aware colors
color: isDark ? Colors.white.withAlpha(230) : Colors.black.withAlpha(230)
```

### Glass Morphism Customization
```dart
GlassCard(
  delay: Duration(milliseconds: 200),
  padding: EdgeInsets.all(16),
  child: YourContent(),
)
```

### Dashboard Customization
Add new quick actions or statistics:

```dart
// In quick_actions_data.dart
QuickActionData(
  id: 'custom_action',
  title: 'Custom Action',
  titleKey: 'quick_actions.custom_action', // For i18n
  icon: LucideIcons.customIcon,
  color: Color(0xFF6366F1),
  route: '/custom-route',
)

// In stats_data.dart  
StatData(
  id: 'custom_stat',
  value: '100%',
  label: 'Custom Stat',
  labelKey: 'stats.custom_stat', // For i18n
  icon: LucideIcons.customIcon,
  color: Color(0xFF10B981),
)
```

### Background Images
Place your background images in `assets/background/` and reference them in the `AppBackground` widget:

```dart
AppBackground(
  imagePath: 'assets/background/your_background.png',
  lightModeOpacity: 0.2,
  darkModeOpacity: 0.3,
)
```

## 🧪 Testing

### Run Tests
```bash
flutter test
```

### Integration Tests
```bash
flutter test integration_test/
```

### Code Analysis
```bash
flutter analyze
```

## 📝 Development Guidelines

### Code Style
- Follow Dart/Flutter style guidelines
- Use descriptive variable and function names
- Add documentation comments for public APIs
- Implement proper error handling

### Internationalization Best Practices
- Always use translation keys instead of hardcoded strings
- Use parametrized translations for dynamic content
- Provide fallback text for missing translations
- Test with different locales during development

### Performance Considerations
- Use `const` constructors where possible
- Implement proper widget keys for list items
- Avoid rebuilding expensive widgets unnecessarily
- Use `ListView.builder` for long lists

## 🤝 Contributing

1. **Fork the repository**
2. **Create your feature branch**
   ```bash
   git checkout -b feature/amazing-feature
   ```
3. **Commit your changes**
   ```bash
   git commit -m 'Add some amazing feature'
   ```
4. **Push to the branch**
   ```bash
   git push origin feature/amazing-feature
   ```
5. **Open a Pull Request**

### Development Setup
```bash
# Install dependencies
flutter pub get

# Run code generation (if needed)
flutter packages pub run build_runner build

# Run tests
flutter test

# Check code quality
flutter analyze
```

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📞 Support

- **Issues**: [GitHub Issues](https://github.com/haregx/terminal_one/issues)
- **Documentation**: See the `/docs` folder for detailed documentation
- **Discord**: Join our community server for discussions

## 🙏 Acknowledgments

- **Flutter Team**: For the amazing framework
- **Easy Localization**: For the excellent internationalization package
- **Lucide Icons**: For the beautiful icon set
- **Community**: All contributors and testers who made this project better

---

**Built with ❤️ using Flutter**

## 📱 Screenshots

| Login Screen | Dashboard | Theme Toggle |
|--------------|-----------|--------------|
| Modern login interface | Glassmorphism dashboard | Light/Dark modes |

## 🔧 Configuration

### API Configuration
Update API endpoints in `lib/api_services/` files to connect to your backend services.

### Asset Configuration
Add your assets in `pubspec.yaml`:

```yaml
flutter:
  assets:
    - assets/images/
    - assets/background/
```

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Lucide Icons for beautiful iconography
- Community contributors and testers

## 📞 Support

For support and questions:
- Create an issue on GitHub
- Contact: [your-email@example.com]

---

**Built with ❤️ using Flutter**
