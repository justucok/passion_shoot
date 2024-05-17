import 'package:flutter/material.dart';
import 'package:proj_passion_shoot/config/theme/app_theme.dart';
import 'package:proj_passion_shoot/features/data/event_calender/event.dart';

class CardEvent extends StatelessWidget {
  const CardEvent({
    super.key,
    required ValueNotifier<List<Event>> selectedEvent,
  }) : _selectedEvent = selectedEvent;

  final ValueNotifier<List<Event>> _selectedEvent;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder(
        valueListenable: _selectedEvent,
        builder: (context, value, child) => ListView.builder(
          itemCount: value.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                color: bgColor,
              ),
              child: ListTile(
                title: Text(value[index].title),
                subtitle: Text(value[index].time),
              ),
            );
          },
        ),
      ),
    );
  }
}
