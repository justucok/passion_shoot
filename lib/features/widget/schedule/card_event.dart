import 'package:flutter/material.dart';
import 'package:proj_passion_shoot/config/theme/app_theme.dart';
import 'package:proj_passion_shoot/features/data/event_calender/get%20event.dart';

class CardEvent extends StatelessWidget {
  const CardEvent({
    Key? key,
    required this.selectedEvent,
  }) : super(key: key);

  final ValueNotifier<List<GetEvent>> selectedEvent;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder<List<GetEvent>>(
        valueListenable: selectedEvent,
        builder: (context, events, _) {
          if (events.isEmpty) {
            return Center(
              child: Text(
                'Tidak ada event untuk hari ini',
                style: TextStyle(color: Colors.grey),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9),
                    color: bgColor,
                  ),
                  child: ListTile(
                    title: Text(events[index].title),
                    subtitle: Text(events[index].time),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
