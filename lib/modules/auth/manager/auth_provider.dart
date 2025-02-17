import 'package:event_app/core/manager/app_provider.dart';
import 'package:event_app/core/routes/app_routes_name.dart';
import 'package:event_app/firebase_manager/firebase_auth_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthProvider extends ChangeNotifier {
  final AppProvider _provider = AppProvider();
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
      _provider.showSnackBar(
          context: context,
          message: AppLocalizations.of(context)!.sb_accCreatedSuc,
          showCloseIcon: false);
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
      _provider.showSnackBar(
          context: context,
          message: AppLocalizations.of(context)!.sb_welcome,
          showCloseIcon: true,
          isLoginOrResetPass: true,
          userNameOrEmail: "' ${user?.user?.displayName} '");
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, RoutesName.layoutScreen);
      });
      notifyListeners();
    } else {
      _provider.showSnackBar(
          context: context,
          message: AppLocalizations.of(context)!.sb_InvalidEmailOrPassword,
          showCloseIcon: true);
    }
  }

  Future<void> resetPassword(BuildContext context) async {
    await FirebaseAuthManager.resetPassword(emailController.text);
    _provider.showSnackBar(
        context: context,
        message: AppLocalizations.of(context)!.sb_resetPass,
        showCloseIcon: true,
        isLoginOrResetPass: true,
        userNameOrEmail: "' ${emailController.text} '");
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
            _provider.showSnackBar(
                context: context,
                message: AppLocalizations.of(context)!.sb_welcome,
                showCloseIcon: true,
                isLoginOrResetPass: true,
                userNameOrEmail: "' ${user?.user?.displayName} '");
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
