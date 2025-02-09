import 'package:event_app/core/constants/app_assets.dart';
import 'package:event_app/core/manager/app_provider.dart';
import 'package:event_app/models/layout/manager/layout_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var appProvider = Provider.of<AppProvider>(context);
    return ChangeNotifierProvider(
      create: (context) => LayoutProvider(),
      child: Consumer<LayoutProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(360),
                  side: BorderSide(width: 5, color: Colors.white)),
              backgroundColor: appProvider.themeMode == ThemeMode.light
                  ? theme.primaryColor
                  : theme.scaffoldBackgroundColor,
              onPressed: () {},
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: provider.selectedIndex,
                onTap: (value) {
                  provider.changeBtnNavIndex(value);
                },
                backgroundColor: appProvider.themeMode == ThemeMode.light
                    ? theme.primaryColor
                    : theme.scaffoldBackgroundColor,
                fixedColor: Colors.white,
                unselectedItemColor: Colors.white,
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(AppAssets.homeIcon),
                      label: AppLocalizations.of(context)!.lo_home,
                      activeIcon: SvgPicture.asset(AppAssets.selectedHomeIcon)),
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(AppAssets.mapIcon),
                      label: AppLocalizations.of(context)!.lo_map,
                      activeIcon: SvgPicture.asset(AppAssets.selectedMapIcon)),
                  // BottomNavigationBarItem(icon: SizedBox(), label: ""),
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(AppAssets.favIcon),
                      label: AppLocalizations.of(context)!.lo_love,
                      activeIcon: SvgPicture.asset(AppAssets.selectedFavIcon)),
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(AppAssets.userIcon),
                      label: AppLocalizations.of(context)!.lo_profile,
                      activeIcon: SvgPicture.asset(AppAssets.selectedUserIcon)),
                ]),
            body: provider.screens[provider.selectedIndex],
          );
        },
      ),
    );
  }
}
