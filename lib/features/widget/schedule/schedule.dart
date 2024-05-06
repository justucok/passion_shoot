import 'package:flutter/material.dart';
import 'package:proj_passion_shoot/config/theme/app_theme.dart';
import 'package:proj_passion_shoot/features/widget/add_button.dart';
import 'package:proj_passion_shoot/features/widget/custom_appbar.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleContent extends StatefulWidget {
  const ScheduleContent({
    super.key,
  });

  @override
  State<ScheduleContent> createState() => _ScheduleContentState();
}

class _ScheduleContentState extends State<ScheduleContent> {
  DateTime _focusedDay = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      _focusedDay = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: CustomAppBar(title: 'Jadwal'),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(12)
              ),
              child: TableCalendar(
                focusedDay: _focusedDay,
                onDaySelected: _onDaySelected,
                selectedDayPredicate: (day) => isSameDay(day, _focusedDay),
                firstDay: DateTime(2000),
                lastDay: DateTime(3000),
                rowHeight: 43,
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: primaryTextStyle,
                ),
                availableGestures: AvailableGestures.none,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: AddButton(onPressed: () {
      },),
    );
  }
}
