import 'package:flutter/material.dart';

import '../../../../constants/assets.dart';
import '../../../../constants/colors.dart';
import '../../../widgets/icon_widget.dart';

class VideoWidget extends StatelessWidget {
  const VideoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.height * 0.3,
      width: screenSize.width * 1,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          image: DecorationImage(image: AssetImage(AppAssets.dashboardHomeVideoProfile),
              fit: BoxFit.fill)
      ),
      child: Center(
        child: CircleAvatar(
          maxRadius: 35.0,
          backgroundColor: AppColors.playButtonColor,
          child: IconWidget(icon:Icons.play_arrow,color: AppColors.whiteColor,),
        ),
      ),
    );
  }
}
