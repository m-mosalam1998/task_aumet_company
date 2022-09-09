import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_company/controller/dataBase/auth.dart';
import 'package:task_company/controller/providers.dart';
import 'package:task_company/global/colors.dart';
import 'package:task_company/global/values.dart';
import 'package:task_company/view/widget/button.dart';

class EmailActivation extends ConsumerWidget {
  const EmailActivation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(chackvildateEmail.notifier);
    ref.listen<bool>(chackvildateEmail, (previous, next) {
      if (next) {
        Navigator.pushNamed(context, '/home');
      }
    });
    controller.state = FirebaseAuthuntication().isActivedUser();

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Please check email ,and activate your account by using url  send in  email',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textAndIconColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: GlobalValues.fontFamily,
                ),
              ),
              Row(
                children: [
                  CustomButton(
                    onTap: () {
                      controller.state = false;
                    },
                    text: 'Check validate',
                  ),
                  CustomButton(
                    onTap: () {
                      Navigator.pushNamed(context, '/home');
                    },
                    text: 'Skip later',
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
