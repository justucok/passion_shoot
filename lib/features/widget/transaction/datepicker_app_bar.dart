// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:proj_passion_shoot/Provider/date_provider.dart';
// import 'package:proj_passion_shoot/config/theme/app_theme.dart';
// import 'package:provider/provider.dart';

// class DatepickerAppBar extends StatefulWidget {
//   const DatepickerAppBar({super.key, required this.selectedDate});

//   final DateTime selectedDate;

//   @override
//   State<DatepickerAppBar> createState() => _DatepickerAppBarState();
// }

// class _DatepickerAppBarState extends State<DatepickerAppBar> {
//   // Future<void> _selectDate(BuildContext context) async {
//   //   // final DateProvider dateProvider =
//   //   //     Provider.of<DateProvider>(context, listen: false);
//   //   final DateTime? pickedDate = await showDatePicker(
//   //     context: context,
//   //     initialDate: selectedDate,
//   //     firstDate: DateTime(2000),
//   //     lastDate: DateTime(3000),
//   //   );
//   //   if (pickedDate != selectedDate) {
//   //     selectedDate = pickedDate!;
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       title: Text(
//         DateFormat('E, d MMM yyyy').format(widget.selectedDate),
//         style: secondaryTextStyle.copyWith(fontSize: 18),
//       ),
//       actions: [
//         IconButton(
//             onPressed: () async {
//               final DateTime? dateTime = await showDatePicker(
//                 context: context,
//                 firstDate: DateTime(2000),
//                 lastDate: DateTime(3000),
//               );
//               if (dateTime != null) {
//                 setState(() {
//                   widget.selectedDate = dateTime;
//                 });
//               }
//             },
//             icon: const Icon(Icons.calendar_today))
//       ],
//     );
//     // Consumer<DateProvider>(
//     //   builder: (context, dateProvider, child) {
//     //     return AppBar(
//     //       backgroundColor: primaryColor,
//     //       centerTitle: true,
//     //       title: Text(
//     //         DateFormat('E, d MMM yyyy').format(dateProvider.selectedDate),
//     //         style: secondaryTextStyle.copyWith(fontSize: 18),
//     //       ),
//     //       actions: [
//     //         IconButton(
//     //           icon: Icon(Icons.calendar_today, color: secondaryTextColor),
//     //           onPressed: () => _selectDate(context),
//     //         ),
//     //       ],
//     //     );
//     //   },
//     // );
//   }
// }

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proj_passion_shoot/config/theme/app_theme.dart';

// ignore: must_be_immutable
class DatepickerAppBar extends StatefulWidget {
  DatepickerAppBar({super.key, required this.selectDate});

  DateTime selectDate;

  @override
  State<DatepickerAppBar> createState() => _DatepickerAppBarState();
}

class _DatepickerAppBarState extends State<DatepickerAppBar> {
  // DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: widget.selectDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(3000),
    );
    // change value selectDate
    if (pickedDate != null && pickedDate != widget.selectDate) {
      setState(() {
        widget.selectDate = pickedDate;
        log(widget.selectDate.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        // menampilkan value selectDate
        title: Text(
          DateFormat('E, d MMM yyyy').format(widget.selectDate),
          style: secondaryTextStyle.copyWith(fontSize: 18),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today, color: secondaryTextColor,),
            // menampilkan datepicker
            onPressed: () => _selectDate(context),
          ),
        ],
      ),
    );
  }
}

