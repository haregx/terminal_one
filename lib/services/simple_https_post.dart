import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:terminal_one/components/snackbars/fancy_error_snackbar.dart';

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
      debugPrint('⬅️ Response Status: ${response.statusCode}');
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
      } else {
        throw Exception('HTTP ${response.statusCode}: ${response.reasonPhrase}\n${response.body}');
      }
    } on SocketException catch (e) {
      debugPrint('❌ Network error (SocketException): $e');
      throw SimpleHttpsPostNetworkException();
    } on TimeoutException catch (e) {
      debugPrint('❌ Network error (TimeoutException): $e');
      throw SimpleHttpsPostNetworkException();
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



class ErrorCodes {
  static String translate (int code) {
    switch (code) {
        case 1000: // BadUser
          return 'Ungültiger Benutzer';
        case 1005: // BadPassword
          return 'Falsches Passwort';
        case 1001: // UserLocked
          return 'Benutzer ist gesperrt';
        case 1002: // UserDeleted
          return 'Benutzer wurde gelöscht';
        case 1003: // UserNotConfirmedByUser
          return 'Benutzer nicht bestätigt';
        case 1004: // UserNotConfirmedByAdmin
          return 'Benutzer nicht von Admin bestätigt';
        case 1014: // BadToken
          return 'Ungültiger Token';
        case 1500: // TooManyLogins
          return 'Zu viele Login-Versuche';
        case 2001: // DuplicateEmail
          return 'E-Mail bereits vorhanden';
        case 2000: // DuplicateLogin
          return 'Login bereits vorhanden';
        case 1012: // BadEmail
          return 'Ungültige E-Mail-Adresse';
        case 1007: // ConfirmCodeExpired
          return 'Bestätigungscode abgelaufen';
        case 1006: // BadConfirmCode
          return 'Ungültiger Bestätigungscode';
        case 1404: // NotFound
          return 'Nicht gefunden';
        case 10002: // DatabaseError
          return 'Datenbankfehler';
        case 10003: // NullRequest
          return 'Leere Anfrage';
        default:
          return 'Fehler Code: $code';
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
        FancyErrorSnackbar.build('Die angeforderte Ressource wurde nicht gefunden.'),
      );
    } else if (e is SimpleHttpsPostNetworkException) {
      debugPrint('❌ SimpleHttpsPostNetworkException: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        FancyErrorSnackbar.build('Keine Internetverbindung oder Server nicht erreichbar.'),
      );
    } else {
      debugPrint('❌ Unexpected error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        FancyErrorSnackbar.build('Ein unerwarteter Fehler ist aufgetreten.'),
      );
    }
  }
}