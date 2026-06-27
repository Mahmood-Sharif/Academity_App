import 'package:academity_app/design/app_theme.dart';
import 'package:academity_app/models/attendance.dart';
import 'package:academity_app/services/attendance_service.dart';
import 'package:academity_app/views/widgets/app_card.dart';
import 'package:academity_app/views/widgets/app_state.dart';
import 'package:flutter/material.dart';
import 'package:academity_app/l10n/app_localizations.dart';

class AttendanceListWidget extends StatefulWidget {
  final List<Attendance> attendanceList;
  final int classId;
  final DateTime datetime;

  const AttendanceListWidget({
    super.key,
    required this.attendanceList,
    required this.classId,
    required this.datetime,
  });

  @override
  State<AttendanceListWidget> createState() => _AttendanceListWidgetState();
}

class _AttendanceListWidgetState extends State<AttendanceListWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.attendanceList.isEmpty) {
      return const AppEmptyState(
        icon: Icons.fact_check_outlined,
        title: 'No attendance roster',
        body:
            'Students will appear here when the class has active enrollments.',
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 96),
      itemCount: widget.attendanceList.length,
      separatorBuilder: (context, index) =>
          const SizedBox(height: AppSpacing.md),
      itemBuilder: (context, index) {
        final attendance = widget.attendanceList[index];
        final present = attendance.status == 'Present';
        final absent = attendance.status == 'Absent';

        return AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: present
                        ? AppColors.success.withValues(alpha: .12)
                        : absent
                            ? AppColors.danger.withValues(alpha: .12)
                            : AppColors.line,
                    child: Icon(
                      present
                          ? Icons.check_rounded
                          : absent
                              ? Icons.close_rounded
                              : Icons.person_rounded,
                      color: present
                          ? AppColors.success
                          : absent
                              ? AppColors.danger
                              : AppColors.muted,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Text(
                      attendance.studentName.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: _AttendanceButton(
                      label: AppLocalizations.of(context)!.presentButton,
                      selected: present,
                      selectedColor: AppColors.success,
                      onPressed: () => _mark(attendance, 'Present'),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: _AttendanceButton(
                      label: AppLocalizations.of(context)!.absentButton,
                      selected: absent,
                      selectedColor: AppColors.danger,
                      onPressed: () => _mark(attendance, 'Absent'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _mark(Attendance attendance, String status) {
    setState(() {
      AttendanceServices().postAttendance(
        attendance.studentId,
        widget.classId,
        status,
        widget.datetime,
      );
      attendance.status = status;
    });
  }
}

class _AttendanceButton extends StatelessWidget {
  final String label;
  final bool selected;
  final Color selectedColor;
  final VoidCallback onPressed;

  const _AttendanceButton({
    required this.label,
    required this.selected,
    required this.selectedColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: selected ? selectedColor : Colors.white,
        foregroundColor: selected ? Colors.white : selectedColor,
        side: BorderSide(color: selectedColor.withValues(alpha: .55)),
      ),
      child: Text(label),
    );
  }
}
