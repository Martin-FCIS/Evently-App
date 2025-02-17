import 'package:event_app/core/constants/app_categories.dart';
import 'package:event_app/core/manager/app_provider.dart';
import 'package:event_app/core/routes/app_routes_name.dart';
import 'package:event_app/firebase_manager/firebase_database.dart';
import 'package:event_app/firebase_manager/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class EventProvider extends ChangeNotifier {
  final AppProvider _provider = AppProvider();
  int selectedTabIndex = 1;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  bool isDate = false;
  bool isTime = false;
  bool isUpdate = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  EventModel? event;
  String? formattedDate;

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

  String getFormattedDate(BuildContext context, dynamic date) {
    if (date is String) {
      date = DateTime.parse(date);
    }
    return DateFormat("d MMMM yyyy", AppLocalizations.of(context)!.localeName)
        .format(date);
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

  String getFormattedTime(BuildContext context, dynamic time) {
    int hours = 0;
    int minutes = 0;

    if (time is String) {
      String extractedTime = time.replaceAll(RegExp(r'[^0-9:]'), '');
      List<String> parts = extractedTime.split(':');
      hours = int.parse(parts[0]);
      minutes = int.parse(parts[1]);
    } else if (time is TimeOfDay) {
      hours = time.hour;
      minutes = time.minute;
    }
    return DateFormat.jm(AppLocalizations.of(context)!.localeName)
        .format(DateTime(2000, 1, 1, hours, minutes));
  }

  Future<void> addEvent(BuildContext context) async {
    if (!isDate || !isTime) {
      _provider.showSnackBar(
          context: context,
          message: !isDate
              ? AppLocalizations.of(context)!.sb_YouMustChooseDate
              : AppLocalizations.of(context)!.sb_YouMustChooseTime,
          showCloseIcon: true);
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
      _provider.showSnackBar(
          context: context,
          message: AppLocalizations.of(context)!.sb_createEvent,
          showCloseIcon: false);
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pop(context);
      });
    }
    notifyListeners();
  }

  Future<void> deleteEvent(BuildContext context, EventModel event) async {
    await FirebaseDatabase.deleteEvent(event.id ?? "");
    _provider.showSnackBar(
        context: context,
        message: AppLocalizations.of(context)!.sb_deleteEvent,
        showCloseIcon: false);
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pop(context);
    });
    notifyListeners();
  }

  void initData(EventModel eventModel) {
    isUpdate = true;
    event = eventModel;
    titleController.text = eventModel.title;
    descController.text = eventModel.desc;
    selectedTabIndex = AppCategories.categories
        .indexWhere((element) => element.id == eventModel.categoryID);
    selectedDate = DateTime.parse(eventModel.date);
    List<String> timeParts =
        eventModel.time.replaceAll(RegExp(r'[^0-9:]'), '').split(':');
    selectedTime = TimeOfDay(
      hour: int.parse(timeParts[0]),
      minute: int.parse(timeParts[1]),
    );
    notifyListeners();
  }

  Future<void> updateEvent(BuildContext context) {
    event?.title = titleController.text;
    event?.desc = descController.text;
    event?.date = selectedDate.toString();
    event?.time = selectedTime.toString();
    event?.categoryID = AppCategories.categories[selectedTabIndex].id;
    event?.categoryName = AppCategories.categories[selectedTabIndex].name;
    event?.categoryImageLight =
        AppCategories.categories[selectedTabIndex].lightimage;
    event?.categoryImageDark =
        AppCategories.categories[selectedTabIndex].darkimage;
    _provider.showSnackBar(
        context: context,
        message: AppLocalizations.of(context)!.sb_updateEvent,
        showCloseIcon: false);
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, RoutesName.layoutScreen);
    });
    return FirebaseDatabase.updateEvent(event!);
  }
}
