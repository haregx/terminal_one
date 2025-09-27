# CHANGELOG

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

# Changelog: Web Compatibility & Password Request Refactoring

## Date: September 26, 2025

### Summary
- Password request screen now uses SimpleHttpsPost for API requests
- Improved error handling and logging for web and mobile/native
- Added support for HTTP status 405 (Method Not Allowed)
- Success and error snackbars for user feedback
- Web-specific error handling (CORS, network errors)

---

## Detailed Changes

### lib/screens/password_request_screen.dart
- Password reset now uses SimpleHttpsPost for API requests (web-compatible)
- Success snackbar (`FancySuccessSnackbar`) shown after successful password request
- Centralized error handling via `HttpsErrorHandler.handle(context, e)` for all API errors
- Navigation pops with email after success
- Old AuthService logic commented out
- Improved UI feedback and error logging for all platforms

### lib/services/simple_https_post.dart
- Logging: response status code is now always logged
- Error handling for web: `kIsWeb` checks for network errors as `ClientException` or "Failed to fetch"
- Error handling for mobile/desktop: catches `SocketException` and `TimeoutException`
- New exception class for HTTP 405: `SimpleHttpsPostMethodNotAllowedException`
- Exception classes are now correctly at top-level

### lib/components/snackbars/fancy_success_snackbar.dart
- Success snackbar for positive feedback

### web_entrypoint.dart
- Empty file for future web-specific logic

---

## Notes
- For web, the backend must be configured for CORS, otherwise requests are blocked or treated as 404/network errors
- The API should be prepared for the new error codes and methods

---

## Example Error Handling
```dart
try {
  var response = await SimpleHttpsPost.postJson(...);
  // Success
} catch (e) {
  HttpsErrorHandler.handle(context, e);
}
```

---

**Author:** Harry Reger
**Commit:** 2a9826912f1fed5fa34339b223d3cb2b189da38e
