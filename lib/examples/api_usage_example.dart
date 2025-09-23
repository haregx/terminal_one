import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';
import '../services/api_exceptions.dart';

/// Beispiel-Service für API-Integration
/// 
/// Zeigt wie die ApiService-Klasse für spezifische API-Endpoints
/// verwendet werden kann. Dient als Template für eigene Services.
class ExampleApiUsage {
  final ApiService _api = ApiService();
  final AuthService _auth = AuthService();

  /// Initialisierung der API-Services
  /// 
  /// Diese Methode sollte beim App-Start aufgerufen werden
  Future<void> initializeApi() async {
    // API-Service konfigurieren
    _api.initialize(
      baseUrl: 'https://your-api.example.com/api/v1',
      timeout: const Duration(seconds: 30),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    // Gespeicherte User-Daten (UserGuid, etc.) laden
    await _auth.loadUserDataFromStorage();

    // Callback für automatischen Logout bei Auth-Fehlern
    _auth.onAuthenticationFailed = () {
      // Hier zur Login-Seite navigieren
      debugPrint('Authentication failed - redirecting to login');
    };
  }

  /// Beispiel: User-Login mit neuem System
  Future<void> performLogin(BuildContext context, String loginname, String password, String apiKey) async {
    try {
      final loginResult = await _auth.login(
  context: context,
  loginname: loginname,
  password: password,
  apiKey: apiKey,
      );
      
      debugPrint('Login successful: UserGuid=${loginResult.userGuid.substring(0, 10)}...');
      
      // Zusätzliche Login-Behandlung
      if (loginResult.isFirstLogin) {
        debugPrint('First login detected');
        // Hier zur Willkommens-Seite navigieren
      }
      
      if (loginResult.needsPasswordChange) {
        debugPrint('Password change required');
        // Hier zur Passwort-Ändern-Seite navigieren
      }
      
      if (loginResult.hasRestrictions) {
        debugPrint('Login successful but with restrictions');
      }
      
    } on ValidationException catch (e) {
      // Validation-Fehler anzeigen
      debugPrint('Validation errors: ${e.validationErrors}');
    } on AuthenticationException catch (e) {
      // Login-Fehler anzeigen
      debugPrint('Login failed: ${e.message}');
    } on NetworkException catch (e) {
      // Network-Fehler anzeigen
      debugPrint('Network error: ${e.message}');
    } catch (e) {
      debugPrint('Unexpected error: $e');
    }
  }


  /// Beispiel: Error-Handling in UI
  Future<T?> handleApiCall<T>(Future<T> Function() apiCall) async {
    try {
      return await apiCall();
    } on ValidationException catch (e) {
      // Validation-Fehler in UI anzeigen
      _showValidationErrors(e.validationErrors);
      return null;
    } on AuthenticationException {
      // Zur Login-Seite navigieren
      _redirectToLogin();
      return null;
    } on NetworkException catch (e) {
      // Network-Fehler anzeigen
      _showNetworkError(e.message);
      return null;
    } on ServerException catch (e) {
      // Server-Fehler anzeigen
      _showServerError(e.message);
      return null;
    } catch (e) {
      // Unbekannter Fehler
      _showUnknownError(e.toString());
      return null;
    }
  }

  // Helper-Methoden für UI-Feedback
  void _showValidationErrors(Map<String, List<String>>? errors) {
    debugPrint('Validation errors: $errors');
    // TODO: Hier UI-spezifische Error-Anzeige implementieren
  }

  void _redirectToLogin() {
    debugPrint('Redirecting to login...');
    // TODO: Hier Navigation zur Login-Seite implementieren
  }

  void _showNetworkError(String message) {
    debugPrint('Network error: $message');
    // TODO: Hier SnackBar oder Dialog anzeigen
  }

  void _showServerError(String message) {
    debugPrint('Server error: $message');
    // TODO: Hier SnackBar oder Dialog anzeigen
  }

  void _showUnknownError(String message) {
    debugPrint('Unknown error: $message');
    // TODO: Hier SnackBar oder Dialog anzeigen
  }
}

/// Helper-Klasse für paginierte Ergebnisse
class PaginatedResult<T> {
  final List<T> data;
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;

  const PaginatedResult({
    required this.data,
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });

  bool get hasNextPage => currentPage < lastPage;
  bool get hasPreviousPage => currentPage > 1;
  int get totalPages => lastPage;
}

// Verwende dart:io File für File-Upload
// Die lokale File-Klasse unten ist nur als Placeholder