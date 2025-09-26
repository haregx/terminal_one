import 'package:flutter/material.dart';
import 'package:terminal_one/api_models/api_request.dart';
import 'package:terminal_one/api_models/login_request.dart';
import 'package:terminal_one/api_services/simple_https_post.dart';
import 'package:terminal_one/config/api_config.dart';
import '../components/snackbars/fancy_success_snackbar.dart';

Future<void> handleLogin({
  required BuildContext context,
  required String email,
  required String password,
  required VoidCallback onStart,
  required VoidCallback onFinish,
  required bool mounted,
}) async {

  if (!mounted) return;
  onStart();

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
   
    debugPrint('✅ Login response: $response');
    ScaffoldMessenger.of(context).showSnackBar(
      FancySuccessSnackbar.build('You have been successfully logged in!'),
    );
  } catch (e) {
    debugPrint('❌ Login error: ${e.runtimeType}');
    debugPrint('❌ Error details: $e');
    HttpsErrorHandler.handle(context, e);
  } finally {
    if (mounted) {
      onFinish();
    }
  }
}