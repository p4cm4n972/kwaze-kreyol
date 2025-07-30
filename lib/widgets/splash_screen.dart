import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:kwaze_kreyol/services/iam/auth_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _navigate());
  }

  Future<void> _navigate() async {
    final player = AudioPlayer();
    await player.play(AssetSource('sounds/tambour_intro_2s.mp3'));
    await Future.delayed(const Duration(seconds: 2));

    final isConnected = await AuthService().isLoggedIn();
    if (!mounted) return;
    context.go(isConnected ? '/home' : '/auth');
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.orange,
      body: Center(
        child: Image(
          image: AssetImage('assets/images/logo-kk.png'),
          width: 150,
        ),
      ),
    );
  }
}
