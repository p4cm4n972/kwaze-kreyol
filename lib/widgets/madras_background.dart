import 'package:flutter/material.dart';

class MadrasBackground extends StatelessWidget {
  final Widget child;

  const MadrasBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MadrasPainter(),
      child: Container(padding: const EdgeInsets.all(16), child: child),
    );
  }
}

class MadrasPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final colors = [
      Colors.red.shade300,
      Colors.yellow.shade300,
      Colors.green.shade400,
      Colors.blue.shade300,
    ];

    final paint = Paint()
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke;

    const spacing = 40.0;

    // Lignes verticales
    for (int i = 0; i < size.width / spacing; i++) {
      paint.color = colors[i % colors.length];
      final x = i * spacing;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Lignes horizontales
    for (int j = 0; j < size.height / spacing; j++) {
      paint.color = colors[j % colors.length];
      final y = j * spacing;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
