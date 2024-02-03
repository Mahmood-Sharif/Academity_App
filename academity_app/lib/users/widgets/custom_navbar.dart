import 'package:academity_app/users/home/browse_sports_screen.dart';
import 'package:academity_app/users/profile/profile_screen.dart';
import 'package:flutter/material.dart';


class CustomNavBar extends StatefulWidget {
  final int selectedIndex;
// Add this line

  const CustomNavBar({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  _CustomNavBarState createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const BrowseSportsScreen()), // Update here
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        );
        break;
      // Add more cases for other tabs
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
        // Add more items here
      ],
      currentIndex: widget.selectedIndex,
      onTap: _onItemTapped,
    );
  }
}
