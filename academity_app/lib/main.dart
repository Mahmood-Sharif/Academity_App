import 'package:academity_app/views/My%20Academy/my_academy_screen.dart';
import 'package:academity_app/views/Profile/profile_screen.dart';
import 'package:academity_app/views/Schedule/schedule_screen.dart';
import 'package:academity_app/views/auth/home_screen.dart';
import 'package:academity_app/views/auth/signup_screen.dart';
import 'package:academity_app/views/home/browse_sports_screen.dart';
import 'package:academity_app/views/widgets/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:academity_app/services/auth_services.dart';
import 'package:academity_app/views/auth/login_screen.dart';
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
    const secureStorage = FlutterSecureStorage();
    final Future<bool> isLoggedIn =
        secureStorage.read(key: 'api_token').then((apiToken) {
      if (apiToken == null) return false;
      final auth = AuthServices();
      return auth.loginTest();
    });
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

    return MaterialApp(
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
      initialRoute: '/',
      routes: {
         '/': (context) => const HomeScreen(),
        '/login': (context) => FutureBuilder<bool>(
              future: isLoggedIn,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data == false) {
                  return const LoginScreen();
                } else {
                  return const MainScreen();
                }
              },
            ),
        '/browseSports': (context) => const SportsPage(),
            '/signup': (context) => const SignupScreen(),
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = [
    const SportsPage(), // Your actual HomePage widget
    const AcademyPage(), // Your actual AcademyPage widget
    // QRScannerPage(), // Your actual QRScannerPage widget or handle differently
    const SchedulePage(), // Your actual SchedulePage widget
    const ProfilePage(), // Your actual ProfilePage widget
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemSelected: _onItemTapped,
      ),
    );
  }
}
