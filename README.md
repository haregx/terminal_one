# Terminal.One

A modern Flutter application with advanced glassmorphism UI design and seamless authentication workflows.

## 🚀 Features

### 🎨 Modern UI/UX Design
- **Glassmorphism Interface**: Beautiful glass-like components with transparency effects
- **Animated Logo Transitions**: Smooth collapsing toolbar with scroll-triggered logo animations
- **Responsive Layout**: Optimized for all screen sizes and orientations
- **Theme Support**: Light and dark mode with automatic system detection
- **Background System**: Dynamic background images with theme-aware opacity

### 🔐 Authentication System
- **Secure Login/Register**: Complete authentication flow with API integration
- **Password Recovery**: Dedicated password request functionality
- **Logout Confirmation**: Modern logout screen with user confirmation
- **State Management**: Robust authentication state handling with Provider pattern

### 📱 Cross-Platform Support
- **iOS**: Native design compliance with proper Safe Area handling
- **Android**: Material Design 3 integration
- **Web**: Responsive web interface
- **Desktop**: Windows and macOS support

### ⚡ Performance Features
- **60fps Animations**: Optimized scroll animations and transitions
- **Stable Scrolling**: Fixed layout shifts and position jumping
- **Efficient Rendering**: Background image caching and optimization
- **Memory Management**: Proper widget lifecycle management

## 🛠️ Technical Stack

### Core Technologies
- **Flutter**: Latest stable version with null safety
- **Dart**: Modern Dart language features
- **Provider**: State management solution
- **HTTP**: API communication and service integration

### Key Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.1
  lucide_icons: ^0.294.0
  http: ^1.1.2
```

### Development Tools
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
│   └── snackbars/       # Custom snackbar implementations
├── core/                # Core application logic
│   ├── platform_base_screen.dart
│   └── platform_screen_mixin.dart
├── providers/           # State management
│   ├── auth_provider.dart
│   └── theme_provider.dart
├── screens/             # Application screens
│   ├── auth/           # Authentication screens
│   └── home/           # Main application screens
├── widgets/            # Custom widgets
│   ├── dashboard/      # Dashboard components
│   └── glassmorphism_scaffold.dart
└── main.dart          # Application entry point
```

### Design Patterns
- **Provider Pattern**: For state management
- **Service Layer**: Separated API communication
- **Component Architecture**: Reusable UI components
- **Mixin Pattern**: Cross-cutting concerns

## 🎯 Key Components

### GlassmorphismScaffold
A custom scaffold with glassmorphism effects and transparent AppBar support.

### AnimatedGlassCard
Reusable glass card component with built-in animations and touch feedback.

### ScrollableDashboard
Advanced dashboard layout with grid-based component arrangement.

### AppLogo
Responsive logo component with multiple size variants and smooth transitions.

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)
- iOS development: Xcode and iOS Simulator
- Android development: Android Studio and Android SDK

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/haregx/terminal_one.git
   cd terminal_one
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate app icons** (optional)
   ```bash
   flutter pub run flutter_launcher_icons
   ```

4. **Generate splash screens** (optional)
   ```bash
   flutter pub run flutter_native_splash:create
   ```

5. **Run the application**
   ```bash
   flutter run
   ```

### Build for Production

**iOS:**
```bash
flutter build ios --release
```

**Android:**
```bash
flutter build apk --release
# or for app bundle:
flutter build appbundle --release
```

**Web:**
```bash
flutter build web --release
```

## 🎨 Customization

### Theming
The app supports comprehensive theming through the `ThemeProvider`:

```dart
// Toggle theme
Provider.of<ThemeProvider>(context).toggleTheme();

// Check current theme
bool isDark = Provider.of<ThemeProvider>(context).isDarkMode;
```

### Background Images
Place your background images in `assets/images/` and update the `AppBackground` widget configuration.

### Glass Effects
Customize glass morphism effects by modifying the `AnimatedGlassCard` widget parameters.

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
