class EventModel {
  String? id;
  String title;
  String desc;
  String date;
  String time;
  String categoryID;
  String categoryName;
  bool isFav;
  String categoryImageLight;

  String categoryImageDark;

  EventModel(
      {this.id,
      required this.title,
      required this.desc,
      required this.date,
      required this.time,
      required this.categoryID,
      required this.categoryName,
      this.isFav = false,
      required this.categoryImageLight,
      required this.categoryImageDark});

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title.isNotEmpty ? title : "No Title",
      "desc": desc.isNotEmpty ? desc : "No Desc",
      "date": date.isNotEmpty ? date : "No Date",
      "time": time.isNotEmpty ? time : "No Time",
      "categoryID": categoryID,
      "categoryName": categoryName,
      "categoryImageLight": categoryImageLight,
      "categoryImageDark": categoryImageDark,
      "isFav": isFav
    };
  }

  factory EventModel.fromJson(Map<String, dynamic> json) {
    print("Parsing EventModel: $json");
    return EventModel(
        id: json["id"],
        title: json["title"],
        desc: json["desc"],
        date: json["date"],
        time: json["time"],
        isFav: json["isFav"] ?? false,
        categoryID: json["categoryID"],
        categoryName: json["categoryName"],
        categoryImageLight: json["categoryImageLight"],
        categoryImageDark: json["categoryImageDark"]);
  }
}
