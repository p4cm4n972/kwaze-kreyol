import 'package:flutter/material.dart';

class CreoleNavigationRail extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onDestinationSelected;
  final List<NavigationRailDestination> destinations;

  const CreoleNavigationRail({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.destinations,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF00B5E2), Color(0xFF0088C7)], // lagon profond
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: NavigationRail(
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationSelected,
        labelType: NavigationRailLabelType.all,
        backgroundColor: Colors.transparent,
        selectedIconTheme: const IconThemeData(color: Colors.white, size: 30),
        unselectedIconTheme: const IconThemeData(
          color: Colors.white70,
          size: 24,
        ),
        selectedLabelTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelTextStyle: const TextStyle(color: Colors.white70),
        destinations: destinations,
      ),
    );
  }
}
