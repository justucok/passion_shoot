import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:proj_passion_shoot/config/theme/app_theme.dart';
import 'package:proj_passion_shoot/features/bloc/event_bloc/event_bloc.dart';

// ignore: must_be_immutable
class CardEvent extends StatelessWidget {
  CardEvent({
    super.key,
    required this.selectedDate,
  });

   DateTime? selectedDate;

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
          final spesificData = data.where((element) => element.date == DateFormat('yyyy-MM-dd').format(selectedDate!)).toList();
          log('data today : $spesificData');
          // list method
          return ListView.builder(
            itemCount: spesificData.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  color: bgColor,
                ),
                child: ListTile(
                  title: Text(spesificData[index].title, style: primaryTextStyle,),
                  // subtitle: Text(data[index].date),
                  trailing: Text(spesificData[index].time),
                ),
              );
            },
          );
          // end list method
        }
        if (state is EventError) {
          log('e : ${state.error}');
          return Center(
            child: Text(state.error),
          );
        }
        return const Center(
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
