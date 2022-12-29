import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swole_app/constants/app_strings.dart';
import 'package:swole_app/constants/colors.dart';
import 'package:swole_app/constants/dimens.dart';
import 'package:swole_app/ui/utils/ui_helper/ui_helper.dart';
import 'package:swole_app/ui/widgets/app_bar_widget.dart';
import 'package:swole_app/ui/widgets/text_widget.dart';

import '../../../view_model/auth_view_model.dart';

class CurrentUserScreen extends StatelessWidget {
  const CurrentUserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context).user;
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: const AppBarWidget(title: AppStrings.currentUserTitleText),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(title: "Email: ${authViewModel?.data?.email}",color: AppColors.whiteColor,),
            UIHelper.verticalSpace(Dimens.size10),
            TextWidget(title: "Password: ${authViewModel?.data?.password}",color: AppColors.whiteColor,),
            UIHelper.verticalSpace(Dimens.size10),
            TextWidget(title: "Status: ${authViewModel?.data?.status}",color: AppColors.whiteColor,),
            UIHelper.verticalSpace(Dimens.size10),
            TextWidget(title: "Last-Access: ${authViewModel?.data?.lastAccess}",color: AppColors.whiteColor,),
          ],
        ),
      ),
    );
  }
}
