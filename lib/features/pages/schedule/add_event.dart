import 'package:flutter/material.dart';
import 'package:proj_passion_shoot/config/theme/app_theme.dart';
import 'package:proj_passion_shoot/features/widget/custom_appbar.dart';

// ignore: must_be_immutable
class EventScreen extends StatefulWidget {
  EventScreen({
    super.key,
    required this.eventController,
    required this.selectedTime,
    required this.onPressed,
  });

  final TextEditingController eventController;
  TimeOfDay selectedTime;
  void Function()? onPressed;

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
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
                        '${widget.selectedTime.hour}:${widget.selectedTime.minute}'),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9),
                  ),
                  suffixIcon: const Icon(Icons.access_time)
                ),
                readOnly: true,
                onTap: () async {
                  final TimeOfDay? timeOfDay = await showTimePicker(
                      builder: (context, child) {
                        return MediaQuery(data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true), child: child!);
                      },
                      context: context,
                      initialTime: widget.selectedTime,
                      initialEntryMode: TimePickerEntryMode.inputOnly);
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
                  onPressed: widget.onPressed,
                  child: Text(
                    'Simpan',
                    style: secondaryTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
