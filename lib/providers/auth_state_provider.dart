import 'package:flutter/foundation.dart';
import '../services/auth_service.dart';

/// AuthStateNotifier - Verwaltet den globalen Anmeldestatus
/// 
/// Ermöglicht es Widgets, auf Änderungen des Anmeldestatus zu reagieren
class AuthStateNotifier extends ChangeNotifier {
  final AuthService _authService = AuthService();
  bool _isLoggedIn = false;
  bool _isInitialized = false;

  bool get isLoggedIn => _isLoggedIn;
  bool get isInitialized => _isInitialized;

  /// Singleton-Pattern
  static final AuthStateNotifier _instance = AuthStateNotifier._internal();
  factory AuthStateNotifier() => _instance;
  AuthStateNotifier._internal();

  /// Initialisierung - lädt gespeicherte User-Daten
  Future<void> initialize() async {
    if (_isInitialized) return;
    
    await _authService.loadUserDataFromStorage();
    _isLoggedIn = _authService.isLoggedIn;
    _isInitialized = true;
    
    debugPrint('AuthStateNotifier initialized. IsLoggedIn: $_isLoggedIn');
    notifyListeners();
  }

  /// Login-Status aktualisieren
  void updateLoginStatus(bool isLoggedIn) {
    if (_isLoggedIn != isLoggedIn) {
      _isLoggedIn = isLoggedIn;
      debugPrint('AuthStateNotifier: Login status changed to $_isLoggedIn');
      notifyListeners();
    }
  }

  /// Nach erfolgreichem Login aufrufen
  void onLoginSuccess() {
    updateLoginStatus(true);
  }

  /// Nach Logout aufrufen
  void onLogout() {
    updateLoginStatus(false);
  }
}