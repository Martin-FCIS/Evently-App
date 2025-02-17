import 'package:event_app/core/constants/app_assets.dart';
import 'package:event_app/firebase_manager/models/event_model.dart';
import 'package:event_app/modules/event/widgets/custom_container.dart';
import 'package:event_app/modules/layout/manager/layout_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/manager/app_provider.dart';

class EventDetails extends StatelessWidget {
  final EventModel eventModel;

  EventDetails({super.key, required this.eventModel});

  @override
  Widget build(BuildContext context) {
    var appProvider = Provider.of<AppProvider>(context);
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return ChangeNotifierProvider(
      create: (context) => LayoutProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Event Details",
            style: TextStyle(color: theme.primaryColor),
          ),
          iconTheme: IconThemeData(
            color: theme.primaryColor,
          ),
          actions: [
            ImageIcon(AssetImage(AppAssets.editEventIcon)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ImageIcon(
                AssetImage(AppAssets.deleteEventIcon),
                color: Colors.red,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<LayoutProvider>(
            builder: (context, provider, child) {
              return SingleChildScrollView(
                child: Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          appProvider.themeMode == ThemeMode.light
                              ? eventModel.categoryImageLight
                              : eventModel.categoryImageDark,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Text(
                        eventModel.title,
                        style: theme.textTheme.bodyLarge!
                            .copyWith(color: theme.primaryColor, fontSize: 28),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      CustomContainer(
                          text1: DateFormat("d MMMM yyyy")
                              .format(DateTime.parse(eventModel.date)),
                          text2: DateFormat.jm(
                                  AppLocalizations.of(context)!.localeName)
                              .format(
                            DateTime(
                              2000,
                              1,
                              1,
                              int.parse(eventModel.time
                                  .replaceAll(RegExp(r'[^0-9:]'), '')
                                  .split(':')[0]),
                              int.parse(eventModel.time
                                  .replaceAll(RegExp(r'[^0-9:]'), '')
                                  .split(':')[1]),
                            ),
                          )),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      CustomContainer(
                        text1: "Cairo , Egypt",
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: theme.primaryColor),
                            borderRadius: BorderRadius.circular(16)),
                        width: double.infinity,
                        height: 300,
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Text(
                        "Description",
                        style: theme.textTheme.bodyLarge!
                            .copyWith(color: theme.primaryColorDark),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Text(eventModel.desc),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
