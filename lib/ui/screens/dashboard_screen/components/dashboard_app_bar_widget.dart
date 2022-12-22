import 'package:flutter/material.dart';
import '../../../../constants/colors.dart';
import '../../../widgets/text_widget.dart';

class DashboardAppBarWidget extends StatelessWidget {
  final String appbarTitle;
  final String appbarImage;
  const DashboardAppBarWidget({Key? key,required this.appbarTitle,required this.appbarImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(left: screenSize.width * 0.04,bottom: 8),
          child:  TextWidget(
            title: appbarTitle,
            color: AppColors.whiteColor,
            fontSize: 24,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w600,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 15),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(appbarImage),
                fit: BoxFit.fill),
            shape: BoxShape.circle,
          ),
          height: screenSize.height * 0.12,
          width: screenSize.width * 0.2,
        ),
      ],
    );
  }
}
