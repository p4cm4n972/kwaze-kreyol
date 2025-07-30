import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const String baseUrl = 'http://localhost:3000/api/auth';

class AuthService {
  static const _tokenKey = 'jwt_token';
  static const _refreshKey = 'refresh_token';
  static const _userKey = 'user_data';

  Future<void> saveAuthData({
    required String accessToken,
    required String refreshToken,
    required Map<String, dynamic> userData,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, accessToken);
    await prefs.setString(_refreshKey, refreshToken);
    await prefs.setString(_userKey, jsonEncode(userData));
  }

  Future<Map<String, dynamic>?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_userKey);
    return jsonString != null ? jsonDecode(jsonString) : null;
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_refreshKey);
    await prefs.remove(_userKey);
  }

  Future<void> logout() async {
    await clearToken();
  }

  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  Future<Map<String, String>> getAuthHeaders() async {
    final token = await getToken();
    return {
      'Content-Type': 'application/json',
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
    };
  }

  Map<String, dynamic> _decodeJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) throw Exception('Invalid token');
    final payload = base64Url.normalize(parts[1]);
    final decoded = utf8.decode(base64Url.decode(payload));
    return jsonDecode(decoded);
  }

  Future<String?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    print('Response status: ${response.statusCode}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      final accessToken = data['accessToken'];
      final refreshToken = data['refreshToken'];
      final decoded = _decodeJwt(accessToken);

      final userData = {
        'pseudo': decoded['pseudo'],
        'id': decoded['id'],
        'email': decoded['email'] ?? '',
        'profilePicture': decoded['profilePicture'] ?? '',
      };

      await saveAuthData(
        accessToken: accessToken,
        refreshToken: refreshToken,
        userData: userData,
      );
      return null;
    } else {
      return 'Erreur de connexion';
    }
  }

  Future<String?> register(String pseudo, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'pseudo': pseudo,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 409) {
      return 'Ce pseudo ou email existe déjà';
    }

    if (response.statusCode == 201 || response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final accessToken = data['accessToken'];
      final refreshToken = data['refreshToken'];
      final decoded = _decodeJwt(accessToken);

      final userData = {
        'pseudo': decoded['pseudo'],
        'id': decoded['id'],
        'email': decoded['email'] ?? '',
        'profilePicture': decoded['profilePicture'] ?? '',
      };

      await saveAuthData(
        accessToken: accessToken,
        refreshToken: refreshToken,
        userData: userData,
      );
      return null;
    } else {
      return 'Erreur lors de l\'inscription';
    }
  }
}
