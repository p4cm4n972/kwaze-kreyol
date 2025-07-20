import 'package:flutter/material.dart';
import '../../widgets/word_search_grid.dart';

class WordSearchScreen extends StatefulWidget {
  const WordSearchScreen({super.key});

  @override
  State<WordSearchScreen> createState() => _WordSearchScreenState();
}

class _WordSearchScreenState extends State<WordSearchScreen> {
  late WordSearchGameState _gameState;
  bool _showVictory = false;

  @override
  void initState() {
    super.initState();
    _resetGame();
  }

  void _resetGame() {
    setState(() {
      _showVictory = false;
      _gameState = WordSearchGameState(
        gridSize: 12,
        words: [
          'tjenbé',
          'lavi',
          'fanm',
          'zil',
          'bèl',
          'moun',
          'pawol',
          'solèy',
          'lanmè',
          'koulè',
        ],
      );
    });
  }

  void _onVictory() {
    setState(() => _showVictory = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mots Mélés Kréyol'),
        actions: [
          IconButton(
            onPressed: _resetGame,
            icon: const Icon(Icons.refresh),
            tooltip: 'Recommencer',
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          WordSearchGrid(gameState: _gameState, onAllWordsFound: _onVictory),
          if (_showVictory)
            Container(
              color: Colors.black54,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.celebration, color: Colors.white, size: 80),
                    SizedBox(height: 16),
                    Text(
                      'Bravo ! 🎉',
                      style: TextStyle(fontSize: 28, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
