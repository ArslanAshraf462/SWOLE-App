import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';
import 'package:swole_app/constants/colors.dart';
import '../../../constants/app_strings.dart';
import '../../screens/create_account/components/image_pick_option_widget.dart';
import '../app_dialogs/dialogs.dart';
import '../constants.dart';
class UtilsGeneral extends State{
  var imgPicker;
 void imagePickModelBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ImagePickOptionWidget(
          onCameraTap: () => pickImg(ImageSource.camera),
          onGalleryTap: () => pickImg(ImageSource.gallery),
        );
      },);
  }

 showBottomSheetResetPassword({required BuildContext context,required Widget child}) {
   //final TextEditingController mailController=TextEditingController();
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
         return child;
       });
 }

   void pickImg(ImageSource source)async{
   imgPicker= await AppConstants.picker.pickImage(source: source);
   if (imgPicker != null) {
     _cropImage();
     AppConstants.image = File(imgPicker.path);
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
  Future _cropImage() async{
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imgPicker!.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: AppStrings.cropperText,
            toolbarColor: AppColors.appBlueColor,
            toolbarWidgetColor: AppColors.textFieldColor,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: AppStrings.cropperText,
        ),
      ],
    );
    if (croppedFile != null) {
      imgPicker = croppedFile as XFile?;
      setState(() {
      });
    }
  }

 Future pickDate(BuildContext context) async {
   final initialDate = DateTime.now();
   final newDate = await showDatePicker(
       context: context,
       initialDate: AppConstants.date ?? initialDate,
       firstDate: DateTime(DateTime.now().year - 5),
       lastDate: initialDate,);
   if (newDate == null) return;
   setState(() {
     AppConstants.date = newDate;
   });
    // if (newDate != null) {
    //   AppConstants.date = newDate;
    //   AppConstants.dobController
    //     ..text = DateFormat.yMMMd().format(AppConstants.date!)
    //     ..selection = TextSelection.fromPosition(TextPosition(
    //    offset: AppConstants.dobController.text.length,
    //      affinity: TextAffinity.upstream));
    // }
 }

 String? getText() {
   if (AppConstants.date == null) {
     return AppStrings.textFieldDOBText;
   } else {
     return DateFormat(AppStrings.dateFormatText).format(AppConstants.date!);
   }
 }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

