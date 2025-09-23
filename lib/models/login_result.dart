import 'api_result.dart';

/// Login Result Model (entspricht C# LoginResult : Result)
class LoginResult extends ApiResult {
  final String userGuid;
  final String pubGuid;
  final bool isFirstLogin;
  final bool isPasswordChangeRequired;
  final DateTime accountCreated;
  final int confirmedBy;
  final String? confirmedIdent;
  final int userRightId;
  final bool isTestAccount;
  final bool isEditable;

  // Success Codes (entspricht C# Konstanten)
  static const int ok = 0;
  static const int okWithRestrictions = 1;

  // Confirmation Types (entspricht C# Classes.Codes.ConfirmationBy)
  static const int confirmationByEmail = 1; // Annahme - könnte angepasst werden

  const LoginResult({
    required this.userGuid,
    required this.pubGuid,
    this.isFirstLogin = false,
    this.isPasswordChangeRequired = false,
    required this.accountCreated,
    this.confirmedBy = confirmationByEmail,
    this.confirmedIdent,
    required this.userRightId,
    this.isTestAccount = false,
    this.isEditable = false,
    required super.code,
    super.updateNo = 0,
    super.obj,
  });

  /// Factory constructor für JSON deserialization
  factory LoginResult.fromJson(Map<String, dynamic> json) {
    return LoginResult(
      userGuid: json['userGuid'] as String,
      pubGuid: json['pubGuid'] as String,
      isFirstLogin: json['isFirstLogin'] as bool? ?? false,
      isPasswordChangeRequired: json['isPasswordChangeRequired'] as bool? ?? false,
      accountCreated: DateTime.parse(json['accountCreated'] as String),
      confirmedBy: json['confirmedBy'] as int? ?? confirmationByEmail,
      confirmedIdent: json['confirmedIdent'] as String?,
      userRightId: json['userRightId'] as int,
      isTestAccount: json['isTestAccount'] as bool? ?? false,
      isEditable: json['isEditable'] as bool? ?? false,
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
      'userGuid': userGuid,
      'pubGuid': pubGuid,
      'isFirstLogin': isFirstLogin,
      'isPasswordChangeRequired': isPasswordChangeRequired,
      'accountCreated': accountCreated.toIso8601String(),
      'confirmedBy': confirmedBy,
      'confirmedIdent': confirmedIdent,
      'userRightId': userRightId,
      'isTestAccount': isTestAccount,
      'isEditable': isEditable,
    };
  }

  /// Hilfsmethoden für Login-spezifische Prüfungen
  bool get isSuccessfulLogin => code == ok || code == okWithRestrictions;
  bool get hasRestrictions => code == okWithRestrictions;
  bool get needsPasswordChange => isPasswordChangeRequired;
  bool get isNewUser => isFirstLogin;

  @override
  String toString() {
    return 'LoginResult(userGuid: $userGuid, pubGuid: $pubGuid, code: $code, isFirstLogin: $isFirstLogin)';
  }
}