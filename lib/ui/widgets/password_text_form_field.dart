import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';

class PasswordTextFormFieldWidget extends StatefulWidget {
  final String label;
  //final Widget? suffixIcon;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  final TextEditingController controller;
 // final bool obscureText;

  PasswordTextFormFieldWidget({
    required this.label,
    // this.suffixIcon,
    // this.obscureText=false,
    required this.textInputType,
    required this.validator,
    required this.controller,
  });

  @override
  State<PasswordTextFormFieldWidget> createState() => _PasswordTextFormFieldWidgetState();
}

class _PasswordTextFormFieldWidgetState extends State<PasswordTextFormFieldWidget> {
  final ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);

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
            controller: widget.controller,
            validator: widget.validator,
            decoration: InputDecoration(
              label: Text(widget.label),
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.textTextFieldColor,
                fontSize: 14,
              ),
              suffixIcon: InkWell(
                onTap: () {
                  setState(() {
                    _obsecurePassword.value= !_obsecurePassword.value;
                  });
                },
                child: Icon(
                  _obsecurePassword.value
                      ? Icons.visibility_off_outlined
                      : Icons.visibility,
                  color: AppColors.textTextFieldColor,
                  size: 16,
                ),
              ),
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
            keyboardType: widget.textInputType,
            obscureText: _obsecurePassword.value,
          ),
        ),
      ),
    );
  }
}