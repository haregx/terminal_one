/// API Result Model für Fehler-Responses (entspricht C# Result-Klasse)
class ApiResult {
  final int code;
  final int updateNo;
  final List<dynamic>? obj;

  // Success Codes
  static const int ok = 0;
  static const int okWithRestrictions = 1;

  // API Error Codes (entspricht C# Konstanten)
  static const int badApi = 10000;
  static const int badModel = 10001;
  static const int databaseError = 10002;
  static const int nullRequest = 10003;
  static const int emptyRequest = 10004;

  // User Error Codes
  static const int badUser = 1000;
  static const int userLocked = 1001;
  static const int userDeleted = 1002;
  static const int userNotConfirmedByUser = 1003;
  static const int userNotConfirmedByAdmin = 1004;
  static const int badPassword = 1005;
  static const int badConfirmCode = 1006;
  static const int confirmCodeExpired = 1007;
  static const int isConfirmed = 1008;
  static const int noAdmin = 1009;
  static const int badContact = 1010;
  static const int badEmail = 1012;
  static const int badPhone = 1013;
  static const int badToken = 1014;
  static const int badQrCode = 1015;
  static const int badQrCodeExpired = 1016;

  static const int notFound = 1404;
  static const int contactModified = 1111;

  // Rate Limiting & SSO
  static const int tooManyLogins = 1500;
  static const int singleSignonFailed = 1600;
  static const int jobFailed = 1601;

  // Duplicate Errors
  static const int duplicateLogin = 2000;
  static const int duplicateEmail = 2001;
  static const int duplicatePhone = 2002;

  // Various Errors
  static const int excelError = 3000;
  static const int confirmCodeNotSend = 4000;
  static const int mailNotSend = 4000;
  static const int contactNotFound = 5404;
  static const int contactQRCodeExpired = 5405;
  static const int aiError = 6000;
  static const int nullResult = 999999;

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

  /// Hilfsmethode um zu prüfen ob es ein Fehler ist
  bool get isError => code != 0;

  /// Hilfsmethode um zu prüfen ob es ein Erfolg ist
  bool get isSuccess => code == 0;

  /// Hilfsmethode für spezifische Fehlertypen
  bool get isUserError => code >= 1000 && code < 2000;
  bool get isApiError => code >= 10000;
  bool get isDuplicateError => code >= 2000 && code < 3000;
  bool get isAuthError => [badUser, badPassword, badToken, userLocked, userDeleted].contains(code);

  /// Hilfsmethode für benutzerfreundliche Fehlernachrichten
  String get errorMessage {
    if (obj?.isNotEmpty == true) {
      return obj!.first.toString();
    }
    
    // Fallback für bekannte Fehlercodes
    switch (code) {
      case badUser:
        return 'Ungültiger Benutzer';
      case badPassword:
        return 'Falsches Passwort';
      case userLocked:
        return 'Benutzer ist gesperrt';
      case userDeleted:
        return 'Benutzer wurde gelöscht';
      case userNotConfirmedByUser:
        return 'Benutzer nicht bestätigt';
      case userNotConfirmedByAdmin:
        return 'Benutzer nicht von Admin bestätigt';
      case badToken:
        return 'Ungültiger Token';
      case tooManyLogins:
        return 'Zu viele Login-Versuche';
      case duplicateEmail:
        return 'E-Mail bereits vorhanden';
      case duplicateLogin:
        return 'Login bereits vorhanden';
      case badEmail:
        return 'Ungültige E-Mail-Adresse';
      case confirmCodeExpired:
        return 'Bestätigungscode abgelaufen';
      case badConfirmCode:
        return 'Ungültiger Bestätigungscode';
      case notFound:
        return 'Nicht gefunden';
      case databaseError:
        return 'Datenbankfehler';
      case nullRequest:
        return 'Leere Anfrage';
      default:
        return 'Fehler Code: $code';
    }
  }

  @override
  String toString() {
    return 'ApiResult(code: $code, updateNo: $updateNo, obj: $obj)';
  }
}