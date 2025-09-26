
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
- Switched password reset API request to SimpleHttpsPost
- Success snackbar on successful request (`FancySuccessSnackbar`)
- Centralized error handling with `HttpsErrorHandler.handle(context, e)`
- Navigation pop with email after successful request
- Old AuthService logic commented out

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
