import 'package:flutter/material.dart';

import '../../../../../constants/app_strings.dart';
import '../../../../../constants/assets.dart';
import '../../../../../constants/colors.dart';
import '../../../../../constants/dimens.dart';
import '../../../../utils/ui_helper/ui_helper.dart';
import '../../../../widgets/icon_widget.dart';
import '../../../../widgets/text_widget.dart';
import '../dashboard_app_bar_widget.dart';
import '../video_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DashboardAppBarWidget(
              appbarTitle: AppStrings.dashboardAppBarTitleText,
              appbarImage: AppAssets.dashboardProfile,
            ),
            // UIHelper.verticalSpace(5),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: const TextWidget(title: AppStrings.workoutDayText,fontSize: 18,fontWeight: FontWeight.w600,color: AppColors.whiteColor,),
            ),
            UIHelper.verticalSpace(Dimens.size20),
        Padding(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child: VideoWidget(),
        ),
            UIHelper.verticalSpace(Dimens.size15),
            Row(
              children: [
                TextWidget(title: 'Bicep Shredder',color: AppColors.whiteColor,fontSize: 16,fontWeight: FontWeight.w400,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
