import 'package:academity_app/design/app_theme.dart';
import 'package:academity_app/models/class_schedule.dart';
import 'package:academity_app/views/utils/adaptive_padding.dart';
import 'package:academity_app/views/widgets/app_bar.dart';
import 'package:academity_app/views/widgets/app_card.dart';
import 'package:academity_app/views/widgets/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  static const double dateButtonWidth = 74.0;
  static const double dateButtonGap = 12.0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToIndex(widget.daysBefore);
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _scrollToIndex(int index) {
    if (!scrollController.hasClients) return;

    const totalWidth = dateButtonWidth + dateButtonGap;
    final viewportWidth = scrollController.position.viewportDimension;
    final targetOffset =
        index * totalWidth - (viewportWidth / 2) + (totalWidth / 2);
    final maxScroll = scrollController.position.maxScrollExtent;
    final safeOffset = targetOffset.clamp(0.0, maxScroll).toDouble();

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
        subtitle: 'Classes and attendance windows',
        showBackButton: false,
      ),
      body: AdaptivePadding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 96,
              child: ListView.builder(
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: widget.daysBefore + widget.daysAfter + 1,
                itemBuilder: (context, index) {
                  final date = DateTime.now()
                      .subtract(Duration(days: widget.daysBefore))
                      .add(Duration(days: index));
                  final isSelected = _isSameDay(_selectedDay, date);
                  return _DateChip(
                    date: date,
                    isSelected: isSelected,
                    onTap: () {
                      setState(() {
                        _selectedDay = date;
                      });
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        _scrollToIndex(index);
                      });
                    },
                    weekday: _getDayOfWeek(date.weekday),
                  );
                },
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Expanded(
              child: scheduleAsyncValue.when(
                data: (schedule) {
                  final filtered = schedule.where((element) {
                    final elementDate = DateTime.parse(element.date);
                    return _isSameDay(elementDate, _selectedDay);
                  }).toList();

                  if (filtered.isEmpty) {
                    return AppEmptyState(
                      icon: Icons.event_available_outlined,
                      title: 'No classes today',
                      body:
                          'Your schedule is clear for this date. Pick another day to view more sessions.',
                    );
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.only(bottom: AppSpacing.xl),
                    itemCount: filtered.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: AppSpacing.md),
                    itemBuilder: (context, index) {
                      final classDetails = filtered[index];
                      return _ScheduleCard(
                        schedule: classDetails,
                        onTap: widget.onTap == null
                            ? null
                            : () => widget.onTap?.call(classDetails),
                      );
                    },
                  );
                },
                loading: () => const AppLoadingState(label: 'Loading schedule'),
                error: (error, stack) => AppErrorState(error: error),
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

class _DateChip extends StatelessWidget {
  final DateTime date;
  final String weekday;
  final bool isSelected;
  final VoidCallback onTap;

  const _DateChip({
    required this.date,
    required this.weekday,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: _SchedulePageState.dateButtonWidth,
        margin: const EdgeInsets.only(right: _SchedulePageState.dateButtonGap),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.navy : Colors.white,
          borderRadius: BorderRadius.circular(AppRadii.md),
          border: Border.all(
            color: isSelected ? AppColors.navy : AppColors.line,
          ),
          boxShadow: isSelected ? AppShadows.soft : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              weekday,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isSelected ? Colors.white70 : AppColors.muted,
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 6),
            Text(
              '${date.day}',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: isSelected ? Colors.white : AppColors.ink,
                    fontWeight: FontWeight.w900,
                  ),
            ),
            Text(
              '${date.month}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isSelected ? Colors.white70 : AppColors.muted,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScheduleCard extends StatelessWidget {
  final ClassSchedule schedule;
  final VoidCallback? onTap;

  const _ScheduleCard({required this.schedule, this.onTap});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: AppColors.teal.withValues(alpha: .1),
              borderRadius: BorderRadius.circular(AppRadii.md),
            ),
            child: const Icon(
              Icons.schedule_rounded,
              color: AppColors.teal,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  schedule.className,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${schedule.startTime} - ${schedule.endTime}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.brand,
                        fontWeight: FontWeight.w900,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  schedule.location,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.muted,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ],
            ),
          ),
          if (onTap != null)
            const Icon(Icons.chevron_right_rounded, color: AppColors.muted),
        ],
      ),
    );
  }
}
