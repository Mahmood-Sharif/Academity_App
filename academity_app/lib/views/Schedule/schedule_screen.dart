import 'package:academity_app/models/class_schedule.dart';
import 'package:academity_app/views/utils/adaptive_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:academity_app/views/widgets/app_bar.dart'; // Adjust the path as needed
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SchedulePage extends ConsumerStatefulWidget {
  /// A future provider for schedule.
  ///
  /// E.g. `scheduleForStudentProvider` or `scheduleForCoachProvider`
  final FutureProviderFamily<List<ClassSchedule>,
      ({DateTime fromDate, DateTime toDate})> scheduleProvider;

  /// Function to call when clicking on a schedule item
  final Function(ClassSchedule)? onTap;

  /// Number of days before today to show
  final int daysBefore;

  /// Number of days after today to show
  final int daysAfter;

  const SchedulePage(
      {super.key,
      required this.scheduleProvider,
      required this.daysBefore,
      required this.daysAfter,
      this.onTap});

  @override
  ConsumerState<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends ConsumerState<SchedulePage> {
  final listKey = GlobalKey();
  DateTime _selectedDay = DateTime.now();
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final startDate = today.subtract(Duration(days: widget.daysBefore));
    final endDate = today.add(Duration(days: widget.daysAfter));
    final scheduleAsyncValue = ref.watch(widget.scheduleProvider((
      fromDate: DateTime(startDate.year, startDate.month, startDate.day),
      toDate: DateTime(endDate.year, endDate.month, endDate.day),
    )));
    const dateButtonWidth = 70.0;
    const dateButtonGap = 16;

    return Scaffold(
      appBar: CustomAppBar(title: AppLocalizations.of(context)!.scheduleTitle),
      body: AdaptivePadding(
        child: Column(
          children: [
            SizedBox(
              height: 80,
              child: ListView.builder(
                key: listKey,
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: widget.daysBefore + widget.daysAfter + 1,
                itemBuilder: (context, index) {
                  final date = DateTime.now()
                      .subtract(Duration(days: widget.daysBefore))
                      .add(Duration(days: index));
                  final isSelected = _selectedDay.year == date.year &&
                      _selectedDay.month == date.month &&
                      _selectedDay.day == date.day;

                  if (isSelected) {
                    final center = listKey.currentContext!
                            .findRenderObject()!
                            .paintBounds
                            .width /
                        2;
                    const totalWidth = dateButtonWidth + dateButtonGap;
                    scrollController.animateTo(
                      index * totalWidth - center + (totalWidth / 2),
                      duration: const Duration(seconds: 1),
                      curve: Curves.fastOutSlowIn,
                    );
                  }

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedDay = date;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.all(dateButtonGap / 2),
                      decoration: BoxDecoration(
                        color:
                            isSelected ? const Color(0xFF008B8B) : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      width: dateButtonWidth,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${date.day}/${date.month}',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color:
                                    isSelected ? Colors.white : Colors.black),
                          ),
                          Text(
                            _getDayOfWeek(date.weekday),
                            style: TextStyle(
                                fontSize: 16,
                                color:
                                    isSelected ? Colors.white : Colors.black),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: scheduleAsyncValue.when(
                data: (schedule) {
                  final filtered = schedule
                      .where((element) =>
                          DateTime.parse(element.date) ==
                          DateTime(_selectedDay.year, _selectedDay.month,
                              _selectedDay.day))
                      .toList();
                  return ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final classDetails = filtered[index];
                      return Card(
                        child: InkWell(
                          onTap: () => widget.onTap?.call(filtered[index]),
                          child: ListTile(
                            title: Text(classDetails.className),
                            subtitle: Text(
                                '${AppLocalizations.of(context)!.timeLabel} ${classDetails.startTime} - ${classDetails.endTime}\n${classDetails.location}'),
                          ),
                        ),
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(child: Text('Error: $error')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getDayOfWeek(int weekday) {
    switch (weekday) {
      case 1:
        return AppLocalizations.of(context)!.dayOfWeekMon;
      case 2:
        return AppLocalizations.of(context)!.dayOfWeekTue;
      case 3:
        return AppLocalizations.of(context)!.dayOfWeekWed;
      case 4:
        return AppLocalizations.of(context)!.dayOfWeekThu;
      case 5:
        return AppLocalizations.of(context)!.dayOfWeekFri;
      case 6:
        return AppLocalizations.of(context)!.dayOfWeekSat;
      case 7:
        return AppLocalizations.of(context)!.dayOfWeekSun;
      default:
        return '';
    }
  }
}
