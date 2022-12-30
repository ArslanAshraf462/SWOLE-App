import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swole_app/constants/app_strings.dart';
import 'package:swole_app/constants/colors.dart';
import 'package:swole_app/constants/dimens.dart';
import 'package:swole_app/ui/utils/ui_helper/ui_helper.dart';
import 'package:swole_app/ui/widgets/app_bar_widget.dart';
import 'package:swole_app/ui/widgets/text_widget.dart';

import '../../../routes/routes_name.dart';
import '../../../view_model/auth_view_model.dart';
import '../../utils/app_dialogs/dialogs.dart';

class CurrentUserScreen extends StatefulWidget {
  const CurrentUserScreen({Key? key}) : super(key: key);

  @override
  State<CurrentUserScreen> createState() => _CurrentUserScreenState();
}

class _CurrentUserScreenState extends State<CurrentUserScreen> {
  @override
  void didUpdateWidget(covariant CurrentUserScreen oldWidget) {
    // TODO: implement didUpdateWidget
    Provider.of<AuthViewModel>(context).currentUser(context);
    super.didUpdateWidget(oldWidget);
  }
  @override
  Widget build(BuildContext context) {
   // Provider.of<AuthViewModel>(context).sessionProvider(context);
    //Provider.of<AuthViewModel>(context).currentUser(context);
    final authViewModel = Provider.of<AuthViewModel>(context).users;
    // if(authViewModel?.data==null){
    //   AppDialogs.showAuthDialog(
    //     context: context,
    //     title: AppStrings.currentUserSessionText,
    //     body: AppStrings.currentUserSessionBodyText,
    //     okBtnTitle: AppStrings.okText,
    //     okBtnPressed: () => Navigator.of(context).pushReplacementNamed(RoutesName.login),);
    // }
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: const AppBarWidget(title: AppStrings.currentUserTitleText),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(title: "${AppStrings.currentUserEmailText} : ${authViewModel?.data?.email}",color: AppColors.whiteColor,),
            UIHelper.verticalSpace(Dimens.size10),
            TextWidget(title: "${AppStrings.currentUserPasswordText} : ${authViewModel?.data?.password}",color: AppColors.whiteColor,),
            UIHelper.verticalSpace(Dimens.size10),
            TextWidget(title: "${AppStrings.currentUserStatusText} : ${authViewModel?.data?.status}",color: AppColors.whiteColor,),
            UIHelper.verticalSpace(Dimens.size10),
            TextWidget(title: "${AppStrings.currentUserAccessText} : ${authViewModel?.data?.lastAccess}",color: AppColors.whiteColor,),
          ],
        ),
      ),
    );
  }
}
