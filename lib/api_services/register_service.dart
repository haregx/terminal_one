import 'package:terminal_one/api_models/api_request.dart';
import 'package:terminal_one/api_models/register_request.dart';
import 'package:terminal_one/api_services/simple_https_post.dart';
import 'package:terminal_one/config/api_config.dart';

class RegisterService {
  Future<RegisterResult> register({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    final url = '${ApiConfig.baseUrl}/Users/Register';
    final jsonBody = RegisterRequest(
      loginname: email.trim(),
      emailAddress: email.trim(),
      password: password,
      apiKey: ApiConfig.apiKey,
      vendor: ApiRequest.kwizzi,
    ).toJson();

    try {
      var response = await SimpleHttpsPost.postJson(
        url: url,
        jsonBody: jsonBody,
      );
      return RegisterResult.success(response);
    } catch (e) {
      return RegisterResult.error(e);
    }
  }
}

class RegisterResult {
  final bool isSuccess;
  final dynamic data;
  final Object? error;

  RegisterResult.success(this.data)
      : isSuccess = true,
        error = null;

  RegisterResult.error(this.error)
      : isSuccess = false,
        data = null;
}
