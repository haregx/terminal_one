import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'api_exceptions.dart';

/// Zentrale API-Service-Klasse für alle HTTP-Kommunikation
class ApiService {
  Dio? _dio;
  bool _isInitialized = false;

  /// Singleton-Pattern für globale Verwendung
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  /// Initialisierung der API-Service
  void initialize({
    required String baseUrl,
    Duration timeout = const Duration(seconds: 30),
    Map<String, String>? headers,
  }) {
    if (_isInitialized) return; // Verhindert mehrfache Initialisierung
    
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: timeout,
      receiveTimeout: timeout,
      sendTimeout: timeout,
      headers: headers ?? {},
      contentType: 'application/json',
      responseType: ResponseType.json,
    ));

    _setupInterceptors();
    _isInitialized = true;
  }

  /// Setup von Request/Response-Interceptors
  void _setupInterceptors() {
    if (_dio == null) return;
    
    // Debug-Logging-Interceptor
    if (kDebugMode) {
      _dio!.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
          debugPrint('🌐 API Request: ${options.method} ${options.uri}');
          if (options.data != null) {
            debugPrint('📤 JSON: ${options.data is String ? options.data : options.data.toString()}');
          }
          handler.next(options);
        },
        onResponse: (response, handler) {
          debugPrint('✅ API Response: ${response.statusCode} ${response.requestOptions.uri}');
          if (response.data != null) {
            debugPrint('📥 JSON: ${response.data is String ? response.data : response.data.toString()}');
          }
          handler.next(response);
        },
        onError: (error, handler) {
          debugPrint('❌ API Error: ${error.message}');
          if (error.response?.data != null) {
            debugPrint('📥 JSON (Error): ${error.response!.data is String ? error.response!.data : error.response!.data.toString()}');
          }
          // Log platform info for debugging (especially for web exceptions)
          debugPrint('Platform: ${identical(0, 0.0) ? "Web" : "Mobile/Desktop"}');
          debugPrint('Error type: ${error.runtimeType}');
          debugPrint('Error details: ${error.toString()}');
          if (error.requestOptions != null) {
            debugPrint('Request URL: ${error.requestOptions.uri}');
            debugPrint('Request Method: ${error.requestOptions.method}');
            debugPrint('Request Headers: ${error.requestOptions.headers}');
            debugPrint('Request Data: ${error.requestOptions.data}');
          }
          if (error.response != null) {
            debugPrint('Response Status: ${error.response?.statusCode}');
            debugPrint('Response Headers: ${error.response?.headers}');
          }
          handler.next(error);
        },
      ));
    }
  }

  /// Auth-Token setzen
  void setAuthToken(String token) {
    debugPrint('user token ? $token, is _dio null? ${_dio == null}');
    if (_dio != null) {
      debugPrint('Setting auth token in headers _dio ${_dio!.options.headers} , token $token');
      _dio!.options.headers['Authorization'] = 'Bearer $token';
      debugPrint('Current headers: ${_dio!.options.headers}');
    }
  }

  /// Auth-Token entfernen
  void clearAuthToken() {
    if (_dio != null) {
      _dio!.options.headers.remove('Authorization');
    }
  }

  /// GET Request
  Future<T> get<T>(
      String path, {
      Map<String, dynamic>? queryParameters,
      Map<String, String>? headers,
    }) async {
    if (_dio == null) throw Exception('ApiService not initialized');
    
    try {
      final response = await _dio!.get<T>(
        path,
        queryParameters: queryParameters,
        options: headers != null ? Options(headers: headers) : null,
      );
      
      return _handleResponse<T>(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  /// Fügt die aktuelle Sprache zum Request-Body hinzu
  Map<String, dynamic> addLanguageToBody(BuildContext context, Map<String, dynamic> body) {
    final locale = Localizations.localeOf(context).languageCode;
    return {
      ...body,
      'language': locale,
    };
  }

  /// POST Request mit automatischer Sprache
  Future<T> postWithLanguage<T>(
    BuildContext context,
    String path, {
    required Map<String, dynamic> data,
    Map<String, String>? headers,
  }) async {
    final dataWithLang = addLanguageToBody(context, data);
    return await post<T>(path, data: dataWithLang, headers: headers, context: context);
  }

  /// POST Request
  Future<T> post<T>(
    String path, {
    dynamic data,
    Map<String, String>? headers,
    BuildContext? context,
  }) async {
    if (_dio == null) throw Exception('ApiService not initialized');
  
    // Sprache automatisch hinzufügen, wenn möglich
    if (context != null && data is Map<String, dynamic>) {
      data = addLanguageToBody(context, data);
    }
    try {
      final response = await _dio!.post<T>(
        path,
        data: data,
        options: headers != null ? Options(headers: headers) : null,
      );
    
      return _handleResponse<T>(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  /// Response-Handling
  T _handleResponse<T>(Response<T> response) {
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      return response.data as T;
    } else {
      throw ServerException(
        'Server error: ${response.statusCode}',
        statusCode: response.statusCode!,
      );
    }
  }

  /// Error-Handling
  Exception _handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return NetworkException('Request timeout');
        
        case DioExceptionType.connectionError:
          return NetworkException('Connection error: ${error.message}');
        
        case DioExceptionType.badResponse:
          final statusCode = error.response?.statusCode ?? 0;
          if (statusCode == 400) {
            // Status 400 - API Result mit spezifischen Fehlercodes verarbeiten
            return _handleApiResultError(error.response?.data);
          } else if (statusCode == 401) {
            return AuthenticationException('Authentication failed');
          } else if (statusCode == 422) {
            // Validation errors
            final validationErrors = _extractValidationErrors(error.response?.data);
            return ValidationException(
              'Validation failed',
              validationErrors: validationErrors,
            );
          } else {
            return ServerException(
              'Server error: ${error.message}',
              statusCode: statusCode,
            );
          }
        
        default:
          return NetworkException('Network error: ${error.message}');
      }
    }
    
    return Exception('Unknown error: $error');
  }

  /// Validation-Errors extrahieren
  Map<String, List<String>>? _extractValidationErrors(dynamic data) {
    if (data is Map<String, dynamic> && data.containsKey('errors')) {
      final errors = data['errors'] as Map<String, dynamic>;
      return errors.map((key, value) => MapEntry(
        key,
        (value as List).map((e) => e.toString()).toList(),
      ));
    }
    return null;
  }

  /// API Result Error mit spezifischen Fehlercodes behandeln
  Exception _handleApiResultError(dynamic data) {
    if (data is Map<String, dynamic> && data.containsKey('code')) {
      final code = data['code'] as int;
      
      // Benutzerfreundliche Fehlernachrichten basierend auf Fehlercodes
      String message;
      switch (code) {
        case 1000: // BadUser
          message = 'Ungültiger Benutzer';
          break;
        case 1005: // BadPassword
          message = 'Falsches Passwort';
          break;
        case 1001: // UserLocked
          message = 'Benutzer ist gesperrt';
          break;
        case 1002: // UserDeleted
          message = 'Benutzer wurde gelöscht';
          break;
        case 1003: // UserNotConfirmedByUser
          message = 'Benutzer nicht bestätigt';
          break;
        case 1004: // UserNotConfirmedByAdmin
          message = 'Benutzer nicht von Admin bestätigt';
          break;
        case 1014: // BadToken
          message = 'Ungültiger Token';
          break;
        case 1500: // TooManyLogins
          message = 'Zu viele Login-Versuche';
          break;
        case 2001: // DuplicateEmail
          message = 'E-Mail bereits vorhanden';
          break;
        case 2000: // DuplicateLogin
          message = 'Login bereits vorhanden';
          break;
        case 1012: // BadEmail
          message = 'Ungültige E-Mail-Adresse';
          break;
        case 1007: // ConfirmCodeExpired
          message = 'Bestätigungscode abgelaufen';
          break;
        case 1006: // BadConfirmCode
          message = 'Ungültiger Bestätigungscode';
          break;
        case 1404: // NotFound
          message = 'Nicht gefunden';
          break;
        case 10002: // DatabaseError
          message = 'Datenbankfehler';
          break;
        case 10003: // NullRequest
          message = 'Leere Anfrage';
          break;
        default:
          message = 'Fehler Code: $code';
      }
      
      return AuthenticationException(message);
    }
    
    // Fallback für unbekannte Fehlerstruktur
    return ServerException('Unbekannter Server-Fehler', statusCode: 400);
  }
}