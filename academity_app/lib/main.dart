import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:academity_app/services/auth_services.dart';
import 'package:academity_app/views/home/browse_all_classes.dart';
import 'package:academity_app/views/home/browse_classes.dart';
import 'package:academity_app/views/home/Attendance.dart';
import 'package:academity_app/views/home/class_students.dart';
import 'package:academity_app/views/home/widgets/BottomNavigationPage.dart';
import 'package:google_fonts/google_fonts.dart';


void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const secureStorage = FlutterSecureStorage();
    final Future<bool> isLoggedIn =
        secureStorage.read(key: 'api_token').then((apiToken) {
      if (apiToken == null) return false;
      final auth = AuthServices();
      return auth.loginTest();
    });
    return  MaterialApp(
  title: 'Academity',
   theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
        appBarTheme: AppBarTheme(
          iconTheme: const IconThemeData(color: Colors.white),
          titleTextStyle: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
  home: BottomNavigationPage(),
  routes: {
    
    '/attendance': (context) => AttendancePage(classId: 1, timeRange: '',),
    '/browse_all_classes': (context) => const AllClassesPage(academyId: 1, name: '',),
    '/class_students': (context) => const ClassStudentsPage(classId: 1, className: ""),
    '/browseClasses': (context) => const ClassesPage(), 
    // other routes...
  },
);

  }
}
