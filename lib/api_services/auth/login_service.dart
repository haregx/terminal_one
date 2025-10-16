import 'package:flutter/foundation.dart';
import 'package:terminal_one/api_models/auth/login_request.dart';
import 'package:terminal_one/api_services/https_post_service.dart';
import 'package:terminal_one/config/api_config.dart';
import 'package:terminal_one/api_models/api_request.dart';

class LoginService {
  Future<LoginResult> login(String email, String password) async {
    final url = '${ApiConfig.baseUrl}/Users/Login';
    final jsonBody = LoginRequest(
      loginname: email.trim(),
      password: password,
      apiKey: ApiConfig.apiKey,
      vendor: ApiRequest.terminalone, 
    ).toJson();

    try {
      var response = await SimpleHttpsPost.postJson(
        url: url,
        jsonBody: jsonBody,
      );
      debugPrint('🔑 LoginService response: $response');
      // Check for code in response
      int? code = response['code'] as int?;
      if (code == 0) {
        debugPrint('✅ Login success (code 0)');
        return LoginResult.success(response);
      } else if (code == 1) {
        debugPrint('⚠️ Login success with restrictions (code 1)');
        return LoginResult.successWithRestrictions(response);
      }
      return LoginResult.error('Unknown code: $code');
    } catch (e) {
      return LoginResult.error(e);
    }
  }
}

class LoginResult {
  final bool isSuccess;
  final bool hasRestrictions;
  final dynamic data;
  final Object? error;

  LoginResult.success(this.data)
      : isSuccess = true,
        hasRestrictions = false,
        error = null;

  LoginResult.successWithRestrictions(this.data)
      : isSuccess = true,
        hasRestrictions = true,
        error = null;

  LoginResult.error(this.error)
      : isSuccess = false,
        hasRestrictions = false,
        data = null;
}
