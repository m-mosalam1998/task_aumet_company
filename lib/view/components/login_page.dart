import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icons.dart';
import 'package:task_company/controller/dataBase/auth.dart';
import 'package:task_company/controller/providers.dart';
import 'package:task_company/controller/validate_controll_text_filed.dart';
import 'package:task_company/global/colors.dart';
import 'package:task_company/global/values.dart';
import 'package:task_company/view/widget/button.dart';
import 'package:task_company/view/widget/dialog.dart';
import 'package:task_company/view/widget/text_field.dart';

class LogInPage extends StatefulWidget {
  LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final TextFieldValidateAndController _textFieldValidate =
      TextFieldValidateAndController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Center(
        child: Form(
          key: _textFieldValidate.formKeyLogin,
          child: Column(
            children: [
              // header
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'LogIn',
                    style: TextStyle(
                      fontSize: 20,
                      color: AppColors.textAndIconColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: GlobalValues.fontFamily,
                    ),
                  ),
                ),
              ),

              // Email
              TitleWithField(
                textController: _textFieldValidate.emailController,
                title: "Email",
                validator: _textFieldValidate.isEmail,
                suffixIcon: Icon(
                  LineIcons.googleLogo,
                  color: AppColors.textAndIconColor,
                ),
                formater: [
                  FilteringTextInputFormatter.deny(RegExp('[أ-ي]')),
                ],
                textInputType: TextInputType.emailAddress,
              ),

              // password
              TitleWithField(
                textController: _textFieldValidate.passwordController,
                title: "password",
                validator: _textFieldValidate.isPass,
                helperText: 'Password must be at lest 10 characters',
                formater: [
                  FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9]")),
                ],
                textInputType: TextInputType.emailAddress,
              ),

              Consumer(
                builder: (context, ref, child) {
                  return CustomButton(
                      text: 'Login',
                      onTap: () async {
                        if (_textFieldValidate.formKeyLogin.currentState!
                            .validate()) {
                          _textFieldValidate.formKeyLogin.currentState!.save();
                          Dialoges().loadingDialod(context: context);
                          bool check =
                              await FirebaseAuthuntication().loginUsingEmail(
                            context: context,
                            email:
                                _textFieldValidate.emailController.text.trim(),
                            userDataClass: (value) {
                              ref.read(userAccount.notifier).state = value;
                            },
                            pass: _textFieldValidate.passwordController.text
                                .trim(),
                          );
                          if (check) {
                            Navigator.pop(context);
                            Navigator.popAndPushNamed(context, '/home');
                          }
                        }
                      });
                },
              ),
              Consumer(builder: (_, ref, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Not have account ? ",
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textAndIconColor,
                        fontWeight: FontWeight.bold,
                        fontFamily: GlobalValues.fontFamily,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          ref.read(swiperController.notifier).state.move(1);
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.buttonColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: GlobalValues.fontFamily,
                          ),
                        ))
                  ],
                );
              }),
            ],
          ),
        ),
      )),
    );
  }
}
