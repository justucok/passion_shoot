import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proj_passion_shoot/config/theme/app_theme.dart';
import 'package:proj_passion_shoot/features/data/model/event_calender/get_event.dart';
import 'package:proj_passion_shoot/features/data/model/event_calender/post_event.dart';
import 'package:proj_passion_shoot/features/pages/schedule/add_event.dart';
import 'package:proj_passion_shoot/features/widget/add_button.dart';
import 'package:proj_passion_shoot/features/widget/custom_appbar.dart';
import 'package:proj_passion_shoot/features/widget/schedule/card_event.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:proj_passion_shoot/features/data/datasource/remote_datasouce/api_service.dart';

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
  Map<DateTime, List<GetEvent>> events = {};
  late final ValueNotifier<List<GetEvent>> _selectedEvent;
  final Service _service = Service(); // Membuat instance dari kelas Service

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvent = ValueNotifier<List<GetEvent>>([]);
    _fetchAndSetEvents();
  }

  Future<void> _fetchAndSetEvents() async {
    try {
      List<GetEvent> eventList = await _service.getEvents();
      log('Data acara yang diterima:');
      for (var event in eventList) {
        log(event
            .toString()); // Mencetak data acara yang diterima dengan informasi yang lebih detail
      }

      Map<DateTime, List<GetEvent>> eventMap = {};

      for (var event in eventList) {
        DateTime eventDate = DateTime.parse(event.date);
        if (eventMap.containsKey(eventDate)) {
          eventMap[eventDate]!.add(event);
        } else {
          eventMap[eventDate] = [event];
        }
      }

      setState(() {
        events = eventMap;
        _selectedEvent.value = _getEventsForDay(_selectedDay!);
        _selectedEvent.value = eventList;
        log("Updated _selectedEvent: ${_selectedEvent.value}");
      });
    } catch (e) {
      log('Error fetching events: $e');
    }
  }

  List<GetEvent> _getEventsForDay(DateTime day) {
    log(events[day].toString());
    return events[day] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _selectedEvent.value = _getEventsForDay(selectedDay);
      });
    }
    log('Selected Date: ${DateFormat('yyyy-MM-dd').format(selectedDay)}');
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
            ValueListenableBuilder<List<GetEvent>>(
              valueListenable: _selectedEvent,
              builder: (context, value, _) {
                // Filter events based on selected date
                List<GetEvent> selectedEvents = value
                    .where((event) =>
                        DateFormat('yyyy-MM-dd')
                            .format(DateTime.parse(event.date)) ==
                        DateFormat('yyyy-MM-dd').format(_selectedDay!))
                    .toList();

                // Buat ValueNotifier baru dengan daftar acara yang telah difilter
                ValueNotifier<List<GetEvent>> filteredEventsNotifier =
                    ValueNotifier<List<GetEvent>>(selectedEvents);

                // Pass filteredEventsNotifier ke CardEvent
                return CardEvent(selectedEvent: filteredEventsNotifier);
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
                selectedDate: _selectedDay!,
                onPressed: () {
                  // Call postDataToServer from Service class
                  PostEvent newEvent = PostEvent(
                    date: DateFormat('yyyy-MM-dd').format(_selectedDay!),
                    title: _eventController.text,
                    time: _selectedTime.format(context),
                  );
                  _service.postDataToServer(newEvent); // Call the method here
                  _fetchAndSetEvents(); // Refresh events after posting new event
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
