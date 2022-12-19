import 'package:flutter/material.dart';
import 'package:swole_app/constants/app_strings.dart';
import 'package:swole_app/constants/dimens.dart';
import 'package:swole_app/ui/utils/ui_helper/ui_helper.dart';

import '../../../constants/colors.dart';
import '../../../routes/routes_name.dart';
import '../../utils/app_dialogs/dialogs.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/password_text_form_field.dart';
import '../../widgets/text_form_field_widget.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.resetPasswordText),
        backgroundColor: AppColors.resetBackgroundColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          TextButton(onPressed: () {}, child: const Text(AppStrings.cancelText,style: TextStyle(color: AppColors.textTextFieldColor),))
        ],
      ),
      backgroundColor: AppColors.resetBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            UIHelper.verticalSpace(Dimens.size39),
            PasswordTextFormFieldWidget(
              label: AppStrings.textFieldPasswordText,
              textInputType: TextInputType.text,
              validator: (p0) {},
              controller: passwordController,
            ),
            UIHelper.verticalSpace(Dimens.size10),
            PasswordTextFormFieldWidget(
              label: AppStrings.textFieldPasswordText,
              textInputType: TextInputType.text,
              validator: (p0) {},
              controller: confPasswordController,
            ),
            UIHelper.verticalSpace(Dimens.size483),
            ButtonWidget(
                onPressed: () {
                  //Navigator.pop(context);
                  Navigator.pushNamed(context, RoutesName.login);
                  AppDialogs.showAuthDialog(
                    context: context,
                    title: AppStrings.passwordSetTitleText,
                    body: AppStrings.passwordSetBodyText,
                    okBtnTitle: AppStrings.okText,
                    okBtnPressed:() => Navigator.pop(context),
                  );
                },
                insertIcon: false,
                leftWidth: screenSize.width * 0.3,
                color: AppColors.appBlueColor,
                title: AppStrings.saveNewPassText,
                fontWeight: FontWeight.w400,
                titleColor: AppColors.whiteColor,
              ),
            UIHelper.verticalSpace(Dimens.size41),
          ],
        ),
      ),
    );
  }
}