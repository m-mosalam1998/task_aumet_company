import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_company/global/colors.dart';
import 'package:task_company/global/values.dart';

class TitleWithField extends StatelessWidget {
  const TitleWithField(
      {Key? key,
      required this.title,
      required this.validator,
      required this.textInputType,
      required this.formater,
      required this.textController,
      this.suffixIcon,
      this.onChange,
      this.widthTitle,
      this.helperText,
      this.disableMaxLen = true})
      : super(key: key);
  final String title;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? formater;
  final Function(String? value)? onChange;
  final Widget? suffixIcon;
  final bool disableMaxLen;
  final double? widthTitle;
  final String? helperText;
  final TextEditingController textController;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: widthTitle ?? 100,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textAndIconColor,
                fontWeight: FontWeight.bold,
                fontFamily: GlobalValues.fontFamily,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            margin: const EdgeInsets.symmetric(vertical: 1),
            width: 250,
            child: Container(
              padding: const EdgeInsets.only(top: 10),
              width: 150,
              child: TextFormField(
                controller: textController,
                style: const TextStyle(color: Colors.black, fontSize: 13),
                cursorColor: AppColors.cursorColorTextField,
                maxLength: disableMaxLen ? null : 10,
                inputFormatters: formater,
                decoration: InputDecoration(
                  helperText: helperText ?? null,
                  hintText: title,
                  hintStyle: TextStyle(
                    fontFamily: GlobalValues.fontFamily,
                  ),
                  suffixIcon: suffixIcon ?? const SizedBox(),
                  suffixIconConstraints: const BoxConstraints(
                      maxHeight: 70, minHeight: 40, minWidth: 10, maxWidth: 25),
                  isDense: true,
                  enabledBorder: defaultBorder(),
                  counter: const Offstage(),
                  focusColor: Colors.transparent,
                  border: defaultBorder(),
                  focusedBorder: defaultBorder(),
                  errorStyle: TextStyle(
                    color: AppColors.textAndIconColor,
                    fontSize: 9,
                    fontFamily: GlobalValues.fontFamily,
                  ),
                  errorBorder: errorBorder(),
                  focusedErrorBorder: defaultBorder(),
                ),
                validator: validator,
                onChanged: onChange,
              ),
            ),
          ),
        ],
      ),
    );
  }

  OutlineInputBorder defaultBorder() => OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.borderColorTextField,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(5),
      );
  OutlineInputBorder errorBorder() => OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.errorBorderTextField,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(5),
      );
}
