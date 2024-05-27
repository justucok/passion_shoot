import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import DateFormat from intl package
import 'package:proj_passion_shoot/api/server-api/apiservices.dart';
import 'package:proj_passion_shoot/config/theme/app_theme.dart';
import 'package:proj_passion_shoot/features/data/event_calender/event.dart';
import 'package:proj_passion_shoot/features/pages/home/home.dart';
import 'package:proj_passion_shoot/features/widget/custom_appbar.dart';
import 'package:proj_passion_shoot/features/widget/schedule/schedule.dart';
// Import the HomeScreen

class EventScreen extends StatefulWidget {
  EventScreen({
    Key? key,
    required this.eventController,
    required this.selectedTime,
    required this.selectedDate,
    required this.onPressed,
  }) : super(key: key);

  final TextEditingController eventController;
  TimeOfDay selectedTime; //menyimpan time
  DateTime selectedDate; // menyimpan date
  void Function()? onPressed;

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  Service service = Service();
  Future<void> _saveEvent() async {
    try {
      final newEvent = Event(
        date: DateFormat('yyyy-MM-dd').format(widget.selectedDate),
        title: widget.eventController.text,
        time: DateFormat('HH:mm:ss').format(DateTime(
            2024, 5, 28, widget.selectedTime.hour, widget.selectedTime.minute)),
      );

      print('Data Event:');
      print('Title: ${newEvent.title}');
      print('Date: ${newEvent.date}');
      print('Time: ${newEvent.time}');

      await service.createEvent(newEvent);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Event berhasil ditambahkan'),
        ),
      );

      widget.eventController.clear();

      // Navigate to HomeScreen after successful event addition
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ScheduleContent()), // Replace current screen with HomeScreen
      );
    } catch (e, stackTrace) {
      print('Error while saving event: $e');
      print('Stack Trace: $stackTrace');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal menambahkan event: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: CustomAppBar(
          title: 'Tambah Event',
          leading: BackButton(
            color: secondaryTextColor,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        width: double.infinity,
        child: Column(
          children: [
            TextField(
              controller: widget.eventController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
                hintText: 'Event Name',
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            TextField(
              controller: TextEditingController(
                text:
                    '${widget.selectedTime.hour}:${widget.selectedTime.minute}',
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
                suffixIcon: const Icon(Icons.access_time),
              ),
              readOnly: true,
              onTap: () async {
                final TimeOfDay? timeOfDay = await showTimePicker(
                  context: context,
                  initialTime: widget.selectedTime,
                  initialEntryMode: TimePickerEntryMode.inputOnly,
                );
                if (timeOfDay != null) {
                  setState(() {
                    widget.selectedTime = timeOfDay;
                  });
                }
              },
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: secondaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9),
                  ),
                ),
                onPressed: _saveEvent,
                child: Text(
                  'Simpan',
                  style: secondaryTextStyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
