import 'package:academity_app/models/attendance.dart';
import 'package:academity_app/services/attendance_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AttendanceListWidget extends StatefulWidget {
  final List<Attendance> attendanceList;
  final int classId;
  final DateTime datetime;

  const AttendanceListWidget(
      {Key? key,
      required this.attendanceList,
      required this.classId,
      required this.datetime})
      : super(key: key);

  @override
  State<AttendanceListWidget> createState() => _AttendanceListWidgetState();
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
                  BoxShadow(blurRadius: 0.2),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // Align children to the start and end of the row
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        attendance.studentName.toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (attendance.isUpdateSuccess !=
                          null) // Show message only when isUpdateSuccess is not null
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
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (attendance.status != 'Present') {
                              // Update the attendance status to 'Present'
                              AttendanceServices().postAttendance(
                                attendance.studentId,
                                widget.classId,
                                'Present',
                                widget.datetime,
                              );
                              attendance.status =
                                  "Present"; // Update the status in the local data
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: attendance.status == 'Present'
                              ? const Color(
                                  0xFF008B8B) // Change color if the student is already present
                              : Colors.white, // Default color
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                  10), // Specify the top-left corner
                              bottomLeft: Radius.circular(
                                  10), // Specify the bottom-left corner
                              topRight: Radius.circular(
                                  0), // Specify no rounding for the top-right corner
                              bottomRight: Radius.circular(
                                  0), // Specify no rounding for the bottom-right corner
                            ),
                          ),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.presentButton,
                          style: TextStyle(
                            color: attendance.status == 'Present'
                                ? Colors
                                    .white // Change color if the student is already present
                                : const Color(
                                    0xFF008B8B), // Set text color to white
                          ),
                        ),
                      ),
                      //const SizedBox(width: 8), // Add spacing between buttons
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            //attendance.isUpdateSuccess = true;
                            AttendanceServices().postAttendance(
                              attendance.studentId,
                              widget.classId,
                              'Absent',
                              widget.datetime,
                            );
                            attendance.status =
                                "Absent"; // Update the status in the local data
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: attendance.status == 'Absent'
                              ? const Color(
                                  0xFF8B0000) // Change color if the student is already absent
                              : Colors.white, // Default color
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                  0), // Specify no rounding for the top-left corner
                              bottomLeft: Radius.circular(
                                  0), // Specify no rounding for the bottom-left corner
                              topRight: Radius.circular(
                                  10), // Specify the top-right corner
                              bottomRight: Radius.circular(
                                  10), // Specify the bottom-right corner
                            ),
                          ),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.absentButton,
                          style: TextStyle(
                            color: attendance.status == 'Absent'
                                ? Colors
                                    .white // Change color if the student is already present
                                : const Color(
                                    0xFF8B0000), // Set text color to white
                          ),
                        ),
                      ),
                    ],
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
