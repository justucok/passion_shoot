import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proj_passion_shoot/config/theme/app_theme.dart';

class DatepickerAppBar extends StatefulWidget {
  const DatepickerAppBar({super.key});

  @override
  State<DatepickerAppBar> createState() => _DatepickerAppBarState();
}

class _DatepickerAppBarState extends State<DatepickerAppBar> {
  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(3000),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          DateFormat('E, d MMM yyyy').format(_selectedDate),
          style: secondaryTextStyle.copyWith(fontSize: 18),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today, color: secondaryTextColor,),
            onPressed: () => _selectDate(context),
          ),
        ],
      ),
    );
  }
}
