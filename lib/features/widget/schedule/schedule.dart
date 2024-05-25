import 'package:flutter/material.dart';
import 'package:proj_passion_shoot/config/theme/app_theme.dart';
import 'package:proj_passion_shoot/features/data/event_calender/event.dart';
import 'package:proj_passion_shoot/features/pages/schedule/add_event.dart';
import 'package:proj_passion_shoot/features/widget/add_button.dart';
import 'package:proj_passion_shoot/features/widget/custom_appbar.dart';
import 'package:proj_passion_shoot/features/widget/schedule/card_event.dart';
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
  DateTime? _selectedDay;
  final TimeOfDay _selectedTime = TimeOfDay.now();
  final TextEditingController _eventController = TextEditingController();
  Map<DateTime, List<Event>> events = {};
  late final ValueNotifier<List<Event>> _selectedEvent;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvent = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
    }
  }

  List<Event> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
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
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(9),
              ),
              child: TableCalendar(
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                onDaySelected: _onDaySelected,
                eventLoader: _getEventsForDay,
                firstDay: DateTime(2000),
                lastDay: DateTime(2200),
                calendarStyle: CalendarStyle(
                    todayDecoration: ShapeDecoration(
                        shape: const CircleBorder(), color: secondaryColor),
                    selectedDecoration: ShapeDecoration(
                        shape: const CircleBorder(), color: primaryColor)),
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: primaryTextStyle.copyWith(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CardEvent(selectedEvent: _selectedEvent),
          ],
        ),
      ),
      floatingActionButton: AddButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute<dynamic>(
              builder: (context) => EventScreen(
                eventController: _eventController,
                selectedTime: _selectedTime,
                onPressed: () {
                  if (_eventController.text.isEmpty) {
                    Navigator.of(context).pop();
                  } else {
                    events.addAll({
                      _selectedDay!: [
                        Event(
                            title: _eventController.text,
                            time: _selectedTime.format(context)),
                      ]
                    });
                    Navigator.of(context).pop();
                    _selectedEvent.value = _getEventsForDay(_selectedDay!);
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
