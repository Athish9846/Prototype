import 'package:flutter/material.dart';
import 'package:prototype/components/bottom_nav_bar.dart';
import 'package:prototype/view/admin/admin.dart';
import 'package:prototype/view/admin/attendence/attendencepage.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  // navigation bottomBar
  int _selectedIndex = 0;
  // final currentIndex = _selectedIndex;

  //pages
  final List<Widget> bottomNavPages = [
    const AdminPage(),
    const AttendencePage()
  ];

  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Navigator.push(context, MaterialPageRoute(builder: (ctx)=>bottomNavPages[index]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: bottomNavPages[_selectedIndex],
        bottomNavigationBar: MyBottomNavBar(
          onTabChange: (index) {
            navigateBottomBar(index);
          },
        ));
  }
}
