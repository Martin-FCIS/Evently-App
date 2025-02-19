import 'package:event_app/core/constants/app_categories.dart';
import 'package:event_app/core/manager/app_provider.dart';
import 'package:event_app/core/routes/app_routes_name.dart';
import 'package:event_app/firebase_manager/firebase_database.dart';
import 'package:event_app/firebase_manager/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';

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

  //Maps
  Location location = Location();
  late GoogleMapController mapController;
  CameraPosition cameraPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 17,
  );
  Set<Marker> markers = {
    Marker(
      markerId: MarkerId("0"),
    )
  };

  LatLng? eventLocation;

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
    if (!isDate || !isTime || eventLocation == null) {
      _provider.showSnackBar(
          context: context,
          message: !isDate
              ? AppLocalizations.of(context)!.sb_YouMustChooseDate
              : eventLocation != null
                  ? AppLocalizations.of(context)!.sb_YouMustChooseTime
                  : "Location is Required",
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
              AppCategories.categories[selectedTabIndex].darkimage,
          lat: eventLocation?.latitude ?? 0,
          long: eventLocation?.longitude ?? 0);
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

  //Maps
  Future<void> getLocation() async {
    bool locationPermGranted = await _getLocationPermission();
    if (!locationPermGranted) {
      return;
    }
    bool locationServiceEnabled = await _locationServiceEnabled();
    if (!locationServiceEnabled) {
      return;
    }
    LocationData locationData = await location.getLocation();
    changeLocationOnMap(locationData);
  }

  Future<bool> _getLocationPermission() async {
    PermissionStatus perm = await location.hasPermission();
    print("Current Permission Status: $perm");
    if (perm == PermissionStatus.denied) {
      perm = await location.requestPermission();
      print("Updated Permission Status: $perm");
    }

    return perm == PermissionStatus.granted;
  }

  Future<bool> _locationServiceEnabled() async {
    bool locationServiceEnabled = await location.serviceEnabled();
    if (!locationServiceEnabled) {
      locationServiceEnabled = await location.requestService();
    }
    return locationServiceEnabled;
  }

  void changeLocationOnMap(LocationData locationData) {
    cameraPosition = CameraPosition(
        target: LatLng(locationData.latitude ?? 0, locationData.longitude ?? 0),
        zoom: 17);
    markers = {
      Marker(
          markerId: MarkerId("0"),
          position:
              LatLng(locationData.latitude ?? 0, locationData.longitude ?? 0))
    };
    mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    notifyListeners();
  }

  void changeEventLocation(LatLng newEventLocation) {
    eventLocation = newEventLocation;
    cameraPosition = CameraPosition(
        target: LatLng(
            newEventLocation.latitude ?? 0, newEventLocation.longitude ?? 0),
        zoom: 17);
    markers = {
      Marker(
          markerId: MarkerId("0"),
          position: LatLng(
              newEventLocation.latitude ?? 0, newEventLocation.longitude ?? 0))
    };
    mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    notifyListeners();
  }
}
