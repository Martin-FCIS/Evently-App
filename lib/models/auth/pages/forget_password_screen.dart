import 'package:event_app/core/constants/app_assets.dart';
import 'package:event_app/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/manager/app_provider.dart';
import '../../../core/routes/app_routes_name.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var provider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.f_forget,
          ),

          leading: IconButton(onPressed: (){
            Navigator.pushReplacementNamed(context,RoutesName.loginScreen);
          }, icon: Icon(Icons.arrow_back,color:provider.themeMode == ThemeMode.light? Colors.black:theme.primaryColor,))
      ),
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Image.asset(AppAssets.resetPass),
            SizedBox(height: size.height*0.04,),
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email_rounded),
                labelText: AppLocalizations.of(context)!.l_email,
              ),
            ),
            SizedBox(height: size.height*0.04,),
      
            CustomButton(text: AppLocalizations.of(context)!.f_reset, onTap: (){})
          ],
        ),
      ),
    ),
    );
  }
}
