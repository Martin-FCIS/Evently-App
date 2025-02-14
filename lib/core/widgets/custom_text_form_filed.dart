import 'package:event_app/core/manager/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomTextFormFiled extends StatefulWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool isPassword;
  final String? labelText;
  Color? labelColor;

  // final int? minLines;
  // final int? maxLines;
  bool? isExpanded;
  Widget? prefixIcon;
  Widget? suffixIcon;

  CustomTextFormFiled(
      {super.key,
      this.controller,
      this.validator,
      this.isPassword = false,
      this.labelText,
      this.labelColor = null,
      // this.isExpanded,
      this.prefixIcon,
      this.suffixIcon});

  @override
  State<CustomTextFormFiled> createState() => _CustomTextFormFiledState();
}

class _CustomTextFormFiledState extends State<CustomTextFormFiled> {
  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    var appProvider = Provider.of<AppProvider>(context);
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isPassword ? !isShow : false,
      validator: widget.validator,
      // expands: widget.isExpanded ?? false,
      //  maxLines: null,
      //  minLines:null ,
      // textAlignVertical:TextAlignVertical.top,
      decoration: InputDecoration(
        // alignLabelWithHint: true,
        prefixIcon: widget.isPassword
            ? Icon(
                Icons.lock,
                color: appProvider.themeMode == ThemeMode.light
                    ? Colors.grey
                    : Colors.white,
              )
            : widget.prefixIcon,
        labelStyle: TextStyle(
            color: widget.labelColor ??
                (appProvider.themeMode == ThemeMode.light
                    ? Colors.grey
                    : Colors.white)),
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  isShow = !isShow;
                  setState(() {});
                },
                icon: Icon(isShow
                    ? Icons.visibility_rounded
                    : Icons.visibility_off_rounded),
                color: appProvider.themeMode == ThemeMode.light
                    ? Colors.grey
                    : Colors.white,
              )
            : widget.suffixIcon,
        labelText: widget.labelText,
      ),
    );
  }
}
