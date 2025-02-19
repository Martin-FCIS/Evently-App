import 'package:event_app/core/manager/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../firebase_manager/models/event_model.dart';

class MapCardWidget extends StatelessWidget {
  EventModel event;
  final Function(double, double) onPress;

  MapCardWidget({super.key, required this.event, required this.onPress});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var appProvider = Provider.of<AppProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          onPress(event.lat, event.long);
        },
        child: Container(
          width: size.width * 0.75,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              border: Border.all(color: theme.primaryColor),
              borderRadius: BorderRadius.circular(16)),
          child: Row(
            children: [
              AspectRatio(
                aspectRatio: 138 / 78,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    appProvider.themeMode == ThemeMode.light
                        ? event.categoryImageLight
                        : event.categoryImageDark,
                    height: double.infinity,
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title + event.title + event.title + event.title,
                      style: theme.textTheme.bodyMedium!.copyWith(
                          color: theme.primaryColor,
                          fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: Colors.black,
                        ),
                        Text(
                          "${event.lat.floor()} : ${event.long.floor()}",
                          style: theme.textTheme.bodySmall,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
