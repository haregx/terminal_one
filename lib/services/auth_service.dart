import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/login_request.dart';
import '../models/login_result.dart';
import '../models/register_request.dart';
import '../models/register_result.dart';
import '../models/password_request.dart';
import '../models/api_result.dart';
import '../config/api_config.dart';
import 'api_service.dart';
import 'api_exceptions.dart';

/// Authentication-Service für Token-Management und Auth-Workflows
/// 
/// Verwaltet:
/// - Login/Logout-Funktionalität
/// - 96-Zeichen UserGuid Token-Storage
/// - User-Session-Management
/// - API-Key Management
class AuthService {
  /// Passwort-Anfrage (Mail-Versand)
  Future<ApiResult> passwordRequest({
    required BuildContext context,
    required String loginname,
    required String apiKey,
    int? vendor,
    }) async {
    try {
      final request = PasswordRequest.create(
        loginname: loginname,
        apiKey: apiKey,
        vendor: vendor,
      );
      final response = await _apiService.post<Map<String, dynamic>>(
  ApiConfig.passwordRequestEndpoint,
  data: request.toJson(),
  context: context,
      );
      final result = ApiResult.fromJson(response);
      debugPrint('PasswordRequest result: Code=${result.code}, Message=${result.errorMessage}');
      return result;
    } catch (e) {
      debugPrint('PasswordRequest failed: $e');
      rethrow;
    }
  }
  final ApiService _apiService;
  
  // SecureStorage für sichere Token-Speicherung
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );
  
  // Storage Keys
  static const String _userGuidKey = 'user_guid';
  static const String _pubGuidKey = 'pub_guid';
  static const String _apiKeyKey = 'api_key';
  static const String _userRightIdKey = 'user_right_id';
  
  String? _userGuid; // Der 96-Zeichen Token
  String? _pubGuid;
  String? _apiKey;
  int? _userRightId;
  
  /// Callback für automatischen Logout bei Token-Problemen
  void Function()? onAuthenticationFailed;
  
  /// Singleton-Pattern
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal() : _apiService = ApiService();
  // API Service wird bereits in main.dart initialisiert

  /// Aktueller UserGuid (96-Zeichen Token)
  String? get userGuid => _userGuid;
  
  /// Aktueller PubGuid
  String? get pubGuid => _pubGuid;
  
  /// Aktueller API-Key
  String? get apiKey => _apiKey;
  
  /// User Rights ID
  int? get userRightId => _userRightId;
  
  /// Prüft ob User eingeloggt ist
  bool get isLoggedIn => _userGuid != null && _apiKey != null;

  /// Login mit Loginname und Passwort
  Future<LoginResult> login({
    required BuildContext context,
    required String loginname,
    required String password,
    required String apiKey,
    int? vendor,
    }) async {
    try {
      // Login Request erstellen
      final loginRequest = LoginRequest.create(
        loginname: loginname,
        password: password,
        apiKey: apiKey,
        vendor: vendor,
      );

      // API-Call durchführen
      final response = await _apiService.post<Map<String, dynamic>>(
  ApiConfig.loginEndpoint,
  data: loginRequest.toJson(),
  context: context,
      );

      // LoginResult aus Response erstellen
      final loginResult = LoginResult.fromJson(response);

      // Prüfen ob Login erfolgreich war
      if (loginResult.isSuccessfulLogin) {
        // Token und User-Daten speichern
        await _setUserData(
          userGuid: loginResult.userGuid,
          pubGuid: loginResult.pubGuid,
          apiKey: apiKey,
          userRightId: loginResult.userRightId,
        );

        // API-Service mit Token konfigurieren
        _apiService.setAuthToken(loginResult.userGuid);
        
        debugPrint('Login successful: UserGuid=${loginResult.userGuid.substring(0, 10)}...');
      } else {
        // Login fehlgeschlagen
        throw AuthenticationException(loginResult.errorMessage);
      }

      return loginResult;
    } catch (e) {
      debugPrint('Login failed: $e');
      if (e is! AuthenticationException) {
        throw AuthenticationException('Login failed: ${e.toString()}');
      }
      rethrow;
    }
  }

  /// Registrierung neuer User
  Future<RegisterResult> register({
    required BuildContext context,
    required String loginname,
    required String emailAddress,
    required String password,
    required String apiKey,
    int? vendor,
    }) async {
    try {
      // Register Request erstellen
      final registerRequest = RegisterRequest.create(
        loginname: loginname,
        emailAddress: emailAddress,
        password: password,
        apiKey: apiKey,
        vendor: vendor,
      );

      // API-Call durchführen
      final response = await _apiService.post<Map<String, dynamic>>(
  ApiConfig.registerEndpoint, // TODO: Endpoint in Config hinzufügen
  data: registerRequest.toJson(),
  context: context,
      );

      // RegisterResult aus Response erstellen
      final registerResult = RegisterResult.fromJson(response);

      // Prüfen ob Registrierung erfolgreich war
      if (registerResult.isSuccessfulRegister) {
        debugPrint('Registration successful: PubGuid=${registerResult.pubGuid}');
        
        // TODO: Automatisches Login nach Registration?
        // await _setUserData(...) falls gewünscht
      } else {
        // Registrierung fehlgeschlagen
        throw AuthenticationException(registerResult.errorMessage);
      }

      return registerResult;
    } catch (e) {
      debugPrint('Registration failed: $e');
      if (e is! AuthenticationException) {
        throw AuthenticationException('Registration failed: ${e.toString()}');
      }
      rethrow;
    }
  }

  /// User-Daten setzen und speichern
  Future<void> _setUserData({
    required String userGuid,
    required String pubGuid,
    required String apiKey,
    required int userRightId,
  }) async {
    _userGuid = userGuid;
    _pubGuid = pubGuid;
    _apiKey = apiKey;
    _userRightId = userRightId;

    // User-Daten persistent speichern
    await _saveUserDataToStorage();
  }

  /// User-Daten persistent speichern
  Future<void> _saveUserDataToStorage() async {
    try {
      if (_userGuid != null) {
        await _storage.write(key: _userGuidKey, value: _userGuid!);
        debugPrint('Saved UserGuid to secure storage: ${_userGuid!.substring(0, 10)}...');
      }
      
      if (_pubGuid != null) {
        await _storage.write(key: _pubGuidKey, value: _pubGuid!);
        debugPrint('Saved PubGuid to secure storage');
      }
      
      if (_apiKey != null) {
        await _storage.write(key: _apiKeyKey, value: _apiKey!);
        debugPrint('Saved API-Key to secure storage');
      }
      
      if (_userRightId != null) {
        await _storage.write(key: _userRightIdKey, value: _userRightId.toString());
        debugPrint('Saved UserRightId to secure storage: $_userRightId');
      }
    } catch (e) {
      debugPrint('Failed to save user data to secure storage: $e');
    }
  }

  /// User-Daten aus gespeicherten Daten laden (SecureStorage)
  Future<void> loadUserDataFromStorage() async {
    try {
      _userGuid = await _storage.read(key: _userGuidKey);
      _pubGuid = await _storage.read(key: _pubGuidKey);
      _apiKey = await _storage.read(key: _apiKeyKey);
      
      final userRightIdString = await _storage.read(key: _userRightIdKey);
      if (userRightIdString != null) {
        _userRightId = int.tryParse(userRightIdString);
      }
      
      debugPrint('🔐 Loaded from storage: UserGuid=${_userGuid != null ? _userGuid!.substring(0, 10) + "..." : "null"}, ApiKey=${_apiKey != null ? "present" : "null"}');
      
      // Wenn UserGuid vorhanden, im ApiService setzen
      if (_userGuid != null) {
        _apiService.setAuthToken(_userGuid!);
        debugPrint('✅ User is logged in from storage');
      } else {
        debugPrint('❌ No user data in storage - user not logged in');
      }
    } catch (e) {
      debugPrint('Failed to load user data from secure storage: $e');
      // Bei Fehlern alle Daten löschen
      await _clearUserDataFromStorage();
    }
  }

  /// Logout und User-Daten löschen
  Future<void> logout() async {
    try {
      // Server-seitiges Logout (falls erforderlich)
      if (_userGuid != null && _apiKey != null) {
        // TODO: Logout-API-Call implementieren wenn vorhanden
        // await _apiService.post('/auth/logout', data: {});
      }
    } catch (e) {
      debugPrint('Server logout failed: $e');
      // Lokales Logout trotzdem durchführen
    }

    // Lokale User-Daten löschen
    _userGuid = null;
    _pubGuid = null;
    _apiKey = null;
    _userRightId = null;

    // Token aus ApiService entfernen
    _apiService.clearAuthToken();

    // User-Daten aus Storage löschen
    await _clearUserDataFromStorage();
  }

  /// User-Daten aus persistentem Storage löschen
  Future<void> _clearUserDataFromStorage() async {
    try {
      await _storage.delete(key: _userGuidKey);
      await _storage.delete(key: _pubGuidKey);
      await _storage.delete(key: _apiKeyKey);
      await _storage.delete(key: _userRightIdKey);
      debugPrint('Cleared all user data from secure storage');
    } catch (e) {
      debugPrint('Failed to clear user data from secure storage: $e');
    }
  }

  /// Prüfung ob Token noch gültig ist (für API-Calls)
  Future<void> ensureValidToken() async {
    if (_userGuid == null || _apiKey == null) {
      throw AuthenticationException('No authentication data available');
    }

    // Bei diesem Token-System gibt es normalerweise keine Ablaufzeit
    // Token sind bis zum expliziten Logout gültig
    // Falls erforderlich, könnte hier eine Token-Validierung per API-Call erfolgen
  }
}