class EventModel {
  String? id;
  String title;
  String desc;
  String date;
  String time;
  String categoryID;
  String categoryName;
  String categoryImageLight;

  // String categoryImageDark;

  EventModel(
      {this.id,
      required this.title,
      required this.desc,
      required this.date,
      required this.time,
      required this.categoryID,
      required this.categoryName,
      required this.categoryImageLight});

  // required this.categoryImageDark});

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "desc": desc,
      "date": date,
      "time": time,
      "categoryID": categoryID,
      "categoryName": categoryName,
      "categoryImageLight": categoryImageLight,
      // "categoryImageDark": categoryImageDark,
    };
  }

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
        id: json["id"],
        title: json["title"],
        desc: json["desc"],
        date: json["date"],
        time: json["time"],
        categoryID: json["categoryID"],
        categoryName: json["categoryName"],
        categoryImageLight: json["categoryImageLight"]);
    // categoryImageDark: json["categoryImageDark"]);
  }
}
