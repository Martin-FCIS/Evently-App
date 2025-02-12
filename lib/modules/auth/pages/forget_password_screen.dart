import 'package:event_app/core/constants/app_assets.dart';
import 'package:event_app/core/widgets/custom_button.dart';
import 'package:event_app/core/widgets/custom_text_form_filed.dart';
import 'package:event_app/modules/auth/manager/auth_provider.dart';
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
    var appProvider = Provider.of<AppProvider>(context);
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: Consumer<AuthProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                AppLocalizations.of(context)!.f_forget,
              ),
              iconTheme: IconThemeData(
                color: appProvider.themeMode == ThemeMode.light
                    ? Colors.black
                    : theme.primaryColor,
              ),
            ),
            body: Form(
              key: provider.formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Image.asset(AppAssets.resetPass),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      CustomTextFormFiled(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Invalid Email";
                          }
                        },
                        controller: provider.emailController,
                        prefixIcon: Icon(
                          Icons.email_rounded,
                          color: appProvider.themeMode == ThemeMode.light
                              ? Colors.grey
                              : Colors.white,
                        ),
                        labelText: AppLocalizations.of(context)!.l_email,
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      CustomButton(
                          text: AppLocalizations.of(context)!.f_reset,
                          onTap: () {
                            if (provider.formKey.currentState!.validate()) {
                              provider.resetPassword(context);
                            }
                          })
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
