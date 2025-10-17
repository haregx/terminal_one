# CHANGELOG

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).


## [Unreleased] - 2025-10-17

### Changed
- Translated all code comments from German to English in all main Dart files for consistency and maintainability.
- Ensured all user-facing strings in `home_screen_loggedin.dart` are fully internationalized and use translation keys.
- Improved translation consistency and informal address style in all supported languages (English, German, French, Spanish).
- Updated documentation and code comments to be fully in English across the codebase.
- Minor code cleanup and formatting in widgets and screens.

### Technical Improvements
- Improved code readability and maintainability by unifying comment language and translation usage.

---

## [Unreleased] - 2025-10-16

### Added
- Added `isSecondary` property to `PrimaryButton3D` widget. When set to true, the button uses the secondary color scheme from `button3d_secondary.dart` for unified button logic.
- Updated all usages of main action buttons to use the new `Button3D` widget with `isSecondary` where appropriate (e.g., login/signup navigation, home screen, promo code screen).
- Added full internationalization (i18n) support for all user-facing strings in the app, including error messages, navigation, and example screens.
- Added and completed translation files for French (`fr.json`) and Spanish (`es.json`).

### Changed
- Refactored `HomeScreen` and `PromoCodeScreen` to use `Button3D` for both primary and secondary actions, improving consistency and maintainability.
- Improved code structure and readability in `GlassCard` and `SimpleSwitchLeftWithText` widgets (formatting, adaptive switch usage, and minor cleanup).
- Updated English (`en.json`) and German (`de.json`) translation files with new keys for game screens, navigation examples, error routes, and more.
- Refactored all hardcoded UI strings to use translation keys and `.tr()` calls via `easy_localization`.
- Ensured language switching and initialization logic supports English, German, French, and Spanish throughout the app.
- Updated language selector in settings to include French and Spanish.
- Extracted quiz questions to a central data file (`questions.dart`).
- Improved privacy and policy screens to use translation keys for all labels and dates.
- Updated button and label logic in game and quiz screens for full localization.
- Updated all translation files for German (de.json), Spanish (es.json), and French (fr.json) to consistently use informal address (Du-Form / tuteo / tutoiement) throughout the app.
- Replaced all formal forms (Sie/vous/usted) with informal forms (du/tu/tú) in all user-facing strings, including navigation, authentication, settings, and help texts.
- Improved translation consistency and user experience for all supported languages by unifying the tone and addressing style.


### Fixed
- Fixed issues with code input clearing and button state updates in promo code and home screens.
- Fixed minor formatting and code style issues in several widgets.

### Technical Improvements
- Removed unused imports and legacy button widgets from affected screens.
- Improved widget property initialization and state handling for better reliability.

---

## [Unreleased] - 2025-10-15

### Changed
- All primary and secondary action buttons across the app now use new 3D-styled widgets (`PrimaryButton3D`, `SecondaryButton3D`) for a modern, consistent look and improved accessibility.
- Updated all screens and dialogs to replace legacy `PrimaryButton` and `SecondaryButton` usages with the new 3D button components, including login, registration, password reset, promo code, game, and profile flows.
- Improved button alignment and sizing by wrapping main action buttons in `IntrinsicWidth` for consistent minimum width.
- Updated quick actions and translations for more consistent terminology (e.g., "Promo-Code" → "Promocode").
- Changed app title to "Terminal.One" in `main.dart` for branding consistency.
- Updated web splash script version in `web/index.html` for cache busting.

### Added
- Added new `PrimaryButton3D` and `SecondaryButton3D` widgets for 3D-styled, platform-adaptive buttons with gradients, shadows, and icon support.
- Added all necessary imports and usages of the new button widgets throughout the codebase.

### Fixed
- Fixed minor translation inconsistencies in `de.json` and quick actions data (e.g., "Promo-Code" → "Promocode").
- Fixed button label and icon alignment issues in several screens.

## [Unreleased] - 2025-10-14

### Added
- Added `circular_seek_bar` dependency for circular progress/seek bar widgets.

- **New Input, Button, Switch, and Game UI Widgets**:
  - Added switch widgets: `SimpleSwitch` and `SimpleSwitchLeftWithText` for adaptive Material/Cupertino toggles with label support.
  - Added game UI widgets: `QuizButtonFlippable`, `QuizButtonsGroup`, `ClassicCircularProgress`, and `DotsProgressGroup` for quiz/game flows with animated progress and answer feedback.

### Technical Improvements
- Modularized and refactored input, button, switch, and game UI components for better maintainability and reusability.
- Improved accessibility, theming, and platform adaptation across new widgets.

---

## [Unreleased] - 2025-10-13

### Added
- **HTML Policy & Privacy Support**: Added support for rendering HTML-based policy and privacy screens
  - Added `flutter_html` dependency for HTML rendering in Flutter widgets
  - Introduced `PolicyScreen` for displaying policies using HTML
  - Refactored `PrivacyScreen` to use `flutter_html` and support bottom action buttons (Accept/Decline)
  - All usages of `PrivacyScreen` now pass the `showBottomButtons` parameter for consistent UX
  - Improved privacy policy acceptance flow: result of privacy screen updates acceptance state asynchronously

### Changed
- Changed registration API endpoint in `RegisterService` from `/Users/Register` to `/Users/Add`
- Explicitly added `android.permission.INTERNET` to `AndroidManifest.xml`
- Updated web splash script version in `web/index.html` for cache busting

### Added (Dependencies)
- Added new transitive dependency: `list_counter` (via pubspec.lock)

---

## [Unreleased] - 2025-10-11

### Added
- **Web iPhone Simulation with Live Status Bar**: Enhanced Web experience with iPhone DeviceFrame simulation
  - Live time display in status bar with second-by-second updates using StreamBuilder
  - WiFi and battery icons in status bar for authentic iPhone appearance  
  - System theme-aware status bar colors (white icons/text in dark mode, black in light mode)
  - Positioned overlay status bar that integrates seamlessly with DeviceFrame
  - MediaQuery.platformBrightnessOf() for accurate system theme detection outside Provider context

- **Performance Optimization Suite**: Comprehensive performance improvements across the application
  - OptimizedGlassCard with reduced blur operations and cached decorations
  - OptimizedSettingsTile with minimal rebuilds and cached theme lookups
  - Performance benchmark tests for measuring widget render times
  - Memory leak prevention through proper widget disposal

- **Enhanced Testing Infrastructure**: Comprehensive test coverage for new features
  - Widget tests for app initialization and component functionality
  - Performance benchmark tests comparing original vs optimized widgets
  - Animation performance validation with timing constraints
  - EasyLocalization integration testing

- **Game Flow Screens**: Introduced new screens for game details, game play, and game results, including navigation logic and UI stubs.

- **Promo Code Flow**: Updated promo code entry and verification to navigate to the new game details screen upon successful code entry.

- **More Games Screen Refactor**: Migrated the responsive grid and promo card logic to `more_games_screen.dart` for better modularity.

- **PlatformSwitch Widget**: Introduced a new adaptive switch widget that automatically uses Material Switch on Android and CupertinoSwitch on iOS/macOS. Used throughout the settings and theme toggle for a native look.

- **InputPasswordSimple & InputPasswordExtended**: Split password input into simple and extended variants for flexible validation and UI requirements.

### Changed
- **Responsive GridView for PromoCards**: Migrated from SingleChildScrollView/Wrap to a performant GridView with dynamic column count and configurable card width/height. Vertical spacing is now precisely controllable.
- **Configurable Card Height**: Card height in the grid is now fixed and can be easily adjusted (e.g., 190px).
- **Settings: Improved Language Initialization**: Language initialization in the settings is now safe and synchronized with the app locale.
- **UI Polish**: Optimized spacing, padding, and visual consistency in grid and settings screens.
- **Routing Refactor**: Updated all route imports and navigation logic to use the new modular screen files (e.g., `more_games_screen.dart`).
- **Fallback Locale**: Changed EasyLocalization fallback locale from German to English for better internationalization defaults.
- **Promo Data Cleanup**: Removed German comments and improved code clarity in promo data model.
- **UI Consistency**: Unified button and navigation logic in home and promo code screens for a consistent user experience.
- **Settings & Theme Toggle**: All switches in the settings and theme toggle now use the new PlatformSwitch for platform consistency.
- **Login & Register Screens**: Updated to use new password input components and improved internationalization for all labels and buttons.
- **Translation Files**: Added missing keys and improved English/German translation consistency for authentication and input flows.
- **Input Defaults**: Added simple password requirements for InputPasswordSimple.
- **PrivacySwitch**: Improved platform detection for iOS/macOS.

### Removed
- **Obsolete Files**: Deleted unused InputPassword and web_status_bar.dart files to clean up the codebase.

### Fixed
- **Translation Consistency**: Updated brand name consistency across all translations
  - Changed "Terminal One" to "Terminal.One" in German and English welcome messages
  - Updated "access code" to "promo code" terminology in English translations
  - Consistent brand representation across all user-facing text

- **GridView Spacing**: Vertical spacing between cards now matches the desired value exactly, with no extra space due to aspect ratio or padding issues.
- **Settings Language Switching**: Fixed a bug where the language was not correctly initialized or displayed.
- **Obsolete File Removal**: Deleted the old `more_games.dart` to avoid confusion and ensure only the new modular screen is used.
- **UI Consistency**: All authentication and settings screens now use the correct input and switch components for a unified look and feel.

### Enhanced
- **Web Platform Detection**: Improved Web vs Mobile platform handling
  - GlassmorphismScaffold now uses `kIsWeb` for platform-specific SafeArea behavior
  - Web platforms use `SafeArea(top: false)` while mobile uses `SafeArea(top: true)`
  - Removed duplicate import statements and cleaned up code structure

- **Settings Screen Redesign**: Logo animation and improved UX
  - Large logo in header area matching Home screen behavior
  - Logo migration to AppBar during scroll interaction
  - Removed Glass effects from informational header card
  - Improved visual hierarchy and user experience

- **Glass Morphism Effects**: Refined visual effects based on theme and functionality
  - Differentiated blur levels for Light/Dark themes
  - Removed misleading Glass effects from non-clickable cards
  - Enhanced visual feedback for interactive elements
  - Consistent Glass card usage patterns

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

- **Developer Experience**: Enhanced Debugging: Better development tools and feedback
  - Clear error messages for missing translation keys
  - Consistent logging for locale changes
  - Improved development workflow for adding new translations

---

## Previous Entries

### [1.0.0] - 2025-10-08
- **PromoCode Screen**: New dedicated promotional code entry interface
  - Responsive code input system with configurable length (default 8 characters)
  - Technical architecture documentation with code examples
  - Installation guides for all supported platforms
  - Customization instructions for themes and assets

  - Replaced direct widget navigation with named routes
  - Centralized route management in `lib/core/app_routes.dart`
  - Debug utilities with route listing and validation

  - Improved icon mappings and color schemes
  - Better integration with routing system
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
