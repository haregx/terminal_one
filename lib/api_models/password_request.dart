import 'api_request.dart';

/// PasswordRequest Model (entspricht C# PasswordRequest : Request)
class PasswordRequest extends ApiRequest {
  final String loginname;

  const PasswordRequest({
    required this.loginname,
    required super.apiKey,
    super.vendor,
  });

  /// Factory constructor für einfache Erstellung
  factory PasswordRequest.create({
    required String loginname,
    required String apiKey,
    int? vendor,
  }) {
    return PasswordRequest(
      loginname: loginname,
      apiKey: apiKey,
      vendor: vendor ?? ApiRequest.kwizzi,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ...baseJson,
      'loginname': loginname,
    };
  }
}
