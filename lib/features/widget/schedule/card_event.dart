import 'package:flutter/material.dart';
import 'package:proj_passion_shoot/config/theme/app_theme.dart';
<<<<<<< HEAD
import 'package:proj_passion_shoot/features/data/event_calender/get%20event.dart';
=======
import 'package:proj_passion_shoot/features/data/model/event_calender/post_event.dart';
>>>>>>> 24b768218f45d3a705efb7b4ac9605a281a3f8c6

class CardEvent extends StatelessWidget {
  const CardEvent({
    super.key,
    required this.selectedEvent,
  });

<<<<<<< HEAD
  final ValueNotifier<List<GetEvent>> selectedEvent;
=======
  final ValueNotifier<List<PostEvent>> selectedEvent;
>>>>>>> 24b768218f45d3a705efb7b4ac9605a281a3f8c6

  @override
  Widget build(BuildContext context) {
    return Expanded(
<<<<<<< HEAD
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
=======
      child: ValueListenableBuilder(
        valueListenable: selectedEvent,
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
>>>>>>> 24b768218f45d3a705efb7b4ac9605a281a3f8c6
      ),
    );
  }
}
