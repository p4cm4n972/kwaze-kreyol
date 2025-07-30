import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WordSearchGameState {
  final int gridSize;
  final List<String> words;
  late List<List<String>> grid;
  final Map<String, List<String>> wordPositions = {};
  final Set<String> selectedCoordinates = {};
  final Set<String> correctWords = {};
  final Set<String> lockedCoordinates = {};

  WordSearchGameState({required this.gridSize, required this.words}) {
    _generateGrid();
  }

  final _random = Random();

  void _generateGrid() {
    grid = List.generate(gridSize, (_) => List.filled(gridSize, ''));

    for (final word in words) {
      _placeWord(word.toUpperCase());
    }

    for (var i = 0; i < gridSize; i++) {
      for (var j = 0; j < gridSize; j++) {
        if (grid[i][j].isEmpty) {
          grid[i][j] = String.fromCharCode(_random.nextInt(26) + 65);
        }
      }
    }
  }

  void _placeWord(String word) {
    final directions = [
      const Offset(1, 0),
      const Offset(0, 1),
      const Offset(1, 1),
      const Offset(-1, 1),
    ];

    for (int attempts = 0; attempts < 100; attempts++) {
      final dir = directions[_random.nextInt(directions.length)];
      final dx = dir.dx.toInt();
      final dy = dir.dy.toInt();
      final row = dx < 0
          ? _random.nextInt(gridSize - word.length)
          : _random.nextInt(gridSize);
      final col = dy < 0
          ? _random.nextInt(gridSize - word.length)
          : _random.nextInt(gridSize);

      if (row + dy * word.length >= gridSize ||
          row + dy * word.length < 0 ||
          col + dx * word.length >= gridSize ||
          col + dx * word.length < 0) continue;

      bool canPlace = true;
      for (int i = 0; i < word.length; i++) {
        final r = row + dy * i;
        final c = col + dx * i;
        if (grid[r][c].isNotEmpty && grid[r][c] != word[i]) {
          canPlace = false;
          break;
        }
      }

      if (canPlace) {
        final positions = <String>[];
        for (int i = 0; i < word.length; i++) {
          final r = row + dy * i;
          final c = col + dx * i;
          grid[r][c] = word[i];
          positions.add('$r:$c');
        }
        wordPositions[word] = positions;
        return;
      }
    }
  }

  bool toggleCell(int row, int col) {
    final key = '$row:$col';
    if (lockedCoordinates.contains(key)) return false;
    if (selectedCoordinates.contains(key)) {
      selectedCoordinates.remove(key);
    } else {
      selectedCoordinates.add(key);
    }
    return _checkForMatch();
  }

  bool _checkForMatch() {
    bool foundNewWord = false;
    for (final entry in wordPositions.entries) {
      final word = entry.key;
      final coords = entry.value;
      if (!correctWords.contains(word) &&
          selectedCoordinates.containsAll(coords)) {
        correctWords.add(word);
        lockedCoordinates.addAll(coords);
        HapticFeedback.mediumImpact();
        foundNewWord = true;
      }
    }
    return foundNewWord;
  }

  bool isFinished() => correctWords.length == words.length;
}

class WordSearchGrid extends StatefulWidget {
  final WordSearchGameState gameState;
  final VoidCallback? onAllWordsFound;

  const WordSearchGrid({
    super.key,
    required this.gameState,
    this.onAllWordsFound,
  });

  @override
  State<WordSearchGrid> createState() => _WordSearchGridState();
}

class _WordSearchGridState extends State<WordSearchGrid> {
  @override
  Widget build(BuildContext context) {
    final size = widget.gameState.gridSize;
    final screenSize = MediaQuery.of(context).size;
    final shortestSide = min(screenSize.width, screenSize.height * 0.65);
    final cellSize = shortestSide / size;

    return Column(
      children: [
        GestureDetector(
          onPanStart: (details) => _handleTouch(details.localPosition, cellSize),
          onPanUpdate: (details) => _handleTouch(details.localPosition, cellSize),
          child: SizedBox(
            height: cellSize * size,
            width: cellSize * size,
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: size * size,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: size,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                final row = index ~/ size;
                final col = index % size;
                final letter = widget.gameState.grid[row][col];
                final key = '$row:$col';
                final isHighlighted = widget.gameState.selectedCoordinates.contains(key);
                final isLocked = widget.gameState.lockedCoordinates.contains(key);

                return Container(
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    gradient: isLocked
                        ? const LinearGradient(colors: [Colors.green, Colors.teal])
                        : isHighlighted
                            ? const LinearGradient(colors: [Colors.orange, Colors.yellow])
                            : const LinearGradient(colors: [Colors.white, Colors.grey]),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 2,
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      letter,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: widget.gameState.words.map((word) {
            final isFound = widget.gameState.correctWords.contains(word.toUpperCase());
            return Chip(
              label: Text(
                word,
                style: TextStyle(
                  color: isFound ? Colors.green[900] : Colors.black87,
                  fontWeight: isFound ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              backgroundColor: isFound ? Colors.green[100] : Colors.orange[100],
              side: const BorderSide(color: Colors.black26),
              elevation: 2,
              shadowColor: Colors.grey.shade400,
            );
          }).toList(),
        ),
      ],
    );
  }

  void _handleTouch(Offset position, double cellSize) {
    final dx = position.dx ~/ cellSize;
    final dy = position.dy ~/ cellSize;
    if (dx >= 0 &&
        dx < widget.gameState.gridSize &&
        dy >= 0 &&
        dy < widget.gameState.gridSize) {
      final updated = widget.gameState.toggleCell(dy, dx);
      setState(() {});
      if (updated && widget.gameState.isFinished()) {
        widget.onAllWordsFound?.call();
      }
    }
  }
}
