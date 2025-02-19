import 'package:event_app/modules/layout/pages/screens/fav_screen.dart';
import 'package:event_app/modules/layout/pages/screens/home_screen.dart';
import 'package:event_app/modules/layout/pages/screens/map_screen.dart';
import 'package:event_app/modules/layout/pages/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../../core/constants/app_categories.dart';
import '../../../firebase_manager/firebase_auth_manager.dart';
import '../../../firebase_manager/firebase_database.dart';
import '../../../firebase_manager/models/event_model.dart';

class LayoutProvider extends ChangeNotifier {
  int selectedIndex = 0;
  int selectedTabIndex = 0;
  List<Widget> screens = [
    HomeScreen(),
    MapScreen(),
    FavScreen(),
    ProfileScreen()
  ];
  List<EventModel> events = [];
  List<EventModel> favEvents = [];
  Location location = Location();

  late GoogleMapController mapController;
  CameraPosition cameraPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 17,
  );
  Set<Marker> markers = {
    Marker(
      markerId: MarkerId("0"),
      position: LatLng(37.42796133580664, -122.085749655962),
    )
  };

  void changeBtnNavIndex(int value) {
    selectedIndex = value;
    notifyListeners();
  }

  void changeTabIndex(int value) {
    selectedTabIndex = value;
    getEventsStream();
    notifyListeners();
  }

  Future<void> getEvents() async {
    var data = await FirebaseDatabase.getEvent();
    print("Raw Firebase Data: $data");
    events.clear();
    for (var e in data) {
      print("Event Data: ${e.data()}");
      events.add(e.data());
    }
    print("Final Events List: $events");
    notifyListeners();
  }

  void getEventsStream() async {
    ///magic => كل م يحصل تغيير في الداتا هتعرضه في الui
    events.clear();

    FirebaseDatabase.getEventsStream().listen(
      (event) {
        events.clear();
        for (var e in event.docs) {
          print("Event Data: ${e.data()}");
          if (AppCategories.categories[selectedTabIndex].id == "all" ||
              e.data().categoryID ==
                  AppCategories.categories[selectedTabIndex].id) {
            events.add(e.data());
          }
        }
        notifyListeners();
      },
    );
  }

  void getEventsFavStream() async {
    favEvents.clear();
    FirebaseDatabase.getEventsFavStream().listen(
      (event) {
        favEvents.clear();
        for (var e in event.docs) {
          favEvents.add(e.data());
          notifyListeners();
        }
      },
    );
  }

  void search(String q) {
    if (q.isEmpty) {
      getEventsFavStream();
    } else {
      favEvents = favEvents.where(
        (element) {
          return element.title.toLowerCase().contains(q.toLowerCase());
        },
      ).toList();
      notifyListeners();
    }
  }

  Future<void> addFav(EventModel data, BuildContext context) {
    return FirebaseDatabase.addFav(data);
  }

  Future<void> logOut() {
    return FirebaseAuthManager.signOut();
  }

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

  void setLocationListener() {
    location.changeSettings(
      accuracy: LocationAccuracy.high,
      interval: 1000,
    );
    location.onLocationChanged.listen(
      (locationData) {
        changeLocationOnMap(locationData);
      },
    );
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
}
