import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:proj_passion_shoot/config/theme/app_theme.dart';
import 'package:proj_passion_shoot/features/data/model/event_calender/get_event.dart';

class CardEvent extends StatelessWidget {
  const CardEvent({
    super.key,
    required this.selectedEvent,
  });

  final ValueNotifier<List<GetEvent>> selectedEvent;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder<List<GetEvent>>(
        valueListenable: selectedEvent,
        builder: (context, value, child) {
          log(
              "ValueListenableBuilder value: $value"); // Tambahkan log di sini
          if (value.isEmpty) {
            return const Center(child: Text("Tidak ada acara"));
          }
          return ListView.builder(
            itemCount: value.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  color: bgColor,
                ),
                child: ListTile(
                  title: Text(
                    value[index].title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(value[index].time),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
