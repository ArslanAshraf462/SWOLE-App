import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String label;
  final String? hintText;
  final String? initialValue;
  final Widget? suffixIcon;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final bool obscureText;
  final Function(String)? onChanged;

  TextFormFieldWidget({
    required this.label,
    this.hintText,
    this.initialValue,
    this.suffixIcon,
    this.obscureText=false,
    this.onChanged,
    this.textInputType=TextInputType.text,
    required this.validator,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Center(
      child: Container(
        //padding: const EdgeInsets.only(left: 51.0, right: 51.0),
        width: screenSize.width * 0.85,
        height: screenSize.height * 0.065,

        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: AppColors.textFieldColor),
        child: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: TextFormField(
            onChanged: onChanged,
            controller: controller,
            validator: validator,
            decoration: InputDecoration(
              label: Text(label),
              hintText: hintText,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.textTextFieldColor,
                fontSize: 14,
              ),
              suffixIcon: suffixIcon,
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
            style: const TextStyle(
              color: AppColors.textFieldInputColor,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            textInputAction: TextInputAction.next,
            keyboardType: textInputType,
            obscureText: obscureText,
          ),
        ),
      ),
    );
  }
}
