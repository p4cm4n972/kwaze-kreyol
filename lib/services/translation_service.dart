import 'dart:async';
import '../models/translation_result.dart';

class TranslationService {
  // ⚠️ MOCK DE DONNÉES
  final Map<String, Map<String, String>> _dictionnaire = {
    'chat': {'traduction': 'chat', 'exemple': 'Chat-la ka dòmi anlè chèr-la.'},
    'chien': {'traduction': 'chen', 'exemple': 'Chen-an ka wouflé fò.'},
    'maison': {
      'traduction': 'kaz',
      'exemple': 'Mwen ka alé adan kaz manman mwen.',
    },
    'voiture': {'traduction': 'loto', 'exemple': 'Loto-a paré pou pati.'},
    'enfant': {
      'traduction': 'ti moun',
      'exemple': 'Ti moun-an ka jwé dan lakou-a.',
    },
    'cabri': {'traduction': 'kabrit', 'exemple': 'Kabrit-la ka mandé manjé.'},
    'bonjour': {'traduction': 'bonjou', 'exemple': 'Bonjou, kijan ou yé ?'},
    'merci': {'traduction': 'mèsi', 'exemple': 'Mèsi pou sa ou fè.'},
    'femme': {
      'traduction': 'fanm',
      'exemple': 'Fanm-lan ka palé épi nonm-lan.',
    },
    'homme': {'traduction': 'nonm', 'exemple': 'Nonm-lan ka maché vit.'},
  };

  Future<TranslationResult> traduire(String mot) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final lower = mot.trim().toLowerCase();
    final entry = _dictionnaire[lower];

    return TranslationResult(
      mot: mot,
      traduction: entry?['traduction'] ?? '(??? pas trouvé)',
      exemple: entry?['exemple'] ?? '',
    );
  }
}
