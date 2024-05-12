import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:proj_passion_shoot/config/theme/app_theme.dart';
import 'package:proj_passion_shoot/features/widget/add_button.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../data/map/schedule/event.dart';

class CalendarEvent extends StatefulWidget {
  const CalendarEvent({super.key});

  @override
  State<CalendarEvent> createState() => _CalendarEventState();
}

class _CalendarEventState extends State<CalendarEvent> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<Event>> events = {};
  late final ValueNotifier<List<Event>> _selectedEvents;
  TextEditingController _eventController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _selectedEvents.dispose();
  }
  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TableCalendar(
            focusedDay: _focusedDay,
            firstDay: DateTime(2000),
            lastDay: DateTime(2200),
            calendarStyle: CalendarStyle(
              defaultTextStyle: primaryTextStyle,
              todayDecoration: ShapeDecoration(
                  shape: const CircleBorder(), color: secondaryColor),
              selectedDecoration: ShapeDecoration(
                  shape: const CircleBorder(), color: primaryColor),
            ),
            headerStyle: HeaderStyle(
                titleCentered: true,
                titleTextStyle: primaryTextStyle.copyWith(
                    color: primaryColor, fontSize: 16),
                formatButtonVisible: false),
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                // Call `setState()` when updating the selected day
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                  _selectedEvents.value = _getEventsForDay(selectedDay);
                });
              }
            },
            eventLoader: _getEventsForDay,
          ),
          Expanded(
            child: ValueListenableBuilder<List<Event>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: ListTile(
                        // onTap: () => print('${value[index]}'),
                        title: Text(value[index].title),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: AddButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('New Event'),
              content: TextField(
                controller: _eventController,
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      events.addAll({
                        _selectedDay!: [Event(_eventController.text)]
                      });
                      Navigator.pop(context);
                      _selectedEvents.value = _getEventsForDay(_selectedDay!);
                    },
                    child: const Text('Save'))
              ],
            ),
          );
        },
      ),
    );
  }
}
