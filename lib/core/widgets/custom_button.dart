import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function() onTap;

  CustomButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    var theme=Theme.of(context);
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: theme.primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  padding: EdgeInsets.all(16)),
              onPressed: () {
                onTap();
              },
              child: Text(
                text,
                style: TextStyle(
                    fontFamily: GoogleFonts
                        .inter()
                        .fontFamily,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              )),
        ),
      ],
    );
  }
}
