import 'package:event_app/core/constants/app_assets.dart';
import 'package:event_app/modules/layout/manager/layout_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_categories.dart';
import '../../../core/manager/app_provider.dart';

class EventDetails extends StatelessWidget {
  EventDetails({super.key});

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
            AppLocalizations.of(context)!.ca_createAcc,
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
                              ? AppCategories.categories[1].lightimage
                              : AppCategories.categories[1].darkimage,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Text(
                        "dataaaaaaaaaaaaaaaaaa",
                        style: theme.textTheme.bodyLarge!
                            .copyWith(color: theme.primaryColor, fontSize: 28),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: theme.primaryColor)),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  color: theme.primaryColor,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Icon(
                                Icons.calendar_month_rounded,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "21 November 2024 ",
                                  style: theme.textTheme.bodyMedium!
                                      .copyWith(color: theme.primaryColor),
                                ),
                                Text("12:12PM"),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: theme.primaryColor)),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  color: theme.primaryColor,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Icon(
                                Icons.calendar_month_rounded,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              "Cairo , Egypt",
                              style: theme.textTheme.bodyMedium!
                                  .copyWith(color: theme.primaryColor),
                            )
                          ],
                        ),
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
                      Text("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"),
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
