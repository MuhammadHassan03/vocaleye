import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:vocaleye/Screens/object.dart';
import 'package:vocaleye/Screens/social.dart';
import 'package:vocaleye/Screens/speech.dart';
// Screens
// import '../Screens/Chat.dart';
import '../Screens/profile.dart';
import '../Screens/home.dart';
// import '../Screens/profile.dart';
// import '../Screens/home.dart';
// import '../Screens/chat.dart';

class Navigationbar extends StatefulWidget {
  const Navigationbar({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<Navigationbar> {
  int _selectedIndex = 0;
  late PageController _pageController;

  static final List<Widget> _widgetOptions = <Widget>[
    home(),
    object(),
    speech(),
    social(),
    Profile(),
  ];

  @override
  void initState() {
    super.initState();
    // Initialize the PageController here to avoid the LateInitializationError
    _pageController = PageController(initialPage: _selectedIndex);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index); // Jump to the selected page
  }

  // When the user swipes between pages, update the selected index
  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged, // Listen to page changes
        children: _widgetOptions,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,  // Background of the body
        color: Colors.white,  // Navigation bar color
        buttonBackgroundColor: Color(0xFF0068CB),
        height: 65,
        animationDuration: const Duration(milliseconds: 300),
        animationCurve: Curves.easeInOut,
        index: _selectedIndex,

        items: <Widget>[
          _buildNavItem(Icons.fmd_good, 'Map', 0),
          _buildNavItem(Icons.settings_overscan, 'Detaction', 1),
          _buildNavItem(Icons.mic, 'Speech', 2),
          _buildNavItem(Icons.people, 'Social', 3),
          _buildNavItem(Icons.person, 'Profile', 4),
        ],

        onTap: _onItemTapped, // Handle item tap from bottom navigation
      ),
    );
  }


  Widget _buildNavItem(IconData icon, String label, int index) {

    final isSelected = _selectedIndex == index;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 30, color: isSelected ? Colors.white : Colors.black,),
        if (_selectedIndex != index)
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
      ],
    );
  }

}


