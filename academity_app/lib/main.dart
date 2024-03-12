import 'package:academity_app/views/auth/login_screen.dart';
import 'package:academity_app/views/home/browse_all_classes.dart';
import 'package:academity_app/views/home/browse_classes.dart';
import 'package:academity_app/views/home/browse_classes.dart';
import 'package:academity_app/views/home/Attendance.dart';
import 'package:academity_app/views/home/class_students.dart';
import 'package:academity_app/views/home/student_details.dart';
import 'package:academity_app/views/home/widgets/BottomNavigationPage.dart';
//import 'package:academity_app/views/home/browse_sports_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:academity_app/models/student.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
  title: 'Flutter Demo',
  home: BottomNavigationPage(),
  routes: {
    '/browseClasses': (context) => const ClassesPage(), // Make sure BrowseSportsScreen is imported
    '/attendance': (context) => const AtendancePage(),
    '/class_students': (context) => const ClassStudentsPage(),
    '/browse_all_classes': (context) => const AllClassesPage(),
     // ignore: prefer_const_constructors
     '/studentDetails': (context) {
  final student = ModalRoute.of(context)!.settings.arguments as Student;
  return StudentDetailsScreen(student: student);
},

    // other routes...
  },
);

  }
}
