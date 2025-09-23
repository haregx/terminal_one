/// API-Konfiguration für verschiedene Umgebungen
class ApiConfig {
  // Base URL des Servers
  static const String baseUrl = 'https://jack.hareg.com/api';
  
  // API-Endpoints
  static const String loginEndpoint = '/Users/Login';  // Können Sie anpassen falls anders
  static const String registerEndpoint = '/Users/Add';  // Register Endpoint
  static const String passwordRequestEndpoint = '/Users/PasswordRequest';  // Password Request Endpoint
  
  // API-Key für Ihre App
  static const String apiKey = 'TERMINAL_ONE_API_KEY';
  
  // Timeout-Konfiguration
  static const Duration timeout = Duration(seconds: 30);
  
  // Standard-Headers
  static const Map<String, String> defaultHeaders = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };
}

/// Umgebungs-spezifische Konfiguration
class EnvironmentConfig {
  static const bool isDevelopment = true; // Auf false für Production setzen
  
  static String get baseUrl => isDevelopment 
    ? 'https://jack.hareg.com/api'  // Development-Server
    : 'https://jack.hareg.com/api';     // Production-Server
    
  static String get apiKey => isDevelopment
    ? 'TERMINAL_ONE_DEV_KEY'     // Development API-Key
    : 'TERMINAL_ONE_PROD_KEY';   // Production API-Key
}