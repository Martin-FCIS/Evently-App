import 'package:event_app/core/manager/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../manager/layout_provider.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var appProvider = Provider.of<AppProvider>(context);
    return Consumer<LayoutProvider>(
      builder: (context, provider, child) {
        return Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniEndTop,
            floatingActionButton: FloatingActionButton(
              elevation: 0,
              onPressed: () {
                provider.getLocation();
              },
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: theme.primaryColor,
                    borderRadius: BorderRadius.circular(8)),
                child: Icon(
                  Icons.my_location,
                  color: theme.primaryColorLight,
                ),
              ),
            ),
            body: Column(
              children: [
                Expanded(
                    child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: provider.cameraPosition,
                  onMapCreated: (controller) {
                    provider.mapController = controller;
                  },
                  markers: provider.markers,
                ))
              ],
            ));
      },
    );
  }
}
