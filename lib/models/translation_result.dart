class TranslationResult {
  final String mot;
  final String traduction;
  final String exemple;

  TranslationResult({
    required this.mot,
    required this.traduction,
    required this.exemple,
  });

  factory TranslationResult.fromJson(Map<String, dynamic> json) {
    return TranslationResult(
      mot: json['mot'] ?? '',
      traduction: json['traduction'] ?? '',
      exemple: json['exemple'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'mot': mot, 'traduction': traduction, 'exemple': exemple};
  }
}
