import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthProvider extends ChangeNotifier {
  static const _key = 'isLoggedIn';
  final _storage = FlutterSecureStorage();

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;
  bool isInitialized = false;

  AuthProvider() {
    _loadLoginState();
  }

  Future<void> _loadLoginState() async {
    final value = await _storage.read(key: _key);
    _isLoggedIn = value == 'true';
    isInitialized = true;
    notifyListeners();
  }

  Future<void> setLoggedIn(bool value) async {
    _isLoggedIn = value;
    await _storage.write(key: _key, value: value.toString());
    notifyListeners();
  }
}
