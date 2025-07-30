import 'package:flutter/material.dart';

class ProverbsScreen extends StatelessWidget {
  const ProverbsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> proverbs = [
      'Sé pa grenn diri ka fè sak diri.',
      'Tout sa ki brilé sé pa lor.',
      'Kannari an dlo pa ka oubliyé difé.',
      'Lanmou pa ni zye, mé li ka wè.',
      'Kouto pa ka koupe palé zanmi.',
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Pawol Kréyol',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ListView.separated(
              itemCount: proverbs.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Text(
                    '"${proverbs[index]}"',
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
