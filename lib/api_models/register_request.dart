import 'api_request.dart';

/// Register Request Model (entspricht C# Register : Request)
class RegisterRequest extends ApiRequest {
  final String loginname;
  final String emailAddress;
  final String password;

  const RegisterRequest({
    required this.loginname,
    required this.emailAddress,
    required this.password,
    required super.apiKey,
    super.vendor,
  });

  /// Factory constructor für einfache Erstellung
  factory RegisterRequest.create({
    required String loginname,
    required String emailAddress,
    required String password,
    required String apiKey,
    int? vendor,
  }) {
    return RegisterRequest(
      loginname: loginname,
      emailAddress: emailAddress,
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
      'emailAddress': emailAddress,
      'password': password,
    };
  }

  @override
  String toString() {
    return 'RegisterRequest(loginname: $loginname, emailAddress: $emailAddress, vendor: $vendor)'; // Passwort nicht loggen!
  }
}