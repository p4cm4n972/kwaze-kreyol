import 'package:flutter/material.dart';
import 'package:kwaze_kreyol/screens/iam/auth_screen.dart';
import 'package:kwaze_kreyol/services/iam/auth_service.dart';
import 'package:audioplayers/audioplayers.dart';
import '../main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );

    _controller.forward();

    _navigate();
  }

  Future<void> _navigate() async {
    final player = AudioPlayer();
    await player.play(AssetSource('sounds/tambour_intro_2s.mp3'));

    await Future.delayed(const Duration(seconds: 2));
    final isConnected = await AuthService().isLoggedIn();

    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => isConnected ? const HomeScreen() : const AuthScreen(),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[50],
      body: Center(
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Image.asset('assets/images/logo-kk.png', width: 150),
        ),
      ),
    );
  }
}
