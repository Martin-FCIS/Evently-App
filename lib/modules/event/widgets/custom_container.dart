import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  IconData icon;
  String text1;
  String? text2;
  IconData? suffixIcon;

  CustomContainer({
    super.key,
    required this.icon,
    required this.text1,
    this.text2,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: theme.primaryColor)),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: theme.primaryColor,
                borderRadius: BorderRadius.circular(8)),
            child: Icon(
              icon,
              color: theme.primaryColorLight,
            ),
          ),
          SizedBox(
            width: 6,
          ),
          text2 != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text1,
                      style: theme.textTheme.bodyMedium!
                          .copyWith(color: theme.primaryColor),
                    ),
                    Text(text2!),
                  ],
                )
              : Text(
                  text1,
                  style: theme.textTheme.bodyMedium!
                      .copyWith(color: theme.primaryColor),
                ),
          Spacer(),
          Icon(
            suffixIcon,
            color: theme.primaryColor,
          ),
        ],
      ),
    );
  }
}
