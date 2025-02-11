import 'package:flutter/material.dart';

class CustomTextFormFiled extends StatefulWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool isPassword;
  final String? labelText;
  Widget? prefixIcon;
  Widget? suffixIcon;

  CustomTextFormFiled(
      {super.key,
      this.controller,
      this.validator,
      this.isPassword = false,
      this.labelText,
      this.prefixIcon,
      this.suffixIcon});

  @override
  State<CustomTextFormFiled> createState() => _CustomTextFormFiledState();
}

class _CustomTextFormFiledState extends State<CustomTextFormFiled> {
  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isPassword?!isShow:false,
      validator: widget.validator,
      decoration: InputDecoration(
        prefixIcon: widget.isPassword ? Icon(Icons.lock) : widget.prefixIcon,
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  isShow = !isShow;
                  setState(() {});
                },
                icon: Icon(isShow
                    ? Icons.visibility_rounded
                    : Icons.visibility_off_rounded))
            : widget.suffixIcon,
        labelText: widget.labelText,
      ),
    );
  }
}
