import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  static final _storage = FlutterSecureStorage();

  static const _keyUsername = 'username';
  static const _keyEmail = 'email';
  static const _keyLoggedIn = 'LoggedIn';

  static Future setUsername(String username) async =>
      await _storage.write(key: _keyUsername, value: username);

  static Future<String?> getUsername() async =>
      await _storage.read(key: _keyUsername);

  static Future setEmail(String email) async {
    await _storage.write(key: _keyEmail, value: email);
  }

    static Future<String?> getEmail() async =>
      await _storage.read(key: _keyEmail);

  static Future setLoggedIn(bool isLoggedIn) async {
    final value = isLoggedIn.toString();
    
    await _storage.write(key: _keyLoggedIn, value: value);
  }

  static Future<bool> getLoggedIn() async {
    final value = await _storage.read(key: _keyLoggedIn);

    return value == null? false:bool.fromEnvironment(value);
  }

  static Future deleteUsername() async =>
      await _storage.delete(key: _keyUsername);
  
  static Future deleteEmail() async =>
      await _storage.delete(key: _keyEmail);
}