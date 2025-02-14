import 'package:event_app/core/constants/app_assets.dart';
import 'package:event_app/core/manager/app_provider.dart';
import 'package:event_app/core/widgets/custom_button.dart';
import 'package:event_app/core/widgets/custom_text_form_filed.dart';
import 'package:event_app/modules/event/manager/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_categories.dart';
import '../../../localization_helper.dart';

class CreateEvent extends StatelessWidget {
  const CreateEvent({super.key});

  @override
  Widget build(BuildContext context) {
    var appProvider = Provider.of<AppProvider>(context);
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return ChangeNotifierProvider(
      create: (context) => EventProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.ca_createAcc),
          iconTheme: IconThemeData(
            color: appProvider.themeMode == ThemeMode.light
                ? Colors.black
                : theme.primaryColor,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<EventProvider>(
            builder: (context, provider, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        appProvider.themeMode == ThemeMode.light
                            ? AppCategories
                                .categories[provider.selectedTabIndex]
                                .lightimage
                            : AppCategories
                                .categories[provider.selectedTabIndex]
                                .darkimage,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )),
                  Spacer(),
                  DefaultTabController(
                      length: AppCategories.categories.length - 1,
                      child: TabBar(
                          onTap: (value) {
                            provider.changeTabIndex(value + 1);
                          },
                          indicatorPadding: EdgeInsets.all(0),
                          indicatorColor: Colors.transparent,
                          labelColor: theme.primaryColorLight,
                          dividerColor: Colors.transparent,
                          isScrollable: true,
                          tabAlignment: TabAlignment.start,
                          labelPadding: EdgeInsets.all(4),
                          unselectedLabelColor: theme.primaryColor,
                          tabs: AppCategories.categories.skip(1).map(
                            (e) {
                              return Tab(
                                child: Container(
                                    padding: EdgeInsets.only(
                                        top: 8, right: 16, bottom: 8, left: 16),
                                    decoration: BoxDecoration(
                                        color: provider.selectedTabIndex ==
                                                AppCategories.categories
                                                    .indexOf(e)
                                            ? theme.primaryColor
                                            : appProvider.themeMode ==
                                                    ThemeMode.light
                                                ? Colors.white
                                                : Colors.transparent,
                                        border: Border.all(
                                            color: theme.primaryColor),
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
                  Spacer(),
                  Text(
                    AppLocalizations.of(context)!.ca_title,
                    style: theme.textTheme.bodyLarge,
                  ),
                  SizedBox(
                    height: size.height * 0.007,
                  ),
                  CustomTextFormFiled(
                    controller: provider.titleController,
                    prefixIcon: ImageIcon(
                      AssetImage(AppAssets.titleIcon),
                      color: appProvider.themeMode == ThemeMode.light
                          ? Colors.grey
                          : Colors.white,
                    ),
                    labelText: AppLocalizations.of(context)!.ca_eventTitle,
                  ),
                  Spacer(),
                  Text(
                    AppLocalizations.of(context)!.ca_desc,
                    style: theme.textTheme.bodyLarge,
                  ),
                  SizedBox(
                    height: size.height * 0.007,
                  ),
                  SizedBox(
                    height: 150,
                    child: TextFormField(
                      controller: provider.descController,
                      maxLines: null,
                      minLines: null,
                      expands: true,
                      textAlignVertical: TextAlignVertical.top,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.ca_eventDesc,
                        alignLabelWithHint: true,
                        labelStyle: TextStyle(
                          color: appProvider.themeMode == ThemeMode.light
                              ? Colors.grey
                              : Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      ImageIcon(
                        AssetImage(AppAssets.calenderIcon),
                        color: appProvider.themeMode == ThemeMode.light
                            ? Colors.black
                            : Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        AppLocalizations.of(context)!.ca_eventDate,
                        style: theme.textTheme.bodyLarge,
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          provider.selectDate(context);
                        },
                        child: Text(
                          provider.selectedDate != null
                              ? DateFormat.yMMMMd(
                                      AppLocalizations.of(context)!.localeName)
                                  .format(provider.selectedDate!)
                              : AppLocalizations.of(context)!.ca_chooseDate,
                          style: theme.textTheme.bodyMedium!
                              .copyWith(color: theme.primaryColor),
                        ),
                      )
                    ],
                  ),
                  Spacer(),
                  Row(
                    children: [
                      ImageIcon(
                        AssetImage(AppAssets.clockIcon),
                        color: appProvider.themeMode == ThemeMode.light
                            ? Colors.black
                            : Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        AppLocalizations.of(context)!.ca_eventTime,
                        style: theme.textTheme.bodyLarge,
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          provider.selectTime(context);
                        },
                        child: Text(
                          provider.selectedTime != null
                              ? DateFormat.jm(
                                      AppLocalizations.of(context)!.localeName)
                                  .format(DateTime(
                                      2000,
                                      1,
                                      1,
                                      provider.selectedTime!.hour,
                                      provider.selectedTime!.minute))
                              : AppLocalizations.of(context)!.ca_chooseTime,
                          style: theme.textTheme.bodyMedium!
                              .copyWith(color: theme.primaryColor),
                        ),
                      )
                    ],
                  ),
                  Spacer(),
                  CustomButton(
                      text: AppLocalizations.of(context)!.ca_addEvent,
                      onTap: () {
                        provider.addEvent(context);
                      }),
                  Spacer(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
