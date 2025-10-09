# CHANGELOG

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased] - 2025-10-09

### Added
- **Complete Internationalization System**: Migrated from Flutter's built-in i18n to easy_localization
  - Comprehensive German and English translations for all UI components
  - JSON-based translation files in `assets/translations/`
  - Support for parametrized translations with named arguments
  - Runtime language switching capabilities
  - Fallback translation system for missing keys

- **Enhanced Dashboard Components**: Fully internationalized quick actions and statistics
  - Dynamic title/label localization in `QuickActionData` and `StatData` models
  - `getLocalizedTitle()` and `getLocalizedLabel()` methods for runtime translation
  - Backward compatibility with fallback titles/labels
  - Support for complex time-based translations (e.g., "Today at {time}", "Yesterday at {time}")

- **Modern Color API Migration**: Updated from deprecated `withOpacity` to `withAlpha`
  - Project-wide replacement of color opacity methods
  - Precise alpha value calculations (e.g., 0.6 opacity → 153 alpha)
  - Better performance and future compatibility
  - Consistent color handling across all components

### Enhanced
- **Profile Screen Internationalization**: Complete translation of user profile interface
  - All dialog titles, descriptions, and buttons translated
  - Dynamic content with parametrized translations (member since dates)
  - Proper German/English context switching
  - Internationalized dummy data for consistent testing

- **Settings Screen Localization**: Advanced hybrid translation system
  - Combination of easy_localization and manual locale detection
  - Reliable language/region selection interfaces
  - Theme and preference descriptions in both languages
  - Contextual help text and error messages

- **Dashboard Activity Feed**: Localized recent activities display
  - Time-relative translations ("Today at", "Yesterday at", "X days ago")
  - Activity type descriptions in both languages
  - Parametrized time formatting for different locales

### Migrated
- **Authentication Screens**: Converted from Flutter i18n to easy_localization
  - `register_screen.dart`: Registration form with translated labels and descriptions
  - `password_request_screen.dart`: Password reset interface with localized content
  - `pincode_screen.dart`: PIN entry screen with translated button labels
  - Removed dependencies on `AppLocalizations` class
  - Updated import statements to use easy_localization

### Removed
- **Legacy Internationalization System**: Cleaned up old Flutter i18n infrastructure
  - Deleted `lib/l10n/` directory and all ARB files
  - Removed `l10n.yaml` configuration file
  - Removed `generate: true` flag from `pubspec.yaml`
  - Eliminated `AppLocalizations` class dependencies
  - Streamlined translation architecture

### Fixed
- **Flutter 3.35.5 Compatibility**: Resolved API deprecation issues
  - Fixed `TextDirection.ltr` compilation error with proper `dart:ui` import
  - Updated color API usage throughout the codebase
  - Resolved widget parameter naming conflicts

- **Translation Key Coverage**: Comprehensive translation completeness
  - Added missing translation keys for all hardcoded strings
  - Fixed inconsistent key naming patterns
  - Resolved context-specific translation issues

### Technical Improvements
- **Code Architecture**: Enhanced maintainability and consistency
  - Unified translation approach across all screens
  - Consistent parameter naming and structure
  - Better separation of concerns between UI and localization
  - Improved error handling for missing translations

- **Performance Optimizations**: Reduced runtime overhead
  - Eliminated redundant translation lookups
  - Streamlined locale detection logic
  - Optimized widget rebuild cycles for locale changes

### Developer Experience
- **Enhanced Debugging**: Better development tools and feedback
  - Clear error messages for missing translation keys
  - Consistent logging for locale changes
  - Improved development workflow for adding new translations

---

## Previous Entries

### [1.0.0] - 2025-10-08

### Added
- **Centralized Routing System**: Implemented comprehensive route management architecture
  - New `AppRoutes` class with all route definitions as constants
  - Type-safe navigation with helper methods for common routes
  - Automatic route generation with argument handling
  - Error route for unknown paths with user-friendly fallback
  - Navigation examples and documentation for developers

- **PromoCode Screen**: New dedicated promotional code entry interface
  - Responsive code input system with configurable length (default 8 characters)
  - Real-time validation and completion detection
  - Demo codes integration (`WELCOME1`, `BONUS123`, `SPECIAL1`)
  - Loading states with processing indicators
  - Success/error feedback with animated snackbars
  - Help dialog explaining promotional code functionality
  - Smart navigation based on authentication status

- **Enhanced Documentation**: Comprehensive project documentation
  - Professional README.md with feature overview and setup instructions
  - Technical architecture documentation with code examples
  - Installation guides for all supported platforms
  - Customization instructions for themes and assets

### Enhanced
- **Navigation Architecture**: Complete overhaul of app routing system
  - Replaced direct widget navigation with named routes
  - Centralized route management in `lib/core/app_routes.dart`
  - Type-safe navigation helpers: `AppRoutes.navigateToLogin(context)`
  - Argument passing support for complex routes (PromoCode with custom length)
  - Debug utilities with route listing and validation

- **Quick Actions Data**: Improved dashboard action configuration
  - Enhanced action definitions with better categorization
  - Improved icon mappings and color schemes
  - Better integration with routing system

- **Widget System**: Refined component architecture
  - Enhanced `AppBarAwareSafeArea` for better layout consistency
  - Improved `SimpleDashboard` component with responsive design
  - Better integration between glass morphism effects and routing

### Fixed
- **Route Management**: Resolved navigation inconsistencies
  - Fixed direct widget imports in main.dart
  - Eliminated hard-coded navigation patterns
  - Improved error handling for unknown routes
  - Better argument validation and type safety

- **Layout Stability**: Enhanced visual consistency
  - Fixed context access issues in error routes
  - Improved button state management in PromoCode screen
  - Better loading state indicators with proper widget lifecycle

### Technical Improvements
- **Code Organization**: Better separation of concerns with dedicated routing layer
- **Type Safety**: Enhanced compile-time route validation
- **Maintainability**: Centralized navigation logic reduces code duplication
- **Developer Experience**: Clear navigation patterns with helper methods
- **Testing Support**: Route debugging utilities and comprehensive examples

### Developer Tools
- **Navigation Examples**: Created `lib/examples/navigation_examples.dart`
  - Demonstrates different navigation patterns
  - Shows argument passing techniques
  - Provides debugging utilities for route management
- **Route Constants**: All routes defined as typed constants
- **Helper Methods**: Simplified navigation API for common use cases

---

## [Previous] - 2025-10-08

### Added
- **Logout Screen**: New dedicated logout confirmation screen with modern glassmorphism design
  - Animated glass card interface with smooth transitions
  - Confirmation dialog with proper user feedback
  - Consistent theming with rest of the application

- **Advanced AppBar Animation System**: Implemented collapsing toolbar with logo transitions
  - Custom scroll-triggered logo animation (large → small)
  - Standard AppBar positioning with proper Safe Area handling
  - Smooth opacity transitions during scroll events
  - Prevents content overlay and scroll position jumping

- **Enhanced Glass Morphism Effects**: Comprehensive visual upgrade across all screens
  - AppBar with gradient glass effects and transparent borders
  - Background image support with proper asset management
  - Improved visual hierarchy with consistent transparency levels
  - Safe Area bottom padding for modern device compatibility

### Enhanced
- **Home Screen (Logged In)**: Complete redesign with modern UX patterns
  - Replaced SliverAppBar with stable scroll animation system
  - Fixed layout shifts that caused automatic scroll repositioning
  - Standard AppBar logo animation (appears at 100px scroll offset)
  - Glass morphism dashboard cards with improved visual feedback
  - Proper background image integration with Stack layout
  - Enhanced bottom safe area handling for all device types

- **Authentication System**: Improved login flow and error handling
  - Better API service integration for login/register workflows
  - Enhanced password request service functionality
  - Improved auth provider state management
  - Fixed null safety issues in authentication flows

- **Widget Architecture**: Major refactoring for better maintainability
  - New `AnimatedGlassCard` component for consistent glass effects
  - Enhanced `ScrollableDashboard` with better layout management
  - Improved theme synchronization across logged-in/logged-out states
  - Platform-specific widgets with responsive design patterns

### Fixed
- **Scroll Behavior**: Resolved automatic scroll position reset issues
  - Fixed AnimatedContainer height changes causing layout shifts
  - Stable scroll position maintenance during logo transitions
  - Eliminated unexpected scroll jumps during animations

- **Layout Consistency**: Standardized spacing and positioning
  - Fixed double Safe Area spacing issues
  - Corrected AppBar positioning with transparent backgrounds
  - Resolved content overlay problems with collapsing headers
  - Improved text overflow handling in dashboard cards

- **Background System**: Enhanced background image rendering
  - Fixed background visibility through transparent components
  - Improved gradient fallbacks when images are unavailable
  - Corrected asset path references for cross-platform compatibility

### Technical Improvements
- **Code Architecture**: Refactored screen components for better separation of concerns
- **Animation Performance**: Optimized scroll-triggered animations for 60fps performance
- **State Management**: Improved Provider synchronization between authentication states
- **Error Handling**: Enhanced debugging and error reporting in authentication flows

---

## [Previous] - 2025-10-06

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
