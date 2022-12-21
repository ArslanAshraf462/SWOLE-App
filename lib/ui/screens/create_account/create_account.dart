import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swole_app/constants/app_strings.dart';
import 'package:swole_app/constants/assets.dart';
import 'package:swole_app/constants/colors.dart';
import 'package:swole_app/constants/dimens.dart';
import 'package:swole_app/ui/screens/create_account/components/checkbox_widget.dart';
import 'package:swole_app/ui/utils/app_dialogs/dialogs.dart';
import 'package:swole_app/ui/utils/ui_helper/ui_helper.dart';
import 'package:swole_app/ui/widgets/app_bar_widget.dart';
import 'package:swole_app/ui/widgets/background_image_widget.dart';
import 'package:swole_app/ui/widgets/button_widget.dart';
import 'package:swole_app/ui/widgets/text_form_field_widget.dart';
import 'package:swole_app/ui/widgets/text_widget.dart';

import '../../utils/validations/validation_utils.dart';
import '../../widgets/date_button_widget.dart';
import '../../widgets/icon_widget.dart';
import '../../widgets/password_text_form_field.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  late final TextEditingController dobController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  FocusNode nameFocusNode = FocusNode();
  FocusNode dobFocusNode=FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passFocusNode = FocusNode();
  bool check = false;
  DateTime? date;

  File? _image;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return BackgroundImageWidget(
      image: AppAssets.createAccountScreenBgImage,
      upperColor: AppColors.createAccountScreenOverlayColor1,
      lowerColor: AppColors.createAccountScreenOverlayColor2,
      appBar: const AppBarWidget(
        title: AppStrings.createAnAccountText,
      ),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              UIHelper.verticalSpace(Dimens.size100),
              GestureDetector(
                onTap: () => modelBottomSheet(context),
                child: _image == null
                    ? Container(
                        decoration: const BoxDecoration(
                          color: AppColors.textFieldColor,
                          shape: BoxShape.circle,
                        ),
                        height: screenSize.height * 0.17,
                        width: screenSize.width * 0.4,
                        child: const IconWidget(
                          icon: Icons.image_outlined,
                          color: AppColors.whiteColor,
                          size: Dimens.size40,
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: FileImage(File(_image!.path)),
                              fit: BoxFit.contain),
                          shape: BoxShape.circle,
                          // border: Border.all(color: MyColors.primary)
                        ),
                        height: screenSize.height * 0.17,
                        width: screenSize.width * 0.4,
                      ),
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      UIHelper.verticalSpace(Dimens.size81),
                      TextFormFieldWidget(
                        label: AppStrings.textFieldNameText,
                        textInputType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        validator: (value) => ValidationUtils.validateField(value),
                        controller: nameController,
                        focusNode: nameFocusNode,
                        onFieldSubmit: (value) => FocusScope.of(context).requestFocus(emailFocusNode),
                      ),
                      UIHelper.verticalSpace(Dimens.size5),
                      DateButtonWidget(title: getText()!, icon: Icons.calendar_today, onClicked: () =>pickDate(context),),
                      // TextFormFieldWidget(
                      //   label: AppStrings.textFieldDOBText,
                      //   suffixIcon: InkWell(
                      //     onTap: () => pickDate(context),
                      //     child: const Icon(
                      //       Icons.calendar_today,
                      //       color: AppColors.textTextFieldColor,
                      //       size: 16,
                      //     ),
                      //   ),
                      //   //textInputType: TextInputType.datetime,
                      //   validator: (value) {
                      //     return ValidationUtils.validateDateField(value);
                      //   },
                      //   controller: dobController,
                      // ),
                      UIHelper.verticalSpace(Dimens.size5),
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
                        validator: (value) => ValidationUtils.validatePassword(value),
                        controller: passwordController,
                        focusNode: passFocusNode,
                      ),
                      UIHelper.verticalSpace(Dimens.size20),
                      Padding(
                        padding: EdgeInsets.only(left: screenSize.width * 0.04),
                        child: Row(
                          children: [
                            CheckBoxWidget(
                              checked: (checked) {
                                check = checked;
                              },
                            ),
                            RichText(
                              text: const TextSpan(children: [
                                TextSpan(
                                    text: AppStrings.acceptText,
                                    style: TextStyle(
                                      color: AppColors.textTextFieldColor,
                                    )),
                                TextSpan(
                                    text: AppStrings.privacyText,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.checkboxTextColor,
                                    )),
                                TextSpan(
                                  text: AppStrings.andText,
                                  style: TextStyle(
                                    color: AppColors.textTextFieldColor,
                                  ),
                                ),
                                TextSpan(
                                    text: AppStrings.termsText,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.checkboxTextColor,
                                    )),
                              ]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
              UIHelper.verticalSpace(Dimens.size44),
              ButtonWidget(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (check != true) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: TextWidget(title: AppStrings.privacyValidateText),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    }
                  }
                },
                insertIcon: false,
                leftWidth: screenSize.width * 0.3,
                color: AppColors.appBlueColor,
                title: AppStrings.createAccountText,
                fontWeight: FontWeight.w400,
                titleColor: AppColors.whiteColor,
              ),
              UIHelper.verticalSpace(Dimens.size55),
            ],
          ),
        ),
      ),
    );
  }
  modelBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: AppColors.textFieldColor,
          height: 160,
          width: double.infinity,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: TextWidget(
                  title: AppStrings.selectText,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.whiteColor,
                ),
              ),
              UIHelper.verticalSpace(Dimens.size10),
              TextButton(
                  onPressed: () {
                    _pickImg(ImageSource.camera);
                  },
                  child: const TextWidget(
                    title: AppStrings.cameraText,
                    color: AppColors.appBlueColor,
                    fontSize: 14,
                  )),
              UIHelper.verticalSpace(Dimens.size2),
              TextButton(onPressed: (){
                _pickImg(ImageSource.gallery);
              }, child: const TextWidget(title: AppStrings.galleryText,
                color: AppColors.appBlueColor,
                fontSize: 14,))
            ],
          ),
        );
      },);
  }

  void _pickImg(ImageSource source)async{
    final imgPicker= await _picker.pickImage(source: source);
    if (imgPicker != null) {
      _image = File(imgPicker.path);
      setState(() {});
    } else {
      AppDialogs.showAuthDialog(
        context: context,
        title: AppStrings.noImagePickedText,
        body: AppStrings.galleryCheckText,
        okBtnTitle: AppStrings.okText,
        okBtnPressed: () => Navigator.pop(context),
      );
    }
  }

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        initialDate: date ?? initialDate,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5));
    if (newDate == null) return;
    setState(() {
      date = newDate;
    });
    if (newDate != null) {
      date = newDate;
      dobController
        ..text = DateFormat.yMMMd().format(date!)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: dobController.text.length,
            affinity: TextAffinity.upstream));
    }
  }

  String? getText() {
    if (date == null) {
      return AppStrings.textFieldDOBText;
    } else {
      return DateFormat('MM/dd/yyyy').format(date!);
    }
  }
}
