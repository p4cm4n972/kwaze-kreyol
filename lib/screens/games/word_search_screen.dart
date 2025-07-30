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
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 500;

    final uniqueWords = _gameState.words.toSet().toList();

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
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  WordSearchGrid(
                    gameState: _gameState,
                    onAllWordsFound: _onVictory,
                  ),
                ],
              ),
            ),

            if (_showVictory)
              Container(
                color: Colors.black.withOpacity(0.6),
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(2, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.celebration, color: Colors.green, size: 80),
                        SizedBox(height: 16),
                        Text(
                          'Bravo ! 🎉',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
