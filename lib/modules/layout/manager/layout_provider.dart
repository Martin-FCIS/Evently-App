import 'package:event_app/modules/layout/pages/screens/fav_screen.dart';
import 'package:event_app/modules/layout/pages/screens/home_screen.dart';
import 'package:event_app/modules/layout/pages/screens/map_screen.dart';
import 'package:event_app/modules/layout/pages/screens/profile_screen.dart';
import 'package:flutter/cupertino.dart';

import '../../../firebase_managre/firebase_database.dart';
import '../../../firebase_managre/models/event_model.dart';

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

  void changeBtnNavIndex(int value) {
    selectedIndex = value;
    notifyListeners();
  }

  void changeTabIndex(int value) {
    selectedTabIndex = value;
    notifyListeners();
  }

  Future<void> getEvents() async {
    var data = await FirebaseDatabase.getEvent();
    for (var e in data) {
      events.add(e.data());
    }
    notifyListeners();
  }
}
