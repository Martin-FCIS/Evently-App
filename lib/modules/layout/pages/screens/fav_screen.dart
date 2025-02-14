import 'package:event_app/core/constants/app_assets.dart';
import 'package:event_app/core/widgets/custom_text_form_filed.dart';
import 'package:event_app/modules/layout/manager/layout_provider.dart';
import 'package:event_app/modules/layout/widgets/event_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({super.key});

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  @override
  void initState() {
    Provider.of<LayoutProvider>(context, listen: false).getEventsFavStream();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Consumer<LayoutProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(),
          body: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextFormFiled(
                prefixIcon: ImageIcon(
                  AssetImage(AppAssets.searchIcon),
                  color: theme.primaryColor,
                ),
                labelText: "Search for Event",
                labelColor: theme.primaryColor,
              ),
            ),
            Expanded(
              child: provider.favEvents.isEmpty
                  ? Center(
                      child: Text(
                        "No Favorite Events Yet",
                        style: TextStyle(
                            color: theme.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    )
                  : ListView.builder(
                      itemCount: provider.favEvents.length,
                      itemBuilder: (context, index) {
                        return EventCardWidget(
                          event: provider.favEvents[index],
                        );
                      },
                    ),
            )
          ]),
        );
      },
    );
  }
}
