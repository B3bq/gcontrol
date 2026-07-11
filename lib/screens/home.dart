import 'package:flutter/material.dart';
import 'package:gcontrol/screens/profile.dart';
import 'package:gcontrol/screens/stats.dart';
import 'package:gcontrol/screens/start.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int _currentIndex = 1; // Active index for the bottom navigation bar

  // List of screens corresponding to each tab in the bottom navigation bar
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      const StatsPage(),
      const StartPage(),
      const ProfilePage(),
    ];
  }

  Widget _buildItem(IconData icon, String label, int index) {
    final isSelected = _currentIndex == index;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white.withOpacity(0.2) : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? Colors.white : Colors.white70,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? Colors.white : Colors.white70,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black54,
        body:
        IndexedStack(
          index: _currentIndex,
          children: _screens,
        ),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            splashFactory: NoSplash.splashFactory,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(icon: _buildItem(Icons.stacked_bar_chart_sharp, 'Statistics', 0), label: 'Stats'),
              BottomNavigationBarItem(icon: _buildItem(Icons.home, 'Home', 1), label: 'Home'),
              BottomNavigationBarItem(icon: _buildItem(Icons.account_circle, 'Profile', 2), label: 'Profile'),
            ],
            backgroundColor: Colors.green.shade600,
            elevation: 10,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white70,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
          ),
        )
    );
  }
}