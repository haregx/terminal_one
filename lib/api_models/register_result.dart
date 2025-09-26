import 'api_result.dart';

/// Register Result Model (entspricht C# RegisterResult : Result)
class RegisterResult extends ApiResult {
  final String pubGuid;
  final DateTime accountCreated;
  final int confirmedBy;
  final String confirmedIdent;

  // Confirmation Types (entspricht C# Classes.Codes.ConfirmationBy)
  static const int confirmationByEmail = 1; // Annahme - könnte angepasst werden
  static const int confirmationByAdmin = 2;
  static const int confirmationByPhone = 3;

  const RegisterResult({
    required this.pubGuid,
    required this.accountCreated,
    required this.confirmedBy,
    required this.confirmedIdent,
    required super.code,
    super.updateNo = 0,
    super.obj,
  });

  /// Factory constructor für JSON deserialization
  factory RegisterResult.fromJson(Map<String, dynamic> json) {
    return RegisterResult(
      pubGuid: json['pubGuid'] as String,
      accountCreated: DateTime.parse(json['accountCreated'] as String),
      confirmedBy: json['confirmedBy'] as int,
      confirmedIdent: json['confirmedIdent'] as String,
      code: json['code'] as int,
      updateNo: json['updateNo'] as int? ?? 0,
      obj: json['obj'] as List<dynamic>?,
    );
  }

  /// Convert zu JSON
  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'pubGuid': pubGuid,
      'accountCreated': accountCreated.toIso8601String(),
      'confirmedBy': confirmedBy,
      'confirmedIdent': confirmedIdent,
    };
  }

  /// Hilfsmethoden für Register-spezifische Prüfungen
  bool get isSuccessfulRegister => code == ApiResult.ok || code == ApiResult.okWithRestrictions;
  bool get needsConfirmation => confirmedBy != confirmationByAdmin;
  bool get isConfirmedByEmail => confirmedBy == confirmationByEmail;
  bool get isConfirmedByAdmin => confirmedBy == confirmationByAdmin;
  bool get isConfirmedByPhone => confirmedBy == confirmationByPhone;

  @override
  String toString() {
    return 'RegisterResult(pubGuid: $pubGuid, code: $code, confirmedBy: $confirmedBy)';
  }
}