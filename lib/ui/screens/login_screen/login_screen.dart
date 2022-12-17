import 'package:flutter/material.dart';
import 'package:swole_app/ui/screens/reset_password/reset_password.dart';
import 'package:swole_app/ui/widgets/background_image_widget.dart';

import '../../../constants/app_strings.dart';
import '../../../constants/assets.dart';
import '../../../constants/colors.dart';
import '../../../constants/dimens.dart';
import '../../utils/ui_helper/ui_helper.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/text_form_field_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return BackgroundImageWidget(
      image: AppAssets.loginBackground,
      upperColor: AppColors.loginScreenOverlayColor1,
      lowerColor: AppColors.loginScreenOverlayColor2,
      appBar: AppBar(
        title: const Text(AppStrings.loginAppBarText),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: screenSize.height * 0.3,
                left: screenSize.width * 0.29,
                right: screenSize.width * 0.29,
              ),
              child: Image.asset(AppAssets.blueLogo),
            ),
            UIHelper.verticalSpace(Dimens.size200),
            TextFormFieldWidget(
              label: AppStrings.textFieldEmailText,
              textInputType: TextInputType.emailAddress,
              validator: (p0) {},
              controller: emailController,
            ),
            UIHelper.verticalSpace(Dimens.size15),
            TextFormFieldWidget(
              label: AppStrings.textFieldPasswordText,
              suffixIcon: const Icon(
                Icons.remove_red_eye_outlined,
                color: AppColors.textTextFieldColor,
                size: 16,
              ),
              textInputType: TextInputType.text,
              validator: (p0) {},
              controller: passwordController,
            ),
            UIHelper.verticalSpace(Dimens.size20),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ResetPassword(),));
              },
              child: Padding(
                padding: EdgeInsets.only(left: screenSize.width*0.08),
                child: const Text(AppStrings.forgotPasswordText,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                  color: AppColors.appBlueColor,
                ),),
              ),
            ),
            UIHelper.verticalSpace(Dimens.size46),
            Padding(
              padding: EdgeInsets.only(left: screenSize.width*0.056),
              child: ButtonWidget(
                onPressed: () {},
                insertIcon: false,
                leftWidth: screenSize.width * 0.3,
                color: AppColors.appBlueColor,
                title: AppStrings.createAccountText,
                fontWeight: FontWeight.w400,
                titleColor: AppColors.whiteColor,
              ),
            ),
            UIHelper.verticalSpace(Dimens.size54),
          ],
        ),
      ),
    );
  }
}
