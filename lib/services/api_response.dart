import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

/// Generisches API-Response-Model für standardisierte Server-Antworten
/// 
/// Dieses Model kann für alle API-Responses verwendet werden und
/// unterstützt sowohl Success- als auch Error-Responses.
@JsonSerializable(genericArgumentFactories: true)
class ApiResponse<T> {
  /// Erfolgs-Status der Anfrage
  final bool success;
  
  /// Daten der Antwort (nur bei success: true)
  final T? data;
  
  /// Fehlermeldung (nur bei success: false)
  final String? message;
  
  /// Zusätzliche Metadaten (Pagination, etc.)
  final Map<String, dynamic>? meta;
  
  /// Validation-Errors (bei 422 Responses)
  final Map<String, List<String>>? errors;

  const ApiResponse({
    required this.success,
    this.data,
    this.message,
    this.meta,
    this.errors,
  });

  /// Factory für JSON-Deserialization
  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$ApiResponseFromJson(json, fromJsonT);

  /// Serialization zu JSON
  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$ApiResponseToJson(this, toJsonT);

  /// Success-Response erstellen
  factory ApiResponse.success(T data, {Map<String, dynamic>? meta}) {
    return ApiResponse<T>(
      success: true,
      data: data,
      meta: meta,
    );
  }

  /// Error-Response erstellen
  factory ApiResponse.error(
    String message, {
    Map<String, List<String>>? errors,
    Map<String, dynamic>? meta,
  }) {
    return ApiResponse<T>(
      success: false,
      message: message,
      errors: errors,
      meta: meta,
    );
  }

  /// Prüft ob Response erfolgreich war
  bool get isSuccess => success && data != null;
  
  /// Prüft ob Response fehlgeschlagen ist
  bool get isError => !success;
  
  /// Gibt Daten zurück oder wirft Exception bei Fehler
  T get dataOrThrow {
    if (isSuccess) {
      return data!;
    }
    throw Exception(message ?? 'Unknown API error');
  }
}

/// Pagination-Metadaten für Listen-Responses
@JsonSerializable()
class PaginationMeta {
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;
  final int from;
  final int to;

  const PaginationMeta({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
    required this.from,
    required this.to,
  });

  factory PaginationMeta.fromJson(Map<String, dynamic> json) =>
      _$PaginationMetaFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationMetaToJson(this);

  /// Prüft ob weitere Seiten verfügbar sind
  bool get hasNextPage => currentPage < lastPage;
  
  /// Prüft ob vorherige Seiten verfügbar sind
  bool get hasPreviousPage => currentPage > 1;
}

/// Paginierte Listen-Response
@JsonSerializable(genericArgumentFactories: true)
class PaginatedResponse<T> {
  final List<T> data;
  final PaginationMeta meta;

  const PaginatedResponse({
    required this.data,
    required this.meta,
  });

  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$PaginatedResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$PaginatedResponseToJson(this, toJsonT);
}