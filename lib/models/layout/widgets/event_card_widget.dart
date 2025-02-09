import 'package:event_app/core/manager/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class EventCardWidget extends StatelessWidget {
  String lightImage;
  String darkImage;
  String day;
  String month;
  String title;

  EventCardWidget(
      {super.key,
      required this.lightImage,
      required this.darkImage,
      required this.day,
      required this.title,
      required this.month});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var appProvider = Provider.of<AppProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 15, right: 15, left: 15),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: size.height * 0.23,
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(appProvider.themeMode == ThemeMode.light
                        ? lightImage
                        : darkImage),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: theme.primaryColor)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: appProvider.themeMode == ThemeMode.light
                          ? theme.primaryColorLight
                          : theme.scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(8)),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Text(
                        day,
                        style: theme.textTheme.bodyLarge!.copyWith(
                            color: theme.primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        month,
                        style: theme.textTheme.bodyLarge!.copyWith(
                            color: theme.primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  decoration: BoxDecoration(
                      color: appProvider.themeMode == ThemeMode.light
                          ? theme.primaryColorLight
                          : theme.scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(8)),
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.bodyLarge!.copyWith(
                            color: theme.primaryColorDark,
                            fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Icon(
                        Icons.favorite_border_rounded,
                        color: theme.primaryColor,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
