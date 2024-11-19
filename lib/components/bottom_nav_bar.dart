// bottom_nav_bar.dart
import 'package:flutter/material.dart';

class MyBottomNavBar extends StatelessWidget {
  final Function(int) onTabChange;

  const MyBottomNavBar({Key? key, required this.onTabChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0,
      onTap: onTabChange,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Admin',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'Attendance',
        ),
      ],
    );
  }
}
