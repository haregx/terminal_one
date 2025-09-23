// API-spezifische Exception-Klassen für besseres Error-Handling
// 
// Diese Klassen ermöglichen eine strukturierte Behandlung verschiedener
// API-Fehlertypen und erleichtern die Fehlerbehandlung in der UI.

/// Basis-Klasse für alle API-Exceptions
abstract class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  const ApiException(this.message, {this.statusCode, this.data});

  @override
  String toString() => 'ApiException: $message (Status: $statusCode)';
}

/// Network-Connectivity-Fehler (kein Internet, Timeout, etc.)
class NetworkException extends ApiException {
  const NetworkException(super.message, {super.statusCode, super.data});
  
  @override
  String toString() => 'NetworkException: $message';
}

/// Server-Fehler (5xx Status Codes)
class ServerException extends ApiException {
  const ServerException(super.message, {super.statusCode, super.data});
  
  @override
  String toString() => 'ServerException: $message (Status: $statusCode)';
}

/// Client-Fehler (4xx Status Codes)
class ClientException extends ApiException {
  const ClientException(super.message, {super.statusCode, super.data});
  
  @override
  String toString() => 'ClientException: $message (Status: $statusCode)';
}

/// Authentication-Fehler (401, 403)
class AuthenticationException extends ApiException {
  const AuthenticationException(super.message, {super.statusCode, super.data});
  
  @override
  String toString() => 'AuthenticationException: $message (Status: $statusCode)';
}

/// Validation-Fehler (400 mit Validation-Details)
class ValidationException extends ApiException {
  final Map<String, List<String>>? validationErrors;
  
  const ValidationException(
    super.message, {
    super.statusCode,
    super.data,
    this.validationErrors,
  });
  
  @override
  String toString() => 'ValidationException: $message (Errors: $validationErrors)';
}

/// JSON-Parsing-Fehler
class ParseException extends ApiException {
  const ParseException(super.message, {super.data});
  
  @override
  String toString() => 'ParseException: $message';
}

/// Rate-Limiting-Fehler (429)
class RateLimitException extends ApiException {
  final DateTime? retryAfter;
  
  const RateLimitException(
    super.message, {
    super.statusCode,
    super.data,
    this.retryAfter,
  });
  
  @override
  String toString() => 'RateLimitException: $message (Retry after: $retryAfter)';
}