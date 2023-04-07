import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phonebook/common/const/colors.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    super.key,
    this.hintText,
    this.errorText,
    this.obscureText = false,
    this.autoFocus = false,
    this.fontSize = 14,
    this.prefixIcon,
    this.validator,
    required this.onChanged,
    this.inputFormatters,
    this.controller,
  });
  final double fontSize;
  final String? hintText;
  final String? errorText;
  final Widget? prefixIcon;
  final bool obscureText;
  final bool autoFocus;
  final ValueChanged<String>? onChanged;
  String? Function(String?)? validator;
  List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    final baseBorder = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: INPUT_BORDER_COLOR, width: 1.0));

    return TextFormField(
      controller: controller,
      inputFormatters: inputFormatters,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      cursorColor: PRIMARY_COLOR,
      onChanged: onChanged,
      obscureText: obscureText,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(20),
          hintText: hintText,
          errorText: errorText,
          hintStyle: TextStyle(color: BODY_TEXT_COLOR, fontSize: fontSize),
          fillColor: INPUT_BG_COLOR,
          filled: true,
          prefixIcon: prefixIcon,
          // 모든 Input 상태의 기본 스타일 세팅
          border: baseBorder,
          enabledBorder: baseBorder,
          focusedBorder: baseBorder.copyWith(
              borderSide:
                  baseBorder.borderSide.copyWith(color: PRIMARY_COLOR))),
    );
  }
}
