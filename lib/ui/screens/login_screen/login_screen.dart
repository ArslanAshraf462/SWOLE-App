import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swole_app/routes/routes_name.dart';
import 'package:swole_app/ui/widgets/app_bar_widget.dart';
import 'package:swole_app/ui/widgets/background_image_widget.dart';
import '../../../constants/app_strings.dart';
import '../../../constants/assets.dart';
import '../../../constants/colors.dart';
import '../../../constants/dimens.dart';
import '../../../view_model/auth_view_model.dart';
import '../../utils/app_dialogs/dialogs.dart';
import '../../utils/ui_helper/ui_helper.dart';
import '../../utils/validations/validation_utils.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/password_text_form_field.dart';
import '../../widgets/text_form_field_widget.dart';
import '../../widgets/text_widget.dart';
import 'components/forget_password_email_widget.dart';

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
    final authViewModel = Provider.of<AuthViewModel>(context);
    final screenSize = MediaQuery
        .of(context)
        .size;
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: BackgroundImageWidget(
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
                    top: screenSize.height * 0.2,
                    left: screenSize.width * 0.3,
                    right: screenSize.width * 0.29,
                  ),
                  child: Image.asset(AppAssets.blueLogo),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                  children: [
                    UIHelper.verticalSpace(Dimens.size150),
                    TextFormFieldWidget(
                      label: AppStrings.textFieldEmailText,
                      textInputType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: (value) => ValidationUtils.validateEmail(value),
                      controller: emailController,
                      focusNode: emailFocusNode,
                      onFieldSubmit: (value) => FocusScope.of(context).requestFocus(passFocusNode),
                    ),
                    UIHelper.verticalSpace(Dimens.size15),
                    PasswordTextFormFieldWidget(
                      label: AppStrings.textFieldPasswordText,
                      textInputType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        return ValidationUtils.validatePassword(value);
                      },
                      controller: passwordController,
                      focusNode: passFocusNode,
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
                        authViewModel.loginApi(
                            email: emailController.text.toString(),
                            password: passwordController.text.toString(),
                            context: context);
                        if (kDebugMode) {
                          print(emailController.text);
                        }
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
          return ForgetPasswordEmailWidget(
            emailTextField: TextFormFieldWidget(
              label: AppStrings.yourEmailAddressText,
              textInputType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              validator: (value)=>ValidationUtils.validateEmail(value),
              controller: mailController,
            ),
            onSubmitTap: () {
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
            },
          );
        },
    );
  }
}
