import 'package:terminal_one/api_models/api_request.dart';
import 'package:terminal_one/api_models/auth/password_request.dart';
import 'package:terminal_one/api_services/https_post_service.dart';
import 'package:terminal_one/config/api_config.dart';

class PasswordRequestService {
  Future<PasswordRequestResult> requestPassword(String email) async {
    final url = '${ApiConfig.baseUrl}/Users/PasswordRequest';
    final jsonBody = PasswordRequest(
      loginname: email.trim(),
      apiKey: ApiConfig.apiKey,
      vendor: ApiRequest.kwizzi,
    ).toJson();

    try {
      var response = await SimpleHttpsPost.postJson(
        url: url,
        jsonBody: jsonBody,
      );
      return PasswordRequestResult.success(response);
    } catch (e) {
      return PasswordRequestResult.error(e);
    }
  }
}

class PasswordRequestResult {
  final bool isSuccess;
  final dynamic data;
  final Object? error;

  PasswordRequestResult.success(this.data)
      : isSuccess = true,
        error = null;

  PasswordRequestResult.error(this.error)
      : isSuccess = false,
        data = null;
}
