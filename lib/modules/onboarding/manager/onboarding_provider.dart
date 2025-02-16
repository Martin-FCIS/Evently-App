import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_onboarding.dart';

class onboardingProvider extends ChangeNotifier {


  List<OnboardingData> getData(BuildContext context) {
    return [
      OnboardingData(
        imageLight: AppAssets.onboarding1Light,
        imageDark: AppAssets.onboarding1Dark,
        title: AppLocalizations.of(context)!.ob_1title,
        desc: AppLocalizations.of(context)!.ob_1desc,
      ),
      OnboardingData(
        imageLight: AppAssets.onboarding2Light,
        imageDark: AppAssets.onboarding2Dark,
        title: AppLocalizations.of(context)!.ob_2title,
        desc: AppLocalizations.of(context)!.ob_2desc,
      ),
      OnboardingData(
        imageLight: AppAssets.onboarding3Light,
        imageDark: AppAssets.onboarding3Dark,
        title: AppLocalizations.of(context)!.ob_3title,
        desc: AppLocalizations.of(context)!.ob_3desc,
      )
    ];
  }

  int selectedIndex = 0;
  PageController controller = PageController();

  void changePageViewIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
