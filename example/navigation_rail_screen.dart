import 'package:flutter/material.dart';

class NavigationRailScreen extends StatefulWidget {
  @override
  State<NavigationRailScreen> createState() => _NavigationRailScreenState();
}

class _NavigationRailScreenState extends State<NavigationRailScreen> {
  int _selectedIndex = 0;

  Map<String, Map<IconData, IconData>> _map =
      <String, Map<IconData, IconData>>{};

  @override
  void initState() {
    _map = {
      "Dashboard": {Icons.home_outlined: Icons.home},
      "Account": {Icons.person_outline_rounded: Icons.person},
      "Featured List": {
        Icons.featured_play_list_outlined: Icons.featured_play_list_rounded
      },
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Row(
        children: [
          NavigationRail(
            destinations: _destinations(),
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.all,
            backgroundColor: Colors.white,
            selectedIconTheme: const IconThemeData(color: Colors.black),
            unselectedIconTheme: const IconThemeData(color: Colors.black),
            unselectedLabelTextStyle: const TextStyle(color: Colors.black),
            selectedLabelTextStyle: const TextStyle(color: Colors.black),
          ),
          const VerticalDivider(thickness: 1, width: 2),
          Expanded(
            child: Center(
              child: Text('Page Selected: $_selectedIndex'),
            ),
          ),
        ],
      ),
    ));
  }

  /// list of destinations
  List<NavigationRailDestination> _destinations() {
    List<NavigationRailDestination> destinations = [];
    _map.forEach((k, v) => {
          destinations.add(NavigationRailDestination(
            icon: Icon(v.keys.first),
            selectedIcon: Icon(v.keys.last),
            label: Text(k),
          ))
        });

    return destinations;
  }
}
