import 'package:flutter/material.dart';
import 'package:kwaze_kreyol/widgets/creole_background.dart';
import '../screens/translator_screen.dart';
import '../screens/games_screen.dart';
import '../screens/quotes_screen.dart';
import '../screens/proverbs_screen.dart';
import '../widgets/creole_bottom_navbar.dart';
import '../widgets/creole_navigation_rail.dart';

class ResponsiveScaffold extends StatefulWidget {
  const ResponsiveScaffold({super.key});

  @override
  State<ResponsiveScaffold> createState() => _ResponsiveScaffoldState();
}

class _ResponsiveScaffoldState extends State<ResponsiveScaffold> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    TranslatorScreen(),
    GamesScreen(),
    QuotesScreen(),
    ProverbsScreen(),
  ];

  final List<NavigationRailDestination> _railDestinations = const [
    NavigationRailDestination(
      icon: Icon(Icons.translate),
      label: Text('Tradui'),
    ),
    NavigationRailDestination(
      icon: Icon(Icons.videogame_asset),
      label: Text('Jwé'),
    ),
    NavigationRailDestination(
      icon: Icon(Icons.format_quote),
      label: Text('Sitasyon'),
    ),
    NavigationRailDestination(
      icon: Icon(Icons.auto_stories),
      label: Text('Pawol'),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final bool isWide = MediaQuery.of(context).size.width >= 800;

    if (isWide) {
      // Web / desktop
      return Scaffold(
        body: Row(
          children: [
            CreoleNavigationRail(
              selectedIndex: _selectedIndex,
              onDestinationSelected: _onItemTapped,
              destinations: _railDestinations,
            ),
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(child: CreoleBackground(child: _screens[_selectedIndex])),
          ],
        ),
      );
    } else {
      // Mobile
      return Scaffold(
        body: CreoleBackground(child: _screens[_selectedIndex]),
        bottomNavigationBar: CreoleBottomNavBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      );
    }
  }
}
