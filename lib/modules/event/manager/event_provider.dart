import 'package:event_app/core/constants/app_categories.dart';
import 'package:event_app/core/themes/app_colors.dart';
import 'package:event_app/firebase_manager/firebase_database.dart';
import 'package:event_app/firebase_manager/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventProvider extends ChangeNotifier {
  int selectedTabIndex = 1;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  bool isDate = false;
  bool isTime = false;
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
        if (value != null) {
          isDate = true;
          selectedDate = value;
          notifyListeners();
        }
      },
    );
  }

  void selectTime(BuildContext context) {
    showTimePicker(context: context, initialTime: TimeOfDay.now()).then(
      (value) {
        if (value != null) {
          isTime = true;
          selectedTime = value;
          notifyListeners();
        }
      },
    );
  }

  Future<void> addEvent(BuildContext context) async {
    if (!isDate || !isTime) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Container(
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(!isDate
                ? AppLocalizations.of(context)!.sb_YouMustChooseDate
                : AppLocalizations.of(context)!.sb_YouMustChooseTime)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        closeIconColor: Colors.red,
        showCloseIcon: true,
      ));
    } else {
      EventModel data = EventModel(
          title: titleController.text,
          desc: descController.text,
          date: selectedDate.toString(),
          time: selectedTime.toString(),
          categoryID: AppCategories.categories[selectedTabIndex].id,
          categoryName: AppCategories.categories[selectedTabIndex].name,
          categoryImageLight:
              AppCategories.categories[selectedTabIndex].lightimage,
          categoryImageDark:
              AppCategories.categories[selectedTabIndex].darkimage);
      await FirebaseDatabase.addEvent(data);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 1),
        content: Container(
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(AppLocalizations.of(context)!.sb_createEvent)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        closeIconColor: Colors.red,
        showCloseIcon: false,
      ));
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pop(context);
      });
    }
    notifyListeners();
  }
}
