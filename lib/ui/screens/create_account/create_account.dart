import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swole_app/constants/app_strings.dart';
import 'package:swole_app/constants/assets.dart';
import 'package:swole_app/constants/colors.dart';
import 'package:swole_app/ui/screens/create_account/components/checkbox_widget.dart';
import 'package:swole_app/ui/screens/create_account/components/select_image_widget.dart';
import 'package:swole_app/ui/utils/ui_helper/ui_helper.dart';
import 'package:swole_app/ui/widgets/app_bar_widget.dart';
import 'package:swole_app/ui/widgets/background_image_widget.dart';
import 'package:swole_app/ui/widgets/button_widget.dart';
import 'package:swole_app/ui/widgets/text_form_field_widget.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool check = false;

  // File? _image;
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
      child: SingleChildScrollView(
        child: Column(
          children: [
            UIHelper.verticalSpace(100),
            SelectImageWidget(
              onTap: () {
                // showModalBottomSheet(context: context, builder: modelBottemsheet);
              },
            ),
            UIHelper.verticalSpace(81),
            TextFormFieldWidget(
                label: AppStrings.textFieldNameText,
                textInputType: TextInputType.name,
                validator: (p0) {},
                controller: nameController,),
            UIHelper.verticalSpace(15),
            TextFormFieldWidget(
              label: AppStrings.textFieldDOBText,
              suffixIcon: const Icon(
                Icons.calendar_today,
                color: AppColors.textTextFieldColor,
                size: 16,
              ),
              textInputType: TextInputType.datetime,
              validator: (p0) {},
              controller: dobController,
            ),

            UIHelper.verticalSpace(15),
            TextFormFieldWidget(
              label: AppStrings.textFieldEmailText,
              textInputType: TextInputType.emailAddress,
              validator: (p0) {},
              controller: emailController,
            ),
            UIHelper.verticalSpace(15),
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
            UIHelper.verticalSpace(20),
            Padding(
              padding: EdgeInsets.only(left: screenSize.width*0.04),
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
                         style: TextStyle(color: AppColors.textTextFieldColor,)
                        ),
                      TextSpan(
                          text: AppStrings.privacyText,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.checkboxTextColor,
                          )),
                      TextSpan(
                          text: AppStrings.andText,
                          style: TextStyle(color: AppColors.textTextFieldColor,),
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
            UIHelper.verticalSpace(44),
            ButtonWidget(
                onPressed: () {},
                insertIcon: false,
                leftWidth: screenSize.width * 0.3,
                color: AppColors.appBlueColor,
                title: AppStrings.createAccountText,
                fontWeight: FontWeight.w400,
                titleColor: AppColors.whiteColor,
            ),
            UIHelper.verticalSpace(55),
          ],
        ),
      ),
    );
  }
// Widget modelBottemsheet(BuildContext context) {
//   return SizedBox(
//     height: 160,
//     width: double.infinity,
//     // child:
//     //Padding(
//     // padding: const EdgeInsets.all(8.0),
//     child: Column(crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(
//             'Select option',
//           ),
//         ),
//         const SizedBox(
//           height: 10,
//         ),
//         TextButton(
//             onPressed: () {
//               _pickImg(ImageSource.camera);
//             },
//             child: Text(
//               'Camera',
//             )),
//         const SizedBox(height: 2,),
//         TextButton(onPressed: (){
//           _pickImg(ImageSource.gallery);
//         }, child: Text('Gallery',))
//       ],
//     ),
//   );
//   // );
// }

// void _pickImg(ImageSource source)async{
//   final _imgGetter= await _picker.pickImage(source: source);
//   if(_imgGetter==null) return;
//   setState(() {
//     _image=File(_imgGetter.path);
//   });
// }
}
