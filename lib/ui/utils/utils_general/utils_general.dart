import 'dart:io';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:swole_app/constants/colors.dart';
import 'package:swole_app/ui/screens/create_account/create_account.dart';
import '../../../constants/app_strings.dart';
import '../../screens/create_account/components/image_pick_option_widget.dart';
import '../app_dialogs/dialogs.dart';
import '../constants.dart';
class UtilsGeneral {



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







  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

