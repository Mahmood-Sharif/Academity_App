
import 'package:academity_app/models/attendance.dart';

import 'package:academity_app/services/attendance_service.dart';

import 'package:academity_app/views/home/widgets/sport/Attendance_griview.dart';
import 'package:flutter/material.dart';

class AttendancePage extends StatefulWidget {
  final int classId;
  final String timeRange;
  const AttendancePage({Key? key, required this.classId, required this.timeRange}) : super(key: key);

  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF8B0000), // Set the background color to dark red
        iconTheme: IconThemeData(color: Colors.white),
        flexibleSpace: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Attendance',
              style: TextStyle(
                color: Colors.white, // Set the text color to white
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<Attendance>>(
        future: AttendanceServices().fetchAttendance(widget.classId, widget.timeRange, widget.timeRange),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final attendanceList = snapshot.data!;
            return AttendanceListWidget(attendanceList: attendanceList, timeRange: widget.timeRange,);
          }
        },
      ),
    );
  }
}