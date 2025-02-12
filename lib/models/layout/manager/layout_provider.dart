import 'package:event_app/models/layout/pages/screens/fav_screen.dart';
import 'package:event_app/models/layout/pages/screens/home_screen.dart';
import 'package:event_app/models/layout/pages/screens/map_screen.dart';
import 'package:event_app/models/layout/pages/screens/profile_screen.dart';
import 'package:flutter/cupertino.dart';

class LayoutProvider extends ChangeNotifier {
  int selectedIndex = 0;
  int selectedTabIndex = 0;
  List<Widget> screens = [
    HomeScreen(),
    MapScreen(),
    FavScreen(),
    ProfileScreen()
  ];

  void changeBtnNavIndex(int value) {
    selectedIndex = value;
    notifyListeners();
  }

  void changeTabIndex(int value) {
    selectedTabIndex = value;
    notifyListeners();
  }
}
