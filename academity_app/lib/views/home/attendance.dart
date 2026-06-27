import 'dart:async';

import 'package:academity_app/design/app_theme.dart';
import 'package:academity_app/models/attendance.dart';
import 'package:academity_app/services/attendance_service.dart';
import 'package:academity_app/views/home/widgets/sport/attendance_gridview.dart';
import 'package:academity_app/views/utils/adaptive_padding.dart';
import 'package:academity_app/views/widgets/app_bar.dart';
import 'package:academity_app/views/widgets/app_state.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AttendancePage extends StatefulWidget {
  final int classId;
  final DateTime datetime;

  const AttendancePage({
    super.key,
    required this.classId,
    required this.datetime,
  });

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Attendance',
        subtitle: 'Mark presence and share QR code',
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: AdaptivePadding(
          child: FutureBuilder<List<Attendance>>(
            future: AttendanceServices()
                .fetchAttendance(widget.classId, widget.datetime),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const AppLoadingState(label: 'Loading attendance');
              } else if (snapshot.hasError) {
                final error = snapshot.error!;
                if (error.runtimeType == TimeoutException) {
                  return const AppEmptyState(
                    icon: Icons.wifi_off_rounded,
                    title: 'Connection timeout',
                    body:
                        'Please check your internet connection and try again.',
                  );
                }
                return AppErrorState(error: error);
              } else {
                final attendanceList = snapshot.data ?? [];
                return AttendanceListWidget(
                  attendanceList: attendanceList,
                  classId: widget.classId,
                  datetime: widget.datetime,
                );
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final qrCodeData = '{"class_id":${widget.classId}}';
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadii.lg),
              ),
              title: const Text('Class QR Code'),
              content: SizedBox(
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
                  child: const Text('Close'),
                )
              ],
            ),
          );
        },
        icon: const Icon(Icons.qr_code_rounded),
        label: const Text('Show QR'),
      ),
    );
  }
}
