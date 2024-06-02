import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj_passion_shoot/features/bloc/event_bloc/event_bloc.dart';

class CardEvent extends StatelessWidget {
  const CardEvent({
    super.key,
    // required this.selectedEvent,
  });

  // final ValueNotifier<List<GetEvent>> selectedEvent;

  @override
  Widget build(BuildContext context) {
    return Expanded(child: BlocBuilder<EventBloc, EventState>(
      builder: (context, state) {
        if (state is EventLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is EventLoaded) {
          final data = state.events;
          for (var item in data) {
            log(item.title);
          }
          // list method
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(data[index].title),
                trailing: Text(data[index].time),
              );
            },
          );
          // end list method
        } if (state is EventError) {
          return Center(
            child: Text(state.error),
          );
        } return const Center(
          child: Text('Gagal memuat data'),
        );
      },
    )

        // ValueListenableBuilder<List<GetEvent>>(
        //   valueListenable: selectedEvent,
        //   builder: (context, value, child) {
        //     log(
        //         "ValueListenableBuilder value: $value"); // Tambahkan log di sini
        //     if (value.isEmpty) {
        //       return const Center(child: Text("Tidak ada acara"));
        //     }
        //     return ListView.builder(
        //       itemCount: value.length,
        //       itemBuilder: (context, index) {
        //         return Container(
        //           margin: const EdgeInsets.symmetric(vertical: 5),
        //           decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(9),
        //             color: bgColor,
        //           ),
        //           child: ListTile(
        //             title: Text(
        //               value[index].title,
        //               style: const TextStyle(fontWeight: FontWeight.bold),
        //             ),
        //             subtitle: Text(value[index].time),
        //           ),
        //         );
        //       },
        //     );
        //   },
        // ),
        );
  }
}
