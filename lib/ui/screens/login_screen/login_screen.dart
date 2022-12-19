import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swole_app/routes/routes_name.dart';
import 'package:swole_app/ui/screens/reset_password/reset_password.dart';
import 'package:swole_app/ui/widgets/app_bar_widget.dart';
import 'package:swole_app/ui/widgets/background_image_widget.dart';

import '../../../constants/app_strings.dart';
import '../../../constants/assets.dart';
import '../../../constants/colors.dart';
import '../../../constants/dimens.dart';
import '../../utils/app_dialogs/dialogs.dart';
import '../../utils/ui_helper/ui_helper.dart';
import '../../utils/validations/validation_utils.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/password_text_form_field.dart';
import '../../widgets/text_form_field_widget.dart';
import '../../widgets/text_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery
        .of(context)
        .size;
    return BackgroundImageWidget(
      image: AppAssets.loginBackground,
      upperColor: AppColors.loginScreenOverlayColor1,
      lowerColor: AppColors.loginScreenOverlayColor2,
      appBar: const AppBarWidget(
        title: AppStrings.loginAppBarText,),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
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
              Form(
                key: _formKey,
                child: Column(
                children: [
                  UIHelper.verticalSpace(Dimens.size200),
                  TextFormFieldWidget(
                    label: AppStrings.textFieldEmailText,
                    textInputType: TextInputType.emailAddress,
                    validator: (value) {
                      return ValidationUtils.validateEmail(value);
                    },
                    controller: emailController,
                  ),
                  UIHelper.verticalSpace(Dimens.size15),
                  PasswordTextFormFieldWidget(
                    label: AppStrings.textFieldPasswordText,
                    textInputType: TextInputType.text,
                    validator: (value) {
                      return ValidationUtils.validatePassword(value);
                    },
                    controller: passwordController,
                  ),
                ],
              ),),
              UIHelper.verticalSpace(Dimens.size20),
              GestureDetector(
                onTap: () => _showBottomSheetResetPassword(context),
                child: Padding(
                  padding: EdgeInsets.only(left: screenSize.width * 0.08),
                  child: const TextWidget(
                    title:AppStrings.forgotPasswordText,
                    textAlign: TextAlign.start,
                    color: AppColors.appBlueColor,
                  ),
                ),
              ),
              UIHelper.verticalSpace(Dimens.size46),
              Padding(
                padding: EdgeInsets.only(left: screenSize.width * 0.056),
                child: ButtonWidget(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      print(emailController.text);
                    }
                  },
                  insertIcon: false,
                  leftWidth: screenSize.width * 0.38,
                  color: AppColors.appBlueColor,
                  title: AppStrings.loginText,
                  fontWeight: FontWeight.w400,
                  titleColor: AppColors.whiteColor,
                ),
              ),
              UIHelper.verticalSpace(Dimens.size54),
            ],
          ),
        ),
      ),
    );
  }

  _showBottomSheetResetPassword(BuildContext context) {
    final TextEditingController mailController=TextEditingController();
    return showModalBottomSheet(
      //isDismissible: false,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        context: context,
        builder: (builder) {
          return Container(
            height: MediaQuery
                .of(context)
                .size
                .height * 0.8,
            //height: 670.0,
            color: Colors.transparent,
            child: Container(
              decoration: const BoxDecoration(
                  color: AppColors.resetBackgroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0))),
              child: GestureDetector(
                onTap: () {},
                behavior: HitTestBehavior.opaque,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    UIHelper.verticalSpace(Dimens.size10),
                    Center(
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                          height: 6,
                          width: 60,
                          decoration: const BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius:
                              BorderRadius.all(Radius.circular(20))),
                        ),
                      ),
                    ),
                    UIHelper.verticalSpace(Dimens.size20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        UIHelper.horizontalSpace(
                            MediaQuery
                                .of(context)
                                .size
                                .width * 0.27),
                        const TextWidget(
                          title: AppStrings.forgotPasswordTitleText,
                          fontSize: Dimens.size18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.whiteColor,
                        ),
                        UIHelper.horizontalSpace(
                            MediaQuery
                                .of(context)
                                .size
                                .width * 0.14),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                              AppDialogs.showAuthDialog(
                                context: context,
                                  title: AppStrings.checkEmailText,
                                  body: AppStrings.checkEmailBodyText,
                                  okBtnTitle: AppStrings.okText,
                                  okBtnPressed:() {
                                    Navigator.pop(context);
                                  Navigator.pushNamed(context, RoutesName.resetPasswordScreen);

                                  },
                              );
                           // Navigator.pop(context);
                              },
                          child: const TextWidget(
                            title: AppStrings.submitText,
                            fontSize: Dimens.size16,
                            color: AppColors.appBlueColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    UIHelper.verticalSpace(Dimens.size30),
                    TextFormFieldWidget(
                      label: AppStrings.yourEmailAddressText,
                      textInputType: TextInputType.emailAddress,
                      validator: (value) {
                        return ValidationUtils.validateEmail(value);
                      },
                      controller: mailController,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
