# CHANGELOG

## [Unreleased] - 2025-10-06

### Added
- **Background System**: Implemented comprehensive background image system with `assets/background/backgound.png`
  - Created `AppBackground` widget for centralized background management
  - Theme-aware opacity (Light mode: 20%, Dark mode: 30%)
  - Enhanced Light mode with additional white overlay gradient for better readability
  - Background extends behind transparent AppBar for immersive experience

- **App Icon**: Generated app icons for all platforms using `flutter_launcher_icons`
  - Source: `assets/images/c2f.png`
  - iOS App Store compatible (alpha channel removed)
  - Generated for Android, iOS, Web, Windows, and macOS

- **Splash Screen**: Created native splash screen system using `flutter_native_splash`
  - Uses theme-matching button colors as background
  - Fullscreen image display with `c2f_fullscreen.png` (1024px)
  - Cross-platform support (Android, iOS, Web)
  - Automatic timing with app initialization

### Enhanced
- **GlassmorphismScaffold**: Major redesign for background integration
  - AppBar now fully transparent with `extendBodyBehindAppBar: true`
  - Background covers entire screen including AppBar area
  - Maintains proper text visibility with automatic foreground colors

- **SafeArea System**: Replaced `SafeArea` with custom `AppBarAwareSafeArea`
  - Accounts for transparent AppBar height (`kToolbarHeight`)
  - Consistent content positioning across all screens
  - Prevents content from hiding under transparent AppBar

- **Screen Layout Consistency**: Updated all screens for uniform spacing
  - `HomeScreen`: Updated to use `AppBarAwareSafeArea`
  - `LoginScreen`: Updated to use `AppBarAwareSafeArea`
  - `RegisterScreen`: Updated to use `AppBarAwareSafeArea`
  - `PincodeScreen`: Updated to use `AppBarAwareSafeArea`
  - `MoreGamesScreen`: Updated to use `AppBarAwareSafeArea`
  - `PasswordRequestScreen`: Fixed content positioning with `AppBarAwareSafeArea`
  - `PrivacyScreen`: Fixed content positioning with `AppBarAwareSafeArea`

- **Splash Screen Optimization**: Enhanced for better visual impact
  - Background colors now match theme primary button colors
  - Light mode: `#2196F3` (primary button blue)
  - Dark mode: `#90CAF9` (primary button blue for dark theme)
  - Image scaling: `scaleAspectFill` for fullscreen coverage
  - Enhanced image size: 1024px for crisp display on all devices

### Fixed
- **Content Positioning**: Resolved text starting too high on password request and privacy screens
- **Light Mode Optimization**: Improved background contrast in light mode with enhanced gradient overlay
- **Splash Screen Colors**: Updated from generic white/black to theme-matching button colors
- **Image Scaling**: Splash screen image now fills entire screen width instead of small centered display
- **Dependencies**: Moved `flutter_native_splash` from dev_dependencies to dependencies for runtime usage

### Technical Details
- **Assets Configuration**: Added `assets/images/` and `assets/background/` to pubspec.yaml
- **New Widgets**:
  - `AppBackground`: Centralized background management with theme awareness
  - `AppBarAwareSafeArea`: Custom SafeArea for transparent AppBar compatibility
- **Image Processing**: Used macOS `sips` tool to create multiple splash screen image sizes
  - `c2f_splash.png` (512px) - initial large version
  - `c2f_fullscreen.png` (1024px) - final fullscreen version
- **Package Integrations**:
  - `flutter_launcher_icons: ^0.13.1` for app icon generation
  - `flutter_native_splash: ^2.4.1` for splash screen implementation

### Splash Screen Configuration
```yaml
flutter_native_splash:
  image: assets/images/c2f_fullscreen.png
  color: "#2196F3"      # Light theme primary color
  color_dark: "#90CAF9" # Dark theme primary color
  android_gravity: fill
  ios_content_mode: scaleAspectFill
  web_image_mode: cover
  fullscreen: true
```

### Dependencies Added
```yaml
dependencies:
  flutter_native_splash: ^2.4.1

dev_dependencies:
  flutter_launcher_icons: ^0.13.1
```

---

## Previous Releases

## 2025-09-29
- PromoCodeCard: Redesigned the promo area at the bottom left as a red full circle, partially outside the card. Text position and layout repeatedly optimized.
- PromoCodeCard: Colors for light and dark mode adjusted (card background, gradient, circle, promo code container and text).
- PromoCodeCard: Promo code container is darker in dark mode and text is white for better readability.
- PromoCodeCard: Description text limited to max. 2 lines, with ellipsis for overflow.
- MoreGamesScreen: Cards are now scrollable, with SafeArea and consistent glassmorphism background.
- MoreGamesScreen: Multiple different imageUrls for the cards.
- Various UI fixes and fine-tuning for card layout, colors and text.

## 2025-09-27
- Changed the application ID everywhere in the project from `com.example.terminal_one` to `com.hareg.terminalone` for consistent identification, deployment, and branding across all platforms and configuration files.
- Added theme mode persistence: The app now saves and restores the selected theme (light, dark, or system) using SharedPreferences. If no theme is saved, the system theme is used by default.
- Added systemwide AuthProvider for persistent login state using flutter_secure_storage and Provider.
- Integrated AuthProvider in main.dart for global login status management and logging with emoji icons.
- LoginScreen now sets isLoggedIn to true after successful login (without restrictions).
- HomeScreen and SecondaryButton now show different text and icon depending on login status; if logged in, button navigates to MoreGamesScreen.
- Created MoreGamesScreen as a new stateful screen for promo games.
- Improved context safety after async calls in LoginScreen (mounted check).
- Various UI texts and icons now adapt to login status for better user experience.
- Added logout button to HomeScreen AppBar, visible only when user is logged in. Logout resets login state, shows a FancySuccessSnackbar, and navigates to LoginScreen.
- Added PrivacySwitch to PasswordRequestScreen. Users must accept the privacy policy to enable password reset requests. Tapping the label opens the PrivacyScreen for review.
- Improved privacy acceptance logic: Registration and password reset now require explicit privacy policy acceptance.
- Added PrivacySwitch to RegisterScreen. Users must accept the privacy policy to enable registration. Tapping the label opens the PrivacyScreen for review.
- Web view now uses DeviceFrame with iPhone 16 Pro size (430x932 px), scaled to 1.3x (559x1211 px) for desktop browsers only. On mobile browsers, the app displays natively without a device frame.
- WebStatusBar is used for the simulated status bar in web DeviceFrame mode; MinimalWebAppBar has been removed from all screens and codebase.
- All AppBars in GlassmorphismScaffold and relevant screens now use WebStatusBar for web, ensuring consistent appearance and correct Material context.
- Lucide icons import corrected to `lucide_icons` everywhere.
- General code cleanup: removed unused imports and obsolete files related to MinimalWebAppBar.
- Removed unused dev dependencies: `json_serializable` and `build_runner` from pubspec.yaml. These packages were not used for code generation or build processes in the current codebase.
- Refactored Provider structure: ThemeProvider and AuthProvider are now provided globally via MultiProvider in main.dart.
- Removed the themeProvider constructor parameter from HomeScreen and LoginScreen. ThemeProvider is now accessed via Provider.of<ThemeProvider>(context).
- This change ensures reliable theme switching and global state management.

## 2025-09-26
- ErrorCodes in `simple_https_post.dart` extended and consolidated: All relevant API error codes are now translated clearly and user-friendly.
- Confirmed: `lib/api_services/login.dart` is obsolete after migration to `LoginService` and can be deleted if present.
- Added `RegisterService` in `lib/api_services/register_service.dart` for modular user registration logic.
- Added `PasswordRequestService` in `lib/api_services/password_request_service.dart` for modular password reset logic.
- Removed obsolete `lib/api_services/login.dart` after migration to `LoginService`.
- Refactored login logic: migrated from callback-based function to LoginService class in `lib/api_services/login_service.dart`.
- Updated `LoginScreen` to use `LoginService` for authentication, improving modularity and testability.
- Fixed type safety in error handling for login result.
- Refactored login logic into login.dart for better separation of concerns
- Improved error handling and context management in login flow
- Added platform_utils.dart for platform detection and utilities
- Added platform_base_screen.dart and platform_screen_mixin.dart as templates for platform abstraction (currently not used in active code)
