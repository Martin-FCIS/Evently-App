import 'package:event_app/core/routes/app_routes_name.dart';
import 'package:event_app/core/themes/app_colors.dart';
import 'package:event_app/firebase_manager/firebase_auth_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthProvider extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  UserCredential? user;

  Future<void> createAccount(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      user = await FirebaseAuthManager.createAccount(
          nameController.text, emailController.text, passwordController.text);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Container(
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(AppLocalizations.of(context)!.sb_accCreatedSuc)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        closeIconColor: Colors.red,
        showCloseIcon: false,
        duration: Duration(seconds: 1),
      ));
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, RoutesName.loginScreen);
      });
      notifyListeners();
    }
  }

  Future<void> login(BuildContext context) async {
    user = await FirebaseAuthManager.login(
        emailController.text, passwordController.text);
    if (user?.user != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Container(
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(children: [
            Text(AppLocalizations.of(context)!.sb_welcome),
            SizedBox(
              width: 10,
            ),
            Text("' ${user?.user?.displayName} '" ?? " "),
          ]),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        closeIconColor: Colors.red,
        showCloseIcon: true,
        duration: Duration(seconds: 1),
      ));
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, RoutesName.layoutScreen);
      });
      notifyListeners();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Container(
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child:
                Text(AppLocalizations.of(context)!.sb_InvalidEmailOrPassword)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        closeIconColor: Colors.red,
        showCloseIcon: true,
      ));
    }
  }

  Future<void> resetPassword(BuildContext context) async {
    await FirebaseAuthManager.resetPassword(emailController.text);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Container(
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(children: [
            Text(AppLocalizations.of(context)!.sb_resetPass),
            SizedBox(
              width: 10,
            ),
            Text("' ${emailController.text} '"),
          ])),
      backgroundColor: Colors.transparent,
      elevation: 0,
      closeIconColor: Colors.red,
      showCloseIcon: true,
    ));

    notifyListeners();
  }

  Future<void> loginWithGoogle(BuildContext context) async {
    try {
      user = await FirebaseAuthManager.signInWithGoogle();
      if (user!.user?.uid != null) {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
        Future.delayed(
          Duration.zero,
          () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Container(
                padding: EdgeInsets.all(12),
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(children: [
                  Text(AppLocalizations.of(context)!.sb_welcome),
                  SizedBox(
                    width: 10,
                  ),
                  Text("' ${user!.user?.displayName} '"),
                ]),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              closeIconColor: Colors.red,
              showCloseIcon: true,
              duration: Duration(seconds: 1),
            ));
            Future.delayed(Duration(seconds: 2), () {
              Navigator.pushReplacementNamed(context, RoutesName.layoutScreen);
            });
          },
        );
        return;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
