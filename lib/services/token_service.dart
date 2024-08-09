import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:farmers_guide/models/token.dart';

class TokenService {
  static const _prefix = 'TokenService@';
  static const _accessTokenKey = '${_prefix}access_token';
  static const _tokenTypeKey = '${_prefix}refresh_token';

  static const _storage = FlutterSecureStorage();

  static Future<void> setToken(AuthToken tokenMap) {
    return Future.wait([
      _storage.write(key: _accessTokenKey, value: tokenMap.accessToken),
      _storage.write(key: _tokenTypeKey, value: tokenMap.tokenType)
    ], eagerError: true);
  }

  static Future<void> setAccessToken(String accessToken) {
    return _storage.write(key: _accessTokenKey, value: accessToken);
  }

  static Future<String?> getAccessToken() {
    return _storage.read(key: _accessTokenKey);
  }

  static Future<void> clearToken() {
    return Future.wait([
      _storage.delete(key: _accessTokenKey),
      _storage.delete(key: _tokenTypeKey)
    ]);
  }
}
