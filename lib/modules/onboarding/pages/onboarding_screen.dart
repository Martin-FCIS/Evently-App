import 'package:animate_do/animate_do.dart';
import 'package:event_app/core/manager/app_provider.dart';
import 'package:event_app/core/routes/app_routes_name.dart';
import 'package:event_app/modules/onboarding/manager/onboarding_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_assets.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var appProvider = Provider.of<AppProvider>(context);
    return ChangeNotifierProvider(
      create: (context) => onboardingProvider(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<onboardingProvider>(
              builder: (context, provider, child) {
                List data = provider.getData(context);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      textDirection: TextDirection.ltr,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FadeInLeftBig(
                            child: Image.asset(
                          AppAssets.eventLogo,
                          width: 50,
                        )),
                        SizedBox(
                          width: size.width * 0.025,
                        ),
                        FadeInRightBig(
                          child: Text(
                            "Evently",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 35,
                                fontFamily: GoogleFonts.jockeyOne().fontFamily,
                                color: theme.primaryColor),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    Expanded(
                      child: PageView.builder(
                        controller: provider.controller,
                        onPageChanged: (value) {
                          provider.changePageViewIndex(provider.selectedIndex);
                        },
                        itemCount: data.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Image.asset(
                                  appProvider.themeMode == ThemeMode.light
                                      ? data[index].imageLight
                                      : data[index].imageDark,
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.08,
                              ),
                              Text(
                                data[index].title,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: GoogleFonts.inter().fontFamily,
                                    fontSize: 24,
                                    color: theme.primaryColor),
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              Text(data[index].desc,
                                  style: theme.textTheme.bodyMedium),
                              Spacer(),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      provider.controller.previousPage(
                                          duration: Duration(milliseconds: 300),
                                          curve: Curves.decelerate);
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(360),
                                            border: Border.all(
                                                color: theme.primaryColor)),
                                        child: index == 0
                                            ? SizedBox()
                                            : Icon(
                                                Icons.arrow_back_rounded,
                                                color: theme.primaryColor,
                                              )),
                                  ),
                                  Spacer(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(3, (currIndex) {
                                      return AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        height: 10,
                                        width: index == currIndex ? 25 : 10,
                                        decoration: BoxDecoration(
                                          color: index == currIndex
                                              ? theme.primaryColor
                                              : theme.primaryColorDark,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      );
                                    }),
                                  ),
                                  Spacer(),
                                  InkWell(
                                    onTap: () {
                                      index == data.length - 1
                                          ? Navigator.pushReplacementNamed(
                                              context, RoutesName.loginScreen)
                                          : provider.controller.nextPage(
                                              duration:
                                                  Duration(milliseconds: 300),
                                              curve: Curves.decelerate);
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(360),
                                            border: Border.all(
                                                color: theme.primaryColor)),
                                        child: Icon(
                                          Icons.arrow_forward_rounded,
                                          color: theme.primaryColor,
                                        )),
                                  ),
                                ],
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
