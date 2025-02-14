import 'package:event_app/core/manager/app_provider.dart';
import 'package:event_app/firebase_managre/models/event_model.dart';
import 'package:event_app/modules/layout/manager/layout_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventCardWidget extends StatelessWidget {
  EventModel event;

  EventCardWidget({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var appProvider = Provider.of<AppProvider>(context);
    var provider = Provider.of<LayoutProvider>(context);
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
                        ? event.categoryImageLight
                        : event.categoryImageDark),
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
                        // event.date,
                        DateFormat("d").format(DateTime.parse(event.date)),
                        style: theme.textTheme.bodyLarge!.copyWith(
                            color: theme.primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        DateFormat("MMM").format(DateTime.parse(event.date)),
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
                        event.title,
                        style: theme.textTheme.bodyLarge!.copyWith(
                            color: theme.primaryColorDark,
                            fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          provider.addFav(event);
                        },
                        child: Icon(
                          event.isFav
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          color: theme.primaryColor,
                        ),
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
