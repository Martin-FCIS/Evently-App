import 'package:event_app/core/routes/app_routes_name.dart';
import 'package:event_app/core/themes/app_colors.dart';
import 'package:event_app/firebase_managre/firebase_auth_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
            child: Text("Account Created Successfully")),
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
            child: Text("Welcom ${user?.user?.displayName ?? ""}")),
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
            child: Text("Invalid email or password")),
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
          child: Text(
              "The password reset link has been sent to [${emailController.text}]")),
      backgroundColor: Colors.transparent,
      elevation: 0,
      closeIconColor: Colors.red,
      showCloseIcon: true,
    ));

    notifyListeners();
  }
}
