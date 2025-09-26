import 'package:terminal_one/api_models/login_request.dart';
import 'package:terminal_one/api_services/simple_https_post.dart';
import 'package:terminal_one/config/api_config.dart';
import 'package:terminal_one/api_models/api_request.dart';

class LoginService {
  Future<LoginResult> login(String email, String password) async {
    final url = '${ApiConfig.baseUrl}/Users/Login';
    final jsonBody = LoginRequest(
      loginname: email.trim(),
      password: password,
      apiKey: ApiConfig.apiKey,
      vendor: ApiRequest.kwizzi,
    ).toJson();

    try {
      var response = await SimpleHttpsPost.postJson(
        url: url,
        jsonBody: jsonBody,
      );
      return LoginResult.success(response);
    } catch (e) {
      return LoginResult.error(e);
    }
  }
}

class LoginResult {
  final bool isSuccess;
  final dynamic data;
  final Object? error;

  LoginResult.success(this.data)
      : isSuccess = true,
        error = null;

  LoginResult.error(this.error)
      : isSuccess = false,
        data = null;
}
