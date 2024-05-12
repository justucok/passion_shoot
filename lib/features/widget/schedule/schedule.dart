import 'package:flutter/material.dart';
import 'package:proj_passion_shoot/features/widget/custom_appbar.dart';
import 'package:proj_passion_shoot/features/widget/schedule/calendar.dart';

class ScheduleContent extends StatelessWidget {
  const ScheduleContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // appbar
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: CustomAppBar(title: 'Jadwal'),
      ),
      // end appbar
      body: CalendarEvent()
    );
  }
}
