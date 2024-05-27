import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import DateFormat from intl package
import 'package:proj_passion_shoot/api/server-api/apiservices.dart';
import 'package:proj_passion_shoot/config/theme/app_theme.dart';
import 'package:proj_passion_shoot/features/data/event_calender/get%20event.dart';

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
  Map<DateTime, List<GetEvent>> events = {};
  late final ValueNotifier<List<GetEvent>> _selectedEvent;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvent = ValueNotifier<List<GetEvent>>([]);
    fetchEvents();
  }

  @override
  void dispose() {
    _selectedEvent.dispose();
    super.dispose();
  }

  Future<void> fetchEvents() async {
    try {
      List<GetEvent> eventList = await Service().getEvents();
      Map<DateTime, List<GetEvent>> mappedEvents = {};

      for (var event in eventList) {
        DateTime eventDate = DateTime.parse(event.date);
        if (mappedEvents[eventDate] == null) {
          mappedEvents[eventDate] = [];
        }
        mappedEvents[eventDate]!.add(event);
      }

      setState(() {
        events = mappedEvents;
        _selectedEvent.value = _getEventsForDay(_selectedDay!);
      });
    } catch (e) {
      print('Error fetching events: $e');
    }
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

  List<GetEvent> _getEventsForDay(DateTime day) {
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
            //mendapatkan tanggal yanng akan di inputkan ke form add
            ValueListenableBuilder<List<GetEvent>>(
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
