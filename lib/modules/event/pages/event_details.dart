import 'package:event_app/core/constants/app_assets.dart';
import 'package:event_app/core/routes/app_routes_name.dart';
import 'package:event_app/firebase_manager/models/event_model.dart';
import 'package:event_app/modules/event/manager/event_provider.dart';
import 'package:event_app/modules/event/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../core/manager/app_provider.dart';

class EventDetails extends StatelessWidget {
  final EventModel event;

  const EventDetails({super.key, required this.event});

  @override
  @override
  Widget build(BuildContext context) {
    var appProvider = Provider.of<AppProvider>(context);
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return ChangeNotifierProvider(
      create: (context) => EventProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.ed_eventDetails,
            style: TextStyle(color: theme.primaryColor),
          ),
          iconTheme: IconThemeData(
            color: theme.primaryColor,
          ),
          actions: [
            InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.createEventScreen,
                      arguments: event);
                },
                child: ImageIcon(AssetImage(AppAssets.editEventIcon))),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  EventProvider().deleteEvent(context, event);
                },
                child: ImageIcon(
                  AssetImage(AppAssets.deleteEventIcon),
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<EventProvider>(
            builder: (context, provider, child) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        appProvider.themeMode == ThemeMode.light
                            ? event.categoryImageLight
                            : event.categoryImageDark,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Text(
                      event.title,
                      style: theme.textTheme.bodyLarge!
                          .copyWith(color: theme.primaryColor, fontSize: 28),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    CustomContainer(
                      icon: Icons.calendar_month_rounded,
                      text1: provider.getFormattedDate(context, event.date),
                      text2: provider.getFormattedTime(context, event.time),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    FutureBuilder<String>(
                      future: provider
                          .getLocationByName(LatLng(event.lat, event.long)),
                      builder: (context, snapshot) {
                        return CustomContainer(
                          icon: Icons.my_location,
                          text1: snapshot.data ?? "Unknown Location",
                          textStyle: theme.textTheme.bodySmall!.copyWith(
                            color: theme.primaryColor,
                          ),
                          suffixIcon: Icons.arrow_forward_ios_rounded,
                        );
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: theme.primaryColor),
                          borderRadius: BorderRadius.circular(16)),
                      width: double.infinity,
                      height: size.height * 0.4,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: GoogleMap(
                            scrollGesturesEnabled: false,
                            tiltGesturesEnabled: false,
                            zoomGesturesEnabled: false,
                            markers: {
                              Marker(
                                  markerId: MarkerId("0"),
                                  position: LatLng(event.lat, event.long)),
                            },
                            mapType: MapType.normal,
                            initialCameraPosition: CameraPosition(
                                target: LatLng(event.lat, event.long),
                                zoom: 17)),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Text(
                      AppLocalizations.of(context)!.ca_desc,
                      style: theme.textTheme.bodyLarge!
                          .copyWith(color: theme.primaryColorDark),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Text(event.desc),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
