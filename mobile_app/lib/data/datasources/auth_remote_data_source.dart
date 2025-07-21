import 'package:shared_preferences/shared_preferences.dart';
import '../../core/network/api_client.dart';
import '../models/user_model.dart';
import '../../core/constants/app_config.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> getProfile();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  
  AuthRemoteDataSourceImpl(this.apiClient, this.sharedPreferences);
  
  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final response = await apiClient.post('/auth/login', data: {
        'email': email,
        'password': password,
      });
      
      if (response.statusCode == 200) {
        // Backend returns access_token, not user data directly
        final accessToken = response.data['access_token'];
        if (accessToken != null) {
          // Save token to local storage
          await _saveToken(accessToken);
          
          // Get user profile using the token
          return await getProfile();
        } else {
          throw Exception('Login failed: No access token received');
        }
      } else {
        throw Exception('Login failed: ${response.data['error'] ?? 'Unknown error'}');
      }
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  @override
  Future<UserModel> getProfile() async {
    try {
      final response = await apiClient.get('/profile');
      
      if (response.statusCode == 200) {
        print('Profile response: ${response.data}'); // Debug print
        return UserModel.fromJson(response.data);
      } else {
        throw Exception('Failed to get profile: ${response.data['error'] ?? 'Unknown error'}');
      }
    } catch (e) {
      throw Exception('Failed to get profile: $e');
    }
  }

  Future<void> _saveToken(String token) async {
    await sharedPreferences.setString(AppConfig.tokenKey, token);
    print('[DEBUG] Token yang disimpan: $token'); // Tambahkan baris ini
  }
} 