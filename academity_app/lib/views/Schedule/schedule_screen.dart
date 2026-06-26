import 'package:academity_app/models/class_schedule.dart';
import 'package:academity_app/views/utils/adaptive_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:academity_app/views/widgets/app_bar.dart';
import 'package:academity_app/l10n/app_localizations.dart';

class SchedulePage extends ConsumerStatefulWidget {
  final FutureProviderFamily<List<ClassSchedule>,
      ({DateTime fromDate, DateTime toDate})> scheduleProvider;

  final Function(ClassSchedule)? onTap;
  final int daysBefore;
  final int daysAfter;

  const SchedulePage({
    super.key,
    required this.scheduleProvider,
    required this.daysBefore,
    required this.daysAfter,
    this.onTap,
  });

  @override
  ConsumerState<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends ConsumerState<SchedulePage> {
  DateTime _selectedDay = DateTime.now();
  final ScrollController scrollController = ScrollController();

  static const double dateButtonWidth = 70.0;
  static const double dateButtonGap = 16.0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedDay();
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _scrollToSelectedDay() {
    if (!scrollController.hasClients) return;

    final selectedIndex = widget.daysBefore;
    const totalWidth = dateButtonWidth + dateButtonGap;

    final viewportWidth = scrollController.position.viewportDimension;
    final targetOffset =
        selectedIndex * totalWidth - (viewportWidth / 2) + (totalWidth / 2);

    final maxScroll = scrollController.position.maxScrollExtent;
    final safeOffset = targetOffset.clamp(0.0, maxScroll);

    scrollController.animateTo(
      safeOffset,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutCubic,
    );
  }

  void _scrollToIndex(int index) {
    if (!scrollController.hasClients) return;

    const totalWidth = dateButtonWidth + dateButtonGap;

    final viewportWidth = scrollController.position.viewportDimension;
    final targetOffset =
        index * totalWidth - (viewportWidth / 2) + (totalWidth / 2);

    final maxScroll = scrollController.position.maxScrollExtent;
    final safeOffset = targetOffset.clamp(0.0, maxScroll);

    scrollController.animateTo(
      safeOffset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final startDate = today.subtract(Duration(days: widget.daysBefore));
    final endDate = today.add(Duration(days: widget.daysAfter));

    final scheduleAsyncValue = ref.watch(widget.scheduleProvider((
      fromDate: DateTime(startDate.year, startDate.month, startDate.day),
      toDate: DateTime(endDate.year, endDate.month, endDate.day),
    )));

    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.scheduleTitle,
      ),
      body: AdaptivePadding(
        child: Column(
          children: [
            SizedBox(
              height: 80,
              child: ListView.builder(
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: widget.daysBefore + widget.daysAfter + 1,
                itemBuilder: (context, index) {
                  final date = DateTime.now()
                      .subtract(Duration(days: widget.daysBefore))
                      .add(Duration(days: index));

                  final isSelected = _isSameDay(_selectedDay, date);

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedDay = date;
                      });

                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        _scrollToIndex(index);
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
                            color: Colors.grey.withValues(alpha: 0.5),
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
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                          Text(
                            _getDayOfWeek(date.weekday),
                            style: TextStyle(
                              fontSize: 16,
                              color: isSelected ? Colors.white : Colors.black,
                            ),
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
                  final filtered = schedule.where((element) {
                    final elementDate = DateTime.parse(element.date);
                    return _isSameDay(elementDate, _selectedDay);
                  }).toList();

                  if (filtered.isEmpty) {
                    return Center(
                      child: Text(
                        AppLocalizations.of(context)!.scheduleTitle,
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final classDetails = filtered[index];

                      return Card(
                        child: InkWell(
                          onTap: () => widget.onTap?.call(classDetails),
                          child: ListTile(
                            title: Text(classDetails.className),
                            subtitle: Text(
                              '${AppLocalizations.of(context)!.timeLabel} ${classDetails.startTime} - ${classDetails.endTime}\n${classDetails.location}',
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (error, stack) => Center(
                  child: Text('Error: $error'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
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
