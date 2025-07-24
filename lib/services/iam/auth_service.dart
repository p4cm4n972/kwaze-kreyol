import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

const String baseUrl = 'http://10.0.2.2:3000/api/auth';

class AuthService {
  static const _tokenKey = 'jwt_token';

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
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

  Future<String?> getPseudoFromToken() async {
    final token = await getToken();
    if (token == null) return null;

    final decodedToken = JwtDecoder.decode(token);
    return decodedToken['pseudo']; // ou autre clé selon ton backend
  }

  Future<String?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);

      final accessToken = data['accessToken'];
      final refreshToken = data['refreshToken'];

      if (accessToken != null && refreshToken != null) {
        await saveToken(accessToken);
        await _saveRefreshToken(refreshToken);
        return null; // succès
      } else {
        return 'Réponse invalide du serveur';
      }
    } else if (response.statusCode == 401) {
      return 'Identifiants incorrects';
    } else {
      print('Login error: ${response.statusCode} => ${response.body}');
      return 'Erreur lors de la connexion';
    }
  }

  Future<void> _saveRefreshToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('refresh_token', token);
  }

  Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('refresh_token');
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

    if (response.statusCode == 201 || response.statusCode == 200) {
      // Pas de token attendu ici car le backend envoie un e-mail de vérification
      return null;
    } else if (response.statusCode == 409) {
      return 'Email ou pseudo déjà utilisé';
    } else if (response.statusCode == 400) {
      final body = jsonDecode(response.body);
      return body['message'] ?? 'Erreur de validation';
    } else {
      print('Register error: ${response.statusCode} => ${response.body}');
      return 'Erreur lors de l\'inscription';
    }
  }

  Future<bool> refreshAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    final refreshToken = prefs.getString('refresh_token');

    if (refreshToken == null || refreshToken.isEmpty) {
      print('Aucun refresh token disponible');
      return false;
    }

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/refresh'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'refreshToken': refreshToken}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final newAccessToken = data['accessToken'];
        final newRefreshToken = data['refreshToken'];

        if (newAccessToken != null) {
          await saveToken(newAccessToken);
          if (newRefreshToken != null) {
            await _saveRefreshToken(newRefreshToken);
          }
          print('Access token mis à jour');
          return true;
        }
      } else {
        print('Échec de la mise à jour du token : ${response.body}');
      }
    } catch (e) {
      print('Erreur réseau lors du refresh token: $e');
    }

    return false;
  }
}
