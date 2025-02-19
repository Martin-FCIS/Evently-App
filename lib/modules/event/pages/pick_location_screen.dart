import 'package:event_app/modules/event/manager/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class PickLocationScreen extends StatefulWidget {
  final EventProvider provider;

  PickLocationScreen({super.key, required this.provider});

  @override
  State<PickLocationScreen> createState() => _PickLocationScreenState();
}

class _PickLocationScreenState extends State<PickLocationScreen> {
  late EventProvider provider = widget.provider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provider.getLocation(context);
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ChangeNotifierProvider.value(
      value: provider,
      child: Scaffold(
          body: Consumer<EventProvider>(builder: (context, provider, child) {
        if (!provider.isLocationGranted) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Column(
          children: [
            Expanded(
                child: GoogleMap(
              onTap: (location) {
                provider.changeEventLocation(location);
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(AppLocalizations.of(context)!.ad_conf),
                      content: Text(
                        AppLocalizations.of(context)!.ad_chooseLoc,
                        style: TextStyle(color: theme.primaryColor),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(AppLocalizations.of(context)!.ad_no,
                              style: TextStyle(color: theme.primaryColor)),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          child: Text(AppLocalizations.of(context)!.ad_yes,
                              style: TextStyle(color: theme.primaryColor)),
                        ),
                      ],
                    );
                  },
                );
              },
              mapType: MapType.normal,
              initialCameraPosition: provider.cameraPosition,
              onMapCreated: (controller) {
                provider.mapController = controller;
              },
              markers: provider.markers,
            )),
            Container(
              padding: EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(color: theme.primaryColor),
              child: Center(
                  child: Text(
                AppLocalizations.of(context)!.tabOnLoc,
                style: theme.textTheme.bodyLarge!.copyWith(color: Colors.white),
              )),
            )
          ],
        );
      })),
    );
  }
}
