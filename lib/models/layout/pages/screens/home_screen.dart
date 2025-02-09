import 'package:event_app/core/manager/app_provider.dart';
import 'package:event_app/models/layout/widgets/event_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/constants/app_assets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var appProvider = Provider.of<AppProvider>(context);
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
        flexibleSpace: Container(
          child: SafeArea(
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
                            AppLocalizations.of(context)!.lo_name,
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
                              color: appProvider.themeMode == ThemeMode.light
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
                ],
              ),
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
    );
  }
}
