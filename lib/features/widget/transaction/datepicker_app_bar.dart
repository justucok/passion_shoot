import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proj_passion_shoot/Provider/date_provider.dart';
import 'package:proj_passion_shoot/config/theme/app_theme.dart';
import 'package:provider/provider.dart';

class DatepickerAppBar extends StatefulWidget {
  const DatepickerAppBar({super.key, this.pickedDate});

  final DateTime? pickedDate;

  @override
  State<DatepickerAppBar> createState() => _DatepickerAppBarState();
}

class _DatepickerAppBarState extends State<DatepickerAppBar> {
  Future<void> _selectDate(BuildContext context) async {
    final DateProvider dateProvider =
        Provider.of<DateProvider>(context, listen: false);
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: dateProvider.selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(3000),
    );
    if (pickedDate != null && pickedDate != dateProvider.selectedDate) {
      dateProvider.updateDate(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DateProvider>(
      builder: (context, dateProvider, child) {
        return AppBar(
          backgroundColor: primaryColor,
          centerTitle: true,
          title: Text(
            DateFormat('E, d MMM yyyy').format(dateProvider.selectedDate),
            style: secondaryTextStyle.copyWith(fontSize: 18),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.calendar_today, color: secondaryTextColor),
              onPressed: () => _selectDate(context),
            ),
          ],
        );
      },
    );
  }
}
