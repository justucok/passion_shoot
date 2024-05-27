import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import DateFormat from intl package
import 'package:proj_passion_shoot/config/theme/app_theme.dart';
import 'package:proj_passion_shoot/features/data/model/event_calender/post_event.dart';
import 'package:proj_passion_shoot/features/pages/schedule/add_event.dart';
import 'package:proj_passion_shoot/features/widget/add_button.dart';
import 'package:proj_passion_shoot/features/widget/custom_appbar.dart';
import 'package:proj_passion_shoot/features/widget/schedule/card_event.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleContent extends StatefulWidget {
  const ScheduleContent({
    Key? key,
  }) : super(key: key);

  @override
  State<ScheduleContent> createState() => _ScheduleContentState();
}

class _ScheduleContentState extends State<ScheduleContent> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final TimeOfDay _selectedTime = TimeOfDay.now();
  final TextEditingController _eventController = TextEditingController();
  Map<DateTime, List<PostEvent>> events = {};
  late final ValueNotifier<List<PostEvent>> _selectedEvent;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvent = ValueNotifier<List<PostEvent>>([]);
  }

  @override
  void dispose() {
    _selectedEvent.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _selectedEvent.value = _getEventsForDay(selectedDay);
      });
    }
    print('Selected Date: ${DateFormat('yyyy-MM-dd').format(selectedDay)}');
  }

  List<PostEvent> _getEventsForDay(DateTime day) {
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
            ValueListenableBuilder<List<PostEvent>>(
              valueListenable: _selectedEvent,
              builder: (context, value, _) {
                return CardEvent(selectedEvent: _selectedEvent);
              },
            ),
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
                selectedDate: _selectedDay!, // Pass selected date
                onPressed: () {
                  if (_eventController.text.isEmpty) {
                    Navigator.of(context).pop();
                  } else {
                    // Your onPressed logic
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
