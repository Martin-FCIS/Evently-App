import 'package:event_app/core/constants/app_assets.dart';
import 'package:event_app/core/manager/app_provider.dart';
import 'package:event_app/core/routes/app_routes_name.dart';
import 'package:event_app/core/widgets/custom_button.dart';
import 'package:event_app/core/widgets/custom_text_form_filed.dart';
import 'package:event_app/firebase_manager/models/event_model.dart';
import 'package:event_app/modules/event/manager/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_categories.dart';
import '../../../localization_helper.dart';
import '../widgets/custom_container.dart';

class CreateEvent extends StatefulWidget {
  final EventModel? event;

  const CreateEvent({super.key, this.event});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  EventProvider provider = EventProvider();

  @override
  void initState() {
    super.initState();
    if (widget.event != null) {
      provider.initData(widget.event!);
    }
  }

  @override
  Widget build(BuildContext context) {
    var appProvider = Provider.of<AppProvider>(context);
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return ChangeNotifierProvider.value(
      value: provider,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            !provider.isUpdate
                ? AppLocalizations.of(context)!.ca_createAcc
                : AppLocalizations.of(context)!.ed_editEvent,
            style: TextStyle(color: theme.primaryColor),
          ),
          iconTheme: IconThemeData(
            color: theme.primaryColor,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<EventProvider>(
            builder: (context, provider, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView(
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
                        DefaultTabController(
                            initialIndex: provider.selectedTabIndex - 1,
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
                                              top: 8,
                                              right: 16,
                                              bottom: 8,
                                              left: 16),
                                          decoration: BoxDecoration(
                                              color: provider
                                                          .selectedTabIndex ==
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
                          hintText: AppLocalizations.of(context)!.ca_eventTitle,
                        ),
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
                              hintText:
                                  AppLocalizations.of(context)!.ca_eventDesc,
                              alignLabelWithHint: true,
                              hintStyle: TextStyle(
                                color: appProvider.themeMode == ThemeMode.light
                                    ? Colors.grey
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.009,
                        ),
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
                                print(
                                    "____________________________${provider.eventLocation}");
                                provider.selectDate(context);
                              },
                              child: Text(
                                provider.selectedDate != null
                                    ? provider.getFormattedDate(
                                        context, provider.selectedDate)
                                    : AppLocalizations.of(context)!
                                        .ca_chooseDate,
                                style: theme.textTheme.bodyMedium!
                                    .copyWith(color: theme.primaryColor),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.005,
                        ),
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
                                    ? provider.getFormattedTime(
                                        context, provider.selectedTime)
                                    : AppLocalizations.of(context)!
                                        .ca_chooseTime,
                                style: theme.textTheme.bodyMedium!
                                    .copyWith(color: theme.primaryColor),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.009,
                        ),
                        Text(AppLocalizations.of(context)!.ed_locat,
                            style: theme.textTheme.bodyLarge),
                        SizedBox(
                          height: size.height * 0.007,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RoutesName.pickLocationScreen,
                                arguments: provider);
                          },
                          child: FutureBuilder<String>(
                            future: provider.eventLocation != null
                                ? provider
                                    .getLocationByName(provider.eventLocation!)
                                : Future.value(
                                    AppLocalizations.of(context)!.ed_location),
                            builder: (context, snapshot) {
                              return CustomContainer(
                                icon: Icons.my_location,
                                text1: snapshot.connectionState ==
                                        ConnectionState.waiting
                                    ? "Loading...."
                                    : snapshot.data ?? "Unknown Location",
                                suffixIcon: Icons.arrow_forward_ios_rounded,
                                textStyle: provider.eventLocation == null
                                    ? null
                                    : theme.textTheme.bodySmall!
                                        .copyWith(color: theme.primaryColor),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.009,
                        ),
                        CustomButton(
                            text: !provider.isUpdate
                                ? AppLocalizations.of(context)!.ca_addEvent
                                : AppLocalizations.of(context)!.ed_updateEvent,
                            onTap: () {
                              !provider.isUpdate
                                  ? provider.addEvent(context)
                                  : provider.updateEvent(context);
                            }),
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
