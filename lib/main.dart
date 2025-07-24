import 'package:flutter/material.dart';
import 'package:kwaze_kreyol/screens/iam/auth_screen.dart';
import 'package:kwaze_kreyol/screens/profile/profile_screen.dart';
import 'package:kwaze_kreyol/services/iam/auth_service.dart';
import 'package:kwaze_kreyol/widgets/splash_screen.dart';
import 'screens/translator_screen.dart';
import 'screens/games_screen.dart';
import 'screens/quotes_screen.dart';
import 'screens/proverbs_screen.dart';
import 'widgets/creole_background.dart';
import 'widgets/creole_bottom_navbar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const MaterialApp(debugShowCheckedModeBanner: false, home: SplashScreen()),
  );
}

class KwazeKreyolApp extends StatelessWidget {
  final bool isConnected;
  const KwazeKreyolApp({super.key, required this.isConnected});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kwazé Kréyol',
      debugShowCheckedModeBanner: false,
      home: isConnected ? const HomeScreen() : const AuthScreen(),
    );
  }
}

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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfileScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await AuthService().logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const AuthScreen()),
              );
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
