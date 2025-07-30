// main.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:kwaze_kreyol/app_router.dart';
import 'package:kwaze_kreyol/screens/games_screen.dart';
import 'package:kwaze_kreyol/screens/proverbs_screen.dart';
import 'package:kwaze_kreyol/screens/quotes_screen.dart';
import 'package:kwaze_kreyol/screens/translator_screen.dart';
import 'package:kwaze_kreyol/services/iam/auth_service.dart';
import 'package:kwaze_kreyol/widgets/creole_background.dart';
import 'package:kwaze_kreyol/widgets/creole_bottom_navbar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Empêche le plein écran forcé (affiche les barres système)
  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
  );

  runApp(const KwazeKreyolApp());
}

class KwazeKreyolApp extends StatelessWidget {
  const KwazeKreyolApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Kwazé Kréyol',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}

// HomeScreen reste inchangé

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    TranslatorScreen(),
    GamesScreen(),
    QuotesScreen(),
    ProverbsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CreoleBackground(child: _screens[_selectedIndex]),
      appBar: AppBar(
        title: const Text('Kwazé Kréyol'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              context.push('/profile');
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await AuthService().logout();
              context.go('/auth');
            },
          ),
        ],
      ),
      bottomNavigationBar: CreoleBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
