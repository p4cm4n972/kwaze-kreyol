import 'package:flutter/material.dart';
import '../../widgets/creole_background.dart';

class BrokenWordsScreen extends StatelessWidget {
  const BrokenWordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mots cassés Kréyol'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.transparent,
      body: CreoleBackground(
        child: Center(
          child: Text(
            'Mots Cassés Kréyol (à venir)',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ),
    );
  }
}
