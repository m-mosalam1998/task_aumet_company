import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:line_icons/line_icons.dart';
import 'package:task_company/controller/dataBase/auth.dart';
import 'package:task_company/controller/validate_controll_text_filed.dart';
import 'package:task_company/global/colors.dart';
import 'package:task_company/global/values.dart';
import 'package:task_company/model/user.dart';
import 'package:task_company/view/widget/button.dart';
import 'package:task_company/view/widget/text_field.dart';
import 'package:task_company/view/widget/user_picture.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                        'Login',
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
              CustomButton(
                  text: 'Login',
                  onTap: () async {
                    if (_textFieldValidate.formKeyLogin.currentState!
                        .validate()) {
                      _textFieldValidate.formKeyLogin.currentState!.save();
                      await showDialog(
                        context: context,
                        builder: (context) => FutureProgressDialog(
                          FirebaseAuthuntication().signInWithEmail(
                              context: context,
                              email: _textFieldValidate.emailController.text
                                  .trim()),
                        ),
                      );
                      User _user = User(
                          name: _textFieldValidate.nameController.text,
                          email: _textFieldValidate.emailController.text.trim(),
                          phoneNumber:
                              _textFieldValidate.phoneController.text.trim(),
                          imageUrl: imageUrl);
                    }
                  }),
            ],
          ),
        ),
      )),
    );
  }
}
