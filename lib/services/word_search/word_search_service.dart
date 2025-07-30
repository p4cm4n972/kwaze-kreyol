import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kwaze_kreyol/services/iam/auth_service.dart';
import 'package:kwaze_kreyol/widgets/word_search_grid.dart';

class WordSearchService {
  final _baseUrl = 'http://localhost:3000/api/word-search-session';

  Future<void> saveGame(WordSearchGameState state) async {
    final token = await AuthService().getToken();
    final res = await http.post(
      Uri.parse('$_baseUrl/save'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'state': state.toJson()}),
    );

    if (res.statusCode != 200) {
      throw Exception('Échec de la sauvegarde');
    }
  }

  Future<WordSearchGameState?> loadGame() async {
    final token = await AuthService().getToken();
    final res = await http.get(
      Uri.parse('$_baseUrl/load/'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return WordSearchGameState.fromJson(data['state']);
    } else {
      return null;
    }
  }
}
