import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthUtilityController {
 // static const _storage = FlutterSecureStorage();

  static final FlutterSecureStorage _storage = FlutterSecureStorage(
    aOptions: _getAndroidOptions(),
  );

  static AndroidOptions _getAndroidOptions() => const AndroidOptions(
    encryptedSharedPreferences: true,
  );

  static String? _accessToken;
  static String? _refreshToken;
  static String? _userRole;

  static String? get accessToken => _accessToken;
  static String? get refreshToken => _refreshToken;
  static String? get userRole => _userRole;


  /*----------------> Access Token <------------------*/
  static Future<void> setAccessToken({required String? token}) async {
    if (token != null) {
      await _storage.write(key: 'accessToken', value: token);
    } else {
      await _storage.delete(key: 'accessToken');
    }

    _accessToken = token;
    debugPrint("====> Set Token: $_accessToken");
  }

  static Future<void> getAccessToken() async {
    _accessToken = await _storage.read(key: 'accessToken');
    debugPrint("====>Token: $_accessToken");
  }

  /*----------------> Refresh Token <------------------*/
  static Future<void> setRefreshToken({required String? refreshToken}) async {
    if (refreshToken != null) {
      await _storage.write(key: 'refreshToken', value: refreshToken);
    } else {
      await _storage.delete(key: 'refreshToken');
    }

    _refreshToken = refreshToken;
    debugPrint("====> Set refreshToken: $_refreshToken");
  }

  static Future<void> getRefreshToken() async {
    _refreshToken = await _storage.read(key: 'refreshToken');
    debugPrint("====>Get Refresh Token: $_refreshToken");
  }

  /*----------------> User Role <------------------*/
  static Future<void> setUserRole({required String? userRole}) async {
    if (userRole != null) {
      await _storage.write(key: 'userRole', value: userRole);
    } else {
      await _storage.delete(key: 'userRole');
    }

    _userRole = userRole;
    debugPrint("====> Set User Role: $_userRole");
  }

  static Future<void> getUserRole() async {
    _userRole = await _storage.read(key: 'userRole');
    debugPrint("====>Get User Role: $_userRole");
  }

  static Future<void> clearInfo() async {
    await _storage.deleteAll();
  }

  static bool get isLoggedIn {
    return _accessToken != null;
  }
}