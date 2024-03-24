import 'package:academity_app/models/attendance.dart';
import 'package:academity_app/services/attendance_service.dart';
import 'package:academity_app/views/home/widgets/sport/Attendance_griview.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
      body: LayoutBuilder(
        builder: (context, constraints) {
          return FutureBuilder<List<Attendance>>(
            future: AttendanceServices().fetchAttendance(widget.classId, widget.timeRange, widget.timeRange),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                final attendanceList = snapshot.data!;
                return Expanded(
                  child: AttendanceListWidget(
                    attendanceList: attendanceList,
                    timeRange: widget.timeRange,
                  ),
                );
              }
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          String qrCodeData = '{"classId": ${widget.classId}, "timeRange": "${widget.timeRange}"}';
          // Show the QR code using a dialog
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Class QR Code'),
              content: Center(
                child: SizedBox( // Wrap QrImage with SizedBox for constraints
                  width: 320,
                  height: 320,
                  child: QrImageView(
                    data: qrCodeData,
                    version: QrVersions.auto,
                  ),
                ),
              ),
            ),
          );
        },
        child: Icon(Icons.qr_code_scanner),
      ),
    );
  }
}
