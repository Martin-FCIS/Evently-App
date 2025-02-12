import 'package:event_app/core/constants/app_categories.dart';
import 'package:event_app/core/manager/app_provider.dart';
import 'package:event_app/localization_helper.dart';
import 'package:event_app/modules/layout/manager/layout_provider.dart';
import 'package:event_app/modules/layout/widgets/event_card_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_assets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<LayoutProvider>(context, listen: false).getEvents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var appProvider = Provider.of<AppProvider>(context);
    return ChangeNotifierProvider(
      create: (context) => LayoutProvider(),
      child: Consumer<LayoutProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: appProvider.themeMode == ThemeMode.light
                  ? theme.primaryColor
                  : theme.scaffoldBackgroundColor,
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24)),
                  borderSide: BorderSide(color: Colors.transparent)),
              toolbarHeight: size.height * 0.22,
              flexibleSpace: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.lo_welcome,
                                style: theme.textTheme.bodyLarge!
                                    .copyWith(color: Colors.white),
                              ),
                              Text(
                                FirebaseAuth.instance.currentUser?.displayName
                                        ?.toUpperCase() ??
                                    "",
                                style: theme.textTheme.bodyLarge!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 26),
                              )
                            ],
                          ),
                          Spacer(),
                          Image.asset(
                            appProvider.themeMode == ThemeMode.light
                                ? AppAssets.sunIcon
                                : AppAssets.moonIcon,
                            color: Colors.white,
                            width: 40,
                            height: 40,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            padding: EdgeInsets.all(4),
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12)),
                            child: Center(
                                child: Text(
                              appProvider.lang,
                              style: TextStyle(
                                  color:
                                      appProvider.themeMode == ThemeMode.light
                                          ? theme.primaryColor
                                          : theme.scaffoldBackgroundColor,
                                  fontWeight: FontWeight.bold),
                            )),
                          )
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.005,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: Colors.white,
                          ),
                          Text(
                            AppLocalizations.of(context)!.lo_loc,
                            style: theme.textTheme.bodyMedium!
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      DefaultTabController(
                          length: AppCategories.categories.length,
                          child: TabBar(
                              onTap: (value) {
                                provider.changeTabIndex(value);
                              },
                              indicatorPadding: EdgeInsets.all(0),
                              indicatorColor: Colors.transparent,
                              labelColor:
                                  appProvider.themeMode == ThemeMode.light
                                      ? theme.primaryColor
                                      : Colors.white,
                              dividerColor: Colors.transparent,
                              isScrollable: true,
                              tabAlignment: TabAlignment.start,
                              labelPadding: EdgeInsets.all(4),
                              unselectedLabelColor: Colors.white,
                              tabs: AppCategories.categories.map(
                                (e) {
                                  return Tab(
                                    child: Container(
                                        padding: EdgeInsets.only(
                                            top: 8,
                                            right: 16,
                                            bottom: 8,
                                            left: 16),
                                        decoration: BoxDecoration(
                                            color: provider.selectedTabIndex ==
                                                    AppCategories.categories
                                                        .indexOf(e)
                                                ? appProvider.themeMode ==
                                                        ThemeMode.light
                                                    ? Colors.white
                                                    : theme.primaryColor
                                                : Colors.transparent,
                                            border: Border.all(
                                                color: appProvider.themeMode ==
                                                        ThemeMode.light
                                                    ? Colors.white
                                                    : theme.primaryColor),
                                            borderRadius:
                                                BorderRadius.circular(46)),
                                        child: Row(
                                          children: [
                                            e.icon,
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              LocalizationHelper.getText(
                                                  context, e.id),
                                              style: TextStyle(fontSize: 18),
                                            ),
                                          ],
                                        )),
                                  );
                                },
                              ).toList())),
                    ],
                  ),
                ),
              ),
            ),
            body: ListView(
              children: [
                EventCardWidget(
                  lightImage: AppAssets.birthdayLight,
                  darkImage: AppAssets.birthdayDark,
                  day: AppLocalizations.of(context)!.h_dateDay,
                  month: AppLocalizations.of(context)!.h_dateMonth,
                  title: AppLocalizations.of(context)!.h_birthday_title,
                ),
                EventCardWidget(
                  lightImage: AppAssets.birthdayLight,
                  darkImage: AppAssets.birthdayDark,
                  day: AppLocalizations.of(context)!.h_dateDay,
                  month: AppLocalizations.of(context)!.h_dateMonth,
                  title: AppLocalizations.of(context)!.h_birthday_title,
                ),
                EventCardWidget(
                  lightImage: AppAssets.birthdayLight,
                  darkImage: AppAssets.birthdayDark,
                  day: AppLocalizations.of(context)!.h_dateDay,
                  month: AppLocalizations.of(context)!.h_dateMonth,
                  title: AppLocalizations.of(context)!.h_birthday_title,
                ),
                EventCardWidget(
                  lightImage: AppAssets.birthdayLight,
                  darkImage: AppAssets.birthdayDark,
                  day: AppLocalizations.of(context)!.h_dateDay,
                  month: AppLocalizations.of(context)!.h_dateMonth,
                  title: AppLocalizations.of(context)!.h_birthday_title,
                ),
              ],
            ),
            // body: ListView.builder(
            //   itemCount: provider.events.length,
            //   itemBuilder: (context, index) {
            //     return EventCardWidget(event: provider.events[index]);
            //   },
            // ),
          );
        },
      ),
    );
  }
}
