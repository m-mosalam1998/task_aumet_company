import 'package:flutter/material.dart';
import 'package:task_company/global/colors.dart';
import 'package:task_company/global/values.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, required this.text, required this.onTap})
      : super(key: key);
  final String text;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(primary: AppColors.buttonColor),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          color: AppColors.textAndIconColor,
          fontWeight: FontWeight.bold,
          fontFamily: GlobalValues.fontFamily,
        ),
      ),
    );
  }
}
