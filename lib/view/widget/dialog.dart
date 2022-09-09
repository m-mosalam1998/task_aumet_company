import 'package:flutter/material.dart';
import 'package:task_company/global/colors.dart';
import 'package:task_company/global/values.dart';
import 'package:task_company/view/widget/button.dart';

class Dialoges {
  Future showErrorDialog(
      {required BuildContext context, required String errorMassage}) async {
    return await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) {
          return AlertDialog(
            title: const Text('Error !!!'),
            titleTextStyle: TextStyle(
              fontSize: 16,
              color: AppColors.textAndIconColor,
              fontWeight: FontWeight.bold,
              fontFamily: GlobalValues.fontFamily,
            ),
            content: Text(
              errorMassage,
              style: TextStyle(
                fontSize: 13,
                color: AppColors.textAndIconColor,
                fontWeight: FontWeight.bold,
                fontFamily: GlobalValues.fontFamily,
              ),
            ),
            actions: [
              CustomButton(
                onTap: () {
                  Navigator.pop(context);
                },
                text: 'Ok',
              )
            ],
          );
        });
  }

  Future loadingDialod({required BuildContext context}) async {
    return showDialog(
        context: context,
        builder: (_) => const AlertDialog(
              content: SizedBox(
                  height: 200,
                  child: Center(child: CircularProgressIndicator())),
            ));
  }
}
