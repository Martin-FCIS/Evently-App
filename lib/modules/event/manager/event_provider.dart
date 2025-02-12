import 'package:flutter/material.dart';

class EventProvider extends ChangeNotifier {
  int selectedTabIndex = 1;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  void changeTabIndex(int value) {
    selectedTabIndex = value;
    notifyListeners();
  }

  void selectDate(BuildContext context) {
    showDatePicker(
            context: context,
            currentDate: selectedDate,
            initialDate: selectedDate,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(Duration(days: 365)))
        .then(
      (value) {
        selectedDate = value;
        notifyListeners();
      },
    );
  }

  void selectTime(BuildContext context) {
    showTimePicker(context: context, initialTime: TimeOfDay.now()).then(
      (value) {
        selectedTime = value;
        notifyListeners();
      },
    );
  }
}
