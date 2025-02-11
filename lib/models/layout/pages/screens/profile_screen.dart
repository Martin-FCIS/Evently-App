import 'package:event_app/core/routes/app_routes_name.dart';
import 'package:event_app/core/themes/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/manager/app_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var size = MediaQuery.of(context).size;
    var appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
          backgroundColor: appProvider.themeMode == ThemeMode.light
              ? theme.primaryColor
              : theme.scaffoldBackgroundColor,
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(64),
              ),
              borderSide: BorderSide(color: Colors.transparent)),
          toolbarHeight: size.height * 0.22,
          flexibleSpace: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                textDirection: TextDirection.ltr,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(360),
                        bottomRight: Radius.circular(360),
                        bottomLeft: Radius.circular(360),
                      ),
                      child: Image.asset(
                        AppAssets.routeProfileLogo,
                        width: 120,
                        height: 120,
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      textDirection: TextDirection.ltr,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          FirebaseAuth.instance.currentUser?.displayName
                                  ?.toUpperCase() ??
                              "",
                          style: theme.textTheme.bodyLarge!.copyWith(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          FirebaseAuth.instance.currentUser?.email ?? "",
                          textDirection: TextDirection.ltr,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.04,
            ),
            Text(
              AppLocalizations.of(context)!.lang,
              style: theme.textTheme.bodyLarge!.copyWith(
                  color: theme.primaryColorDark, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: theme.primaryColor)),
              child: DropdownButton(
                dropdownColor: appProvider.themeMode == ThemeMode.dark
                    ? theme.scaffoldBackgroundColor
                    : null,
                underline: SizedBox(),
                isExpanded: true,
                value: appProvider.lang,
                items: [
                  DropdownMenuItem(
                      value: "en",
                      child: Text(AppLocalizations.of(context)!.p_english,
                          style: theme.textTheme.bodyLarge!
                              .copyWith(color: theme.primaryColor))),
                  DropdownMenuItem(
                      value: "ar",
                      child: Text(
                        AppLocalizations.of(context)!.p_arabic,
                        style: theme.textTheme.bodyLarge!
                            .copyWith(color: theme.primaryColor),
                      )),
                ],
                onChanged: (value) {
                  appProvider.changeLanguage(value);
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              AppLocalizations.of(context)!.theme,
              style: theme.textTheme.bodyLarge!.copyWith(
                  color: theme.primaryColorDark, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: theme.primaryColor)),
              child: DropdownButton(
                dropdownColor: appProvider.themeMode == ThemeMode.dark
                    ? theme.scaffoldBackgroundColor
                    : null,
                underline: SizedBox(),
                isExpanded: true,
                value: appProvider.themeMode,
                items: [
                  DropdownMenuItem(
                      value: ThemeMode.light,
                      child: Text(
                        AppLocalizations.of(context)!.p_light,
                        style: theme.textTheme.bodyLarge!
                            .copyWith(color: theme.primaryColor),
                      )),
                  DropdownMenuItem(
                      value: ThemeMode.dark,
                      child: Text(AppLocalizations.of(context)!.p_dark,
                          style: theme.textTheme.bodyLarge!
                              .copyWith(color: theme.primaryColor))),
                ],
                onChanged: (value) {
                  appProvider.changeTheme(value);
                },
              ),
            ),
            Spacer(),
            InkWell(
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, RoutesName.loginScreen);
              },
              child: Container(
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                    color: AppColors.logoutBtn,
                    borderRadius: BorderRadius.circular(16)),
                child: Row(
                  children: [
                    Icon(
                      Icons.logout_rounded,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      AppLocalizations.of(context)!.p_logout,
                      style: theme.textTheme.bodyLarge!
                          .copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
