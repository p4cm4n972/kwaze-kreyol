import 'package:flutter/material.dart';
import '../../widgets/creole_background.dart';

class ScrabbleScreen extends StatelessWidget {
  const ScrabbleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scrabble Kréyol'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.transparent,
      body: CreoleBackground(
        child: Center(
          child: Text(
            'Scrabble Kréyol (à venir)',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ),
    );
  }
}
