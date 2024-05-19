import 'dart:async';

import 'package:academity_app/models/attendance.dart';
import 'package:academity_app/services/attendance_service.dart';
import 'package:academity_app/views/home/widgets/sport/attendance_gridview.dart';
import 'package:academity_app/views/utils/adaptive_padding.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AttendancePage extends StatefulWidget {
  final int classId;
  final DateTime datetime;
  const AttendancePage(
      {super.key, required this.classId, required this.datetime});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            const Color(0xFF8B0000), // Set the background color to dark red
        iconTheme: const IconThemeData(color: Colors.white),
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
          return RefreshIndicator(
            onRefresh: () async {
              setState(() {});
            },
            child: AdaptivePadding(
              child: FutureBuilder<List<Attendance>>(
                future: AttendanceServices()
                    .fetchAttendance(widget.classId, widget.datetime),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    final error = snapshot.error!;
                    if (error.runtimeType == TimeoutException) {
                      return const Center(
                        child: Text(
                          'Connection Timeout.\nPlease check your internet connection.',
                          maxLines: 5,
                        ),
                      );
                    } else {
                      return Center(child: Text('Error: $error'));
                    }
                  } else {
                    final attendanceList = snapshot.data!;
                    return AttendanceListWidget(
                      attendanceList: attendanceList,
                      classId: widget.classId,
                      datetime: widget.datetime,
                    );
                  }
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          String qrCodeData = '{"classId":${widget.classId}}';
          // Show the QR code using a dialog
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Class QR Code'),
              content: SizedBox(
                // Wrap QrImage with SizedBox for constraints
                width: 320,
                height: 320,
                child: QrImageView(
                  data: qrCodeData,
                  version: QrVersions.auto,
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Close'))
              ],
            ),
          );
        },
        child: const Icon(Icons.qr_code_scanner),
      ),
    );
  }
}
