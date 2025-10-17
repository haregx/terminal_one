import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart'; // for kIsWeb
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:terminal_one/widgets/snackbars/fancy_error_snackbar.dart';

/// SimpleHttpsPost - Utility class for sending HTTPS POST requests with JSON body and receiving JSON response.
class SimpleHttpsPost {
  /// Sends a POST request to the given [url] with [jsonBody] as the request body.
  /// Returns the decoded JSON response as a Map.
  /// Throws an exception if the request fails or the response is not valid JSON.
  static Future<Map<String, dynamic>> postJson({
    required String url,
    required Map<String, dynamic> jsonBody,
    Map<String, String>? headers,
  }) async {
    final defaultHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      ...?headers,
    };
    debugPrint('➡️ POST Request to $url');
    debugPrint('➡️ Request JSON: ${json.encode(jsonBody)}');
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: defaultHeaders,
        body: json.encode(jsonBody),
      );
      debugPrint('⬅️ Response StatusCode: ${response.statusCode}');
      debugPrint('⬅️ Response JSON: ${response.body}');
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return json.decode(response.body) as Map<String, dynamic>;
      } else if (response.statusCode == 400) {
        // Special handling for HTTP 400: return the error JSON
        final errorJson = json.decode(response.body) as Map<String, dynamic>;
        debugPrint('⬅️ Error JSON: $errorJson');
        throw SimpleHttpsPostBadRequestException(errorJson);
      } else if (response.statusCode == 404) {
        debugPrint('❌ Error 404: Not Found. URL: $url');
        throw SimpleHttpsPostNotFoundException(url);
      } else if (response.statusCode == 405) {
        debugPrint('❌ Error 405: Method Not Allowed. URL: $url');
        throw SimpleHttpsPostMethodNotAllowedException(url);
      } else {
        throw Exception('HTTP ${response.statusCode}: ${response.reasonPhrase}\n${response.body}');
      }
    } catch (e) {
      if (kIsWeb) {
        // Web: network errors are usually ClientException or browser errors
        if (e is http.ClientException || e.toString().contains('Failed to fetch')) {
          debugPrint('❌ Network error (Web): $e');
          throw SimpleHttpsPostNetworkException();
        }
      } else {
        // Mobile/Desktop: handle SocketException/TimeoutException
        if (e is SocketException || e is TimeoutException) {
          debugPrint('❌ Network error (Native): $e');
          throw SimpleHttpsPostNetworkException();
        }
      }
      rethrow;
    }
  }
} // End of SimpleHttpsPost class
// Exception for HTTP 404 Not Found
class SimpleHttpsPostNotFoundException implements Exception {
  final String url;
  SimpleHttpsPostNotFoundException(this.url);
  @override
  String toString() => '404 Not Found: $url';
}

// Exception for HTTP 400 Bad Request with JSON body
class SimpleHttpsPostBadRequestException implements Exception {
  final Map<String, dynamic> errorJson;
  SimpleHttpsPostBadRequestException(this.errorJson);
  @override
  String toString() => '$errorJson';
}

// Exception for network errors (e.g., no internet)
class SimpleHttpsPostNetworkException implements Exception {
  const SimpleHttpsPostNetworkException();
  @override
  String toString() => 'No internet connection or server not reachable.';
}

// Exception for HTTP 405 Method Not Allowed
class SimpleHttpsPostMethodNotAllowedException implements Exception {
  final String url;
  SimpleHttpsPostMethodNotAllowedException(this.url);
  @override
  String toString() => '405 Method Not Allowed: $url';
}

class ErrorCodes {
  static String translate(int code) {
    switch (code) {
      case 10000:
        return 'error.bad_api'.tr();
      case 10001:
        return 'error.bad_model'.tr();
      case 10002:
        return 'error.database_error'.tr();
      case 10003:
        return 'error.null_request'.tr();
      case 10004:
        return 'error.empty_request'.tr();
      case 1000:
        return 'error.bad_user'.tr();
      case 1001:
        return 'error.user_locked'.tr();
      case 1002:
        return 'error.user_deleted'.tr();
      case 1003:
        return 'error.user_not_confirmed_by_user'.tr();
      case 1004:
        return 'error.user_not_confirmed_by_admin'.tr();
      case 1005:
        return 'error.bad_password'.tr();
      case 1006:
        return 'error.bad_confirm_code'.tr();
      case 1007:
        return 'error.confirm_code_expired'.tr();
      case 1008:
        return 'error.is_confirmed'.tr();
      case 1009:
        return 'error.no_admin'.tr();
      case 1010:
        return 'error.bad_contact'.tr();
      case 1012:
        return 'error.bad_email'.tr();
      case 1013:
        return 'error.bad_phone'.tr();
      case 1014:
        return 'error.bad_token'.tr();
      case 1015:
        return 'error.bad_qr_code'.tr();
      case 1016:
        return 'error.bad_qr_code_expired'.tr();
      case 1404:
        return 'error.not_found'.tr();
      case 1111:
        return 'error.contact_modified'.tr();
      case 1500:
        return 'error.too_many_logins'.tr();
      case 1600:
        return 'error.single_signon_failed'.tr();
      case 1601:
        return 'error.job_failed'.tr();
      case 2000:
        return 'error.duplicate_login'.tr();
      case 2001:
        return 'error.duplicate_email'.tr();
      case 2002:
        return 'error.duplicate_phone'.tr();
      case 3000:
        return 'error.excel_error'.tr();
      case 4000:
        return 'error.confirm_code_not_send'.tr();
      case 5404:
        return 'error.contact_not_found'.tr();
      case 5405:
        return 'error.contact_qr_code_expired'.tr();
      case 6000:
        return 'error.ai_error'.tr();
      case 999999:
        return 'error.null_result'.tr();
      default:
        return 'error.code'.tr(namedArgs: {'code': code.toString()});
    }
  }
}


class HttpsErrorHandler {
  static void handle(BuildContext context, Object e) {
    debugPrint('❌ Login error: ${e.runtimeType}');
    if (e is SimpleHttpsPostBadRequestException) {
      debugPrint('❌ SimpleHttpsPostBadRequestException: $e');
      // Zugriff auf Fehlerdetails:
      final errorCode = e.errorJson['code'];
      final errorMessage = ErrorCodes.translate(errorCode);
      debugPrint('❌ Error code: $errorCode');
      debugPrint('❌ Error message: $errorMessage');
      ScaffoldMessenger.of(context).showSnackBar(
        FancyErrorSnackbar.build(errorMessage),
      );
    } else if (e is SimpleHttpsPostNotFoundException) {
      debugPrint('❌ SimpleHttpsPostNotFoundException: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        FancyErrorSnackbar.build('error.not_found'.tr()),
      );
    } else if (e is SimpleHttpsPostNetworkException) {
      debugPrint('❌ SimpleHttpsPostNetworkException: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        FancyErrorSnackbar.build('error.network'.tr()),
      );
    } else {
      debugPrint('❌ Unexpected error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        FancyErrorSnackbar.build('error.unexpected'.tr()),
      );
    }
  }
}