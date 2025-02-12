import 'package:event_app/core/constants/app_assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppCategories {
  String id;
  String name;
  String image;
  Widget  icon;

  AppCategories(
      {required this.id,
      required this.name,
      required this.image,
      required this.icon});

  static List<AppCategories> categories = [
    AppCategories(
        id: "all",
        name: "All",
        image: "image",
        icon: ImageIcon(AssetImage(AppAssets.allCat))),
    AppCategories(
        id: "sport",
        name: "Sport",
        image: "image",
        icon: ImageIcon(AssetImage(AppAssets.sportCat))),
    AppCategories(
        id: "birthday",
        name: "Birthday",
        image: "image",
        icon: ImageIcon(AssetImage(AppAssets.birthdayCat))),
    AppCategories(
        id: "meeting",
        name: "Meeting",
        image: "image",
        icon:Icon(Icons.meeting_room_rounded)),
    AppCategories(
        id: "gaming",
        name: "Gaming",
        image: "image",
        icon: Icon(Icons.videogame_asset_rounded)),
    AppCategories(
        id: "eating",
        name: "Eating",
        image: "image",
        icon: Icon(Icons.fastfood_rounded)),
    AppCategories(
        id: "holiday",
        name: "Holiday",
        image: "image",
        icon: Icon(Icons.beach_access_rounded)),
    AppCategories(
        id: "exhibition",
        name: "Exhibition",
        image: "image",
        icon: Icon(Icons.museum_rounded)),
    AppCategories(
        id: "workshop",
        name: "WorkShop",
        image: "image",
        icon: Icon(Icons.build_circle_rounded)),
    AppCategories(
        id: "book_club",
        name: "Book_Club",
        image: "image",
        icon: Icon(Icons.book_rounded)),
  ];
}
