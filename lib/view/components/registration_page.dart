// ignore_for_file: use_build_context_synchronously

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
import 'package:task_company/view/components/user_picture_upload.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
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
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 20,
                          color: AppColors.textAndIconColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: GlobalValues.fontFamily,
                        ),
                      ),
                    ),
                    const UserPic(),
                  ],
                ),
              ),
              //  Name
              TitleWithField(
                textController: _textFieldValidate.nameController,
                title: "First Name",
                validator: _textFieldValidate.isName,
                formater: [
                  FilteringTextInputFormatter.allow(RegExp('[a-zA-Z أ-ي]')),
                  // FilteringTextInputFormatter.allow(RegExp(' ')),
                ],
                textInputType: TextInputType.name,
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
              // phone number
              TitleWithField(
                textController: _textFieldValidate.phoneController,
                title: "Phone Number",
                validator: _textFieldValidate.isPhoneNumber,
                formater: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                ],
                textInputType: TextInputType.phone,
                disableMaxLen: false,
                suffixIcon: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '🇯🇴',
                      style: TextStyle(color: AppColors.textAndIconColor),
                    ),
                  ],
                ),
              ),

              // password
              TitleWithField(
                textController: _textFieldValidate.passwordController,
                title: "password",
                validator: _textFieldValidate.isPass,
                helperText: 'Password must be at lest 10 characters',
                // suffixIcon: Icon(
                //   LineIcons.googleLogo,
                //   color: AppColors.textAndIconColor,
                // ),
                formater: [
                  FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9]")),
                ],
                textInputType: TextInputType.emailAddress,
              ),
              // confierm password
              TitleWithField(
                textController: _textFieldValidate.confirmPasswordController,
                title: "Confirem password",
                validator: (text) => _textFieldValidate.isEqualPass(
                    text, _textFieldValidate.passwordController.text),
                formater: [
                  FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9]")),
                ],
                textInputType: TextInputType.phone,
                disableMaxLen: false,
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
                              await FirebaseAuthuntication().signInWithEmail(
                            context: context,
                            userDataClass: (value) {
                              ref.read(userAccount.notifier).state = value;
                            },
                            email:
                                _textFieldValidate.emailController.text.trim(),
                            pass: _textFieldValidate.passwordController.text
                                .trim(),
                            image: ref.read(userPictureProvider),
                            name: _textFieldValidate.nameController.text,
                            phoneNumber:
                                _textFieldValidate.phoneController.text,
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
                      "Have Account ? ",
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textAndIconColor,
                        fontWeight: FontWeight.bold,
                        fontFamily: GlobalValues.fontFamily,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        ref.read(swiperController.notifier).state.move(0);
                      },
                      child: Text(
                        'LogIn',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.buttonColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: GlobalValues.fontFamily,
                        ),
                      ),
                    )
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
