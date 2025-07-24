import 'package:flutter/material.dart';

class CreoleBackground extends StatelessWidget {
  final Widget child;
  const CreoleBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: const Color(0xFFFAF3E0)), // Fond sable/clair
        // Cercle rouge/orangé en haut à gauche
        Positioned(
          top: -100,
          left: -60,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Colors.red.shade300, Colors.orange.shade200],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),

        // Cercle vert/jaune en bas à droite
        Positioned(
          top: 40,
          left: 20,
          child: Image.asset('assets/images/logo-kk.png', width: 120, height: 120),
        ),
        Positioned(
          bottom: -80,
          right: -50,
          child: Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Colors.green.shade300, Colors.yellow.shade200],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
            ),
          ),
        ),

        // Contenu principal
        Padding(padding: const EdgeInsets.all(24.0), child: child),
      ],
    );
  }
}
