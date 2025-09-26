/// API Result Model für Fehler-Responses (entspricht C# Result-Klasse)
class ApiResult {
  final int code;
  final int updateNo;
  final List<dynamic>? obj;

  const ApiResult({
    required this.code,
    this.updateNo = 0,
    this.obj,
  });

  /// Factory constructor für JSON deserialization
  factory ApiResult.fromJson(Map<String, dynamic> json) {
    return ApiResult(
      code: json['code'] as int,
      updateNo: json['updateNo'] as int? ?? 0,
      obj: json['obj'] as List<dynamic>?,
    );
  }

  /// Convert zu JSON
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'updateNo': updateNo,
      'obj': obj,
    };
  }

  @override
  String toString() {
    return 'ApiResult(code: $code, updateNo: $updateNo, obj: $obj)';
  }
}