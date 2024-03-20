
import 'package:academity_app/models/attendance.dart';
import 'package:academity_app/models/postAttendance.dart';
import 'package:academity_app/services/attendance_service.dart';
import 'package:academity_app/views/home/widgets/sport/attendance_griview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AttendanceListWidget extends StatefulWidget {
  final List<Attendance> attendanceList;
final String timeRange;
  const AttendanceListWidget({Key? key, required this.attendanceList, required this.timeRange}) : super(key: key);

  @override
  _AttendanceListWidgetState createState() => _AttendanceListWidgetState();
}

class _AttendanceListWidgetState extends State<AttendanceListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.attendanceList.length,
      itemBuilder: (context, index) {
        final attendance = widget.attendanceList[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              // Handle attendance item tap
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          attendance.studentName.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                           ElevatedButton(
  onPressed: () {
    setState(() {
      // Update the attendance status to 'Present'
      var postAttendance = PostAttendance(studentId: attendance.studentId, dateTime: widget.timeRange, status: "Present");
      print('Calling updateAttendance()');
      attendance.isUpdateSuccess = true;
      AttendanceServices().updateAttendance(postAttendance);
      attendance.status = "Present"; // Update the status in the local data
    });
  },
  style: ElevatedButton.styleFrom(
    primary: attendance.status == 'Present'
      ? Colors.green // Change color if the student is already present
      : Colors.grey, // Default color
  ),
  child: const Text('Present'),
),
const SizedBox(width: 8),
ElevatedButton(
  onPressed: () {
    setState(() {
      // Update the attendance status to 'Absent'
      print('Calling deleteAttendance()');
      attendance.isUpdateSuccess = true;
      AttendanceServices().deleteAttendance(attendance.studentId, widget.timeRange);
      attendance.status = "Absent"; // Update the status in the local data
    });
  },
  style: ElevatedButton.styleFrom(
    primary: attendance.status == 'Absent'
      ? Colors.red // Change color if the student is already absent
      : Colors.grey, // Default color
  ),
  child: const Text('Absent'),
),
                          ],
                        ),
                        const SizedBox(height: 8),
                        if (attendance.isUpdateSuccess != null) // Show message only when isUpdateSuccess is not null
                          Text(
                            attendance.isUpdateSuccess!
                                ? 'Attendance updated successfully'
                                : 'Failed to update attendance',
                            style: TextStyle(
                              color: attendance.isUpdateSuccess!
                                  ? Colors.green
                                  : Colors.red,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}