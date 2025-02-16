import 'package:event_app/modules/layout/pages/screens/fav_screen.dart';
import 'package:event_app/modules/layout/pages/screens/home_screen.dart';
import 'package:event_app/modules/layout/pages/screens/map_screen.dart';
import 'package:event_app/modules/layout/pages/screens/profile_screen.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_categories.dart';
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
          notifyListeners();
        }
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
}
