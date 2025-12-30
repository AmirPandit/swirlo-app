import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../config/api_config.dart';

class StorageService {
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  final _storage = const FlutterSecureStorage();

  // Token operations
  Future<void> saveAccessToken(String token) async {
    await _storage.write(key: ApiConfig.accessTokenKey, value: token);
  }

  Future<String?> getAccessToken() async {
    return await _storage.read(key: ApiConfig.accessTokenKey);
  }

  Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: ApiConfig.refreshTokenKey, value: token);
  }

  Future<String?> getRefreshToken() async {
    return await _storage.read(key: ApiConfig.refreshTokenKey);
  }

  // User data operations
  Future<void> saveUserData(String userData) async {
    await _storage.write(key: ApiConfig.userDataKey, value: userData);
  }

  Future<String?> getUserData() async {
    return await _storage.read(key: ApiConfig.userDataKey);
  }

  Future<void> saveUserId(String userId) async {
    await _storage.write(key: ApiConfig.userIdKey, value: userId);
  }

  Future<String?> getUserId() async {
    return await _storage.read(key: ApiConfig.userIdKey);
  }

  // Clear all data on logout
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
