import '../api_request.dart';

/// Login Request Model (entspricht C# Login : Request)
class LoginRequest extends ApiRequest {
  final String loginname;
  final String password;

  const LoginRequest({
    required this.loginname,
    required this.password,
    required super.apiKey,
    super.vendor,
  });

  /// Factory constructor für einfache Erstellung
  factory LoginRequest.create({
    required String loginname,
    required String password,
    required String apiKey,
    int? vendor,
  }) {
    return LoginRequest(
      loginname: loginname,
      password: password,
      apiKey: apiKey,
      vendor: vendor ?? ApiRequest.kwizzi,
    );
  }

  /// Convert zu JSON
  @override
  Map<String, dynamic> toJson() {
    return {
      ...baseJson,
      'loginname': loginname,
      'password': password,
    };
  }

  @override
  String toString() {
    return 'LoginRequest(loginname: $loginname, vendor: $vendor)'; // Passwort nicht loggen!
  }
}