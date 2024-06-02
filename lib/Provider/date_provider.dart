import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class DateProvider extends ChangeNotifier {
  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  void updateSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  String get selectedDateString {
    return DateFormat('yyyy-MM-dd')
        .format(_selectedDate); // atau format sesuai kebutuhan Anda
  }

  void updateDate(DateTime pickedDate) {}
}
