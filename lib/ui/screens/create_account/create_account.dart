import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swole_app/constants/app_strings.dart';
import 'package:swole_app/constants/assets.dart';
import 'package:swole_app/constants/colors.dart';
import 'package:swole_app/constants/dimens.dart';
import 'package:swole_app/ui/screens/create_account/components/checkbox_widget.dart';
import 'package:swole_app/ui/screens/create_account/components/select_image_widget.dart';
import 'package:swole_app/ui/utils/app_dialogs/dialogs.dart';
import 'package:swole_app/ui/utils/ui_helper/ui_helper.dart';
import 'package:swole_app/ui/widgets/app_bar_widget.dart';
import 'package:swole_app/ui/widgets/background_image_widget.dart';
import 'package:swole_app/ui/widgets/button_widget.dart';
import 'package:swole_app/ui/widgets/text_form_field_widget.dart';

import '../../widgets/password_text_form_field.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final TextEditingController nameController = TextEditingController();
  late final TextEditingController dobController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool check = false;
  DateTime? date;

  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future getImageGallery() async {
    final pickFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickFile != null) {
      _image = File(pickFile.path);
      setState(() {});
    } else {
      AppDialogs.showAuthDialog(
        context: context,
        title: 'No Image Picked',
        body: 'Please pick the profile image',
        okBtnTitle: 'OK',
        okBtnPressed: () =>Navigator.pop(context),
      );
    }
  }

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
      child: SingleChildScrollView(
        child: Column(
          children: [
            UIHelper.verticalSpace(Dimens.size100),
            GestureDetector(
              onTap: () => getImageGallery(),
              child: _image == null
                  ?  Container(
                decoration: const BoxDecoration(
                  color: AppColors.textFieldColor,
                  shape: BoxShape.circle,
                ),
                height: screenSize.height*0.17,
                width: screenSize.width *0.4,
                child: const Icon(
                  Icons.image_outlined,
                  color: AppColors.whiteColor,
                  size: Dimens.size40,
                ),
              )
                  : Container(
                decoration: BoxDecoration(
                    image: DecorationImage(image: FileImage(File(_image!.path)), fit: BoxFit.contain),
                    shape: BoxShape.circle,
                   // border: Border.all(color: MyColors.primary)
                  ),
                height: screenSize.height*0.17,
                width: screenSize.width *0.4,
              ),
            ),
            UIHelper.verticalSpace(Dimens.size81),
            TextFormFieldWidget(
              label: AppStrings.textFieldNameText,
              textInputType: TextInputType.name,
              validator: (p0) {},
              controller: nameController,
            ),
            UIHelper.verticalSpace(Dimens.size15),
            TextFormFieldWidget(
              label: AppStrings.textFieldDOBText,
              suffixIcon: InkWell(
                onTap: () => pickDate(context),
                child: const Icon(
                  Icons.calendar_today,
                  color: AppColors.textTextFieldColor,
                  size: 16,
                ),
              ),
              //textInputType: TextInputType.datetime,
              validator: (p0) {},
              controller: dobController,
            ),
            UIHelper.verticalSpace(Dimens.size15),
            TextFormFieldWidget(
              label: AppStrings.textFieldEmailText,
              textInputType: TextInputType.emailAddress,
              validator: (p0) {},
              controller: emailController,
            ),
            UIHelper.verticalSpace(Dimens.size15),
            PasswordTextFormFieldWidget(
              label: AppStrings.textFieldPasswordText,
              textInputType: TextInputType.text,
              validator: (p0) {},
              controller: passwordController,
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
            UIHelper.verticalSpace(Dimens.size44),
            ButtonWidget(
              onPressed: () {},
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
    );
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
