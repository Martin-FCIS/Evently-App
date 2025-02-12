import 'package:event_app/core/constants/app_categories.dart';
import 'package:event_app/firebase_managre/firebase_database.dart';
import 'package:event_app/firebase_managre/models/event_model.dart';
import 'package:flutter/material.dart';

class EventProvider extends ChangeNotifier {
  int selectedTabIndex = 1;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

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

  Future<void> addEvent(BuildContext context) async {
    EventModel data = EventModel(
        title: titleController.text,
        desc: descController.text,
        date: selectedDate.toString(),
        time: selectedTime.toString(),
        categoryID: AppCategories.categories[selectedTabIndex].id,
        categoryName: AppCategories.categories[selectedTabIndex].name,
        categoryImageLight:
            AppCategories.categories[selectedTabIndex].lightimage);
    // categoryImageDark:
    //     AppCategories.categories[selectedTabIndex].darkimage);
    await FirebaseDatabase.addEvent(data);
    Navigator.pop(context);
    notifyListeners();
  }
}
