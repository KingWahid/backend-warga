import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../../core/constants/app_config.dart';

abstract class AuthLocalDataSource {
  Future<void> saveUser(UserModel user);
  Future<UserModel?> getUser();
  Future<void> clearUser();
  Future<bool> isLoggedIn();
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> clearToken();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;
  
  AuthLocalDataSourceImpl(this.sharedPreferences);
  
  @override
  Future<void> saveUser(UserModel user) async {
    await sharedPreferences.setString(AppConfig.userKey, jsonEncode(user.toJson()));
  }
  
  @override
  Future<UserModel?> getUser() async {
    final userJson = sharedPreferences.getString(AppConfig.userKey);
    if (userJson != null) {
      return UserModel.fromJson(jsonDecode(userJson));
    }
    return null;
  }
  
  @override
  Future<void> clearUser() async {
    await sharedPreferences.remove(AppConfig.userKey);
  }
  
  @override
  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null;
  }
  
  @override
  Future<void> saveToken(String token) async {
    await sharedPreferences.setString(AppConfig.tokenKey, token);
  }
  
  @override
  Future<String?> getToken() async {
    return sharedPreferences.getString(AppConfig.tokenKey);
  }
  
  @override
  Future<void> clearToken() async {
    await sharedPreferences.remove(AppConfig.tokenKey);
  }
} 