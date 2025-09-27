import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static final _storage = FlutterSecureStorage();

  static Future<void> writeUserGuid(String userGuid) async {
    await _storage.write(key: 'userGuid', value: userGuid);
  }

  static Future<String?> readUserGuid() async {
    return await _storage.read(key: 'userGuid');
  }

  static Future<void> deleteUserGuid() async {
    await _storage.delete(key: 'userGuid');
  }
}
