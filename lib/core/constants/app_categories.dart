import 'package:event_app/core/constants/app_assets.dart';
import 'package:flutter/material.dart';

class AppCategories {
  String id;
  String name;
  String lightimage;
  String darkimage;
  Widget icon;

  AppCategories(
      {required this.id,
      required this.name,
      required this.lightimage,
      required this.darkimage,
      required this.icon});

  static List<AppCategories> categories = [
    AppCategories(
        id: "all",
        name: "All",
        lightimage: "",
        darkimage: "",
        icon: ImageIcon(AssetImage(AppAssets.allCat))),
    AppCategories(
        id: "sport",
        name: "Sport",
        lightimage: AppAssets.sportLight,
        darkimage: AppAssets.sportDark,
        icon: ImageIcon(AssetImage(AppAssets.sportCat))),
    AppCategories(
        id: "birthday",
        name: "Birthday",
        lightimage: AppAssets.birthdayLight,
        darkimage: AppAssets.birthdayDark,
        icon: ImageIcon(AssetImage(AppAssets.birthdayCat))),
    AppCategories(
        id: "meeting",
        name: "Meeting",
        lightimage: AppAssets.meetingLight,
        darkimage: AppAssets.meetingDark,
        icon: Icon(Icons.meeting_room_rounded)),
    AppCategories(
        id: "gaming",
        name: "Gaming",
        lightimage: AppAssets.gamingLight,
        darkimage: AppAssets.gamingDark,
        icon: Icon(Icons.videogame_asset_rounded)),
    AppCategories(
        id: "eating",
        name: "Eating",
        lightimage: AppAssets.eatingLight,
        darkimage: AppAssets.eatingDark,
        icon: Icon(Icons.fastfood_rounded)),
    AppCategories(
        id: "holiday",
        name: "Holiday",
        lightimage: AppAssets.holidayLight,
        darkimage: AppAssets.holidayDark,
        icon: Icon(Icons.beach_access_rounded)),
    AppCategories(
        id: "exhibition",
        name: "Exhibition",
        lightimage: AppAssets.exhibitionLight,
        darkimage: AppAssets.exhibitionDark,
        icon: Icon(Icons.museum_rounded)),
    AppCategories(
        id: "workshop",
        name: "WorkShop",
        lightimage: AppAssets.workshopLight,
        darkimage: AppAssets.workshopDark,
        icon: Icon(Icons.build_circle_rounded)),
    AppCategories(
        id: "book_club",
        name: "Book_Club",
        lightimage: AppAssets.bookClubLight,
        darkimage: AppAssets.bookClubDark,
        icon: Icon(Icons.book_rounded)),
  ];
}
