
# Changelog
## [Unreleased] - 2025-09-26

- ErrorCodes in `simple_https_post.dart` extended and consolidated: All relevant API error codes are now translated clearly and user-friendly.
- Confirmed: `lib/api_services/login.dart` is obsolete after migration to `LoginService` and can be deleted if present.
- Added `RegisterService` in `lib/api_services/register_service.dart` for modular user registration logic.
- Added `PasswordRequestService` in `lib/api_services/password_request_service.dart` for modular password reset logic.
- Removed obsolete `lib/api_services/login.dart` after migration to `LoginService`.
## [Unreleased] - 2025-09-26
- Refactored login logic: migrated from callback-based function to LoginService class in `lib/api_services/login_service.dart`.
- Updated `LoginScreen` to use `LoginService` for authentication, improving modularity and testability.
- Fixed type safety in error handling for login result.
## [2025-09-26]
- Refactored login logic into login.dart for better separation of concerns
- Improved error handling and context management in login flow
## [2025-09-26]
- Added platform_utils.dart for platform detection and utilities
- Added platform_base_screen.dart and platform_screen_mixin.dart as templates for platform abstraction (currently not used in active code)
## [2025-09-26]
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
