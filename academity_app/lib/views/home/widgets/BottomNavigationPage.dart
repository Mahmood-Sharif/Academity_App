import 'package:academity_app/views/home/browse_academies.dart';
import 'package:academity_app/views/home/browse_classes.dart';
import 'package:academity_app/views/home/class_students.dart';
import 'package:flutter/material.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({Key? key}) : super(key: key);

  @override
  _BottomNavigationPageState createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    ClassesPage(),
    AcademiesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color(0xFF8B0000),
        //title: const Text('Bottom Navigation Demo'),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Students',
          ),
          /*BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),*/
        ],
      ),
    );
  }
}