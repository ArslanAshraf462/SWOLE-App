import 'package:flutter/material.dart';
import 'package:swole_app/constants/colors.dart';

import '../../constants/assets.dart';
import '../widgets/background_image_widget.dart';
import '../widgets/button_widget.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return BackgroundImageWidget(
        image: AppAssets.welcomeScreenBackgroundImage,
        upperColor: AppColors.welcomeScreenOverlayColor1,
        lowerColor: AppColors.welcomeScreenOverlayColor2,
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(
              top: screenSize.height * 0.3,
              left: screenSize.width * 0.29,
              right: screenSize.width * 0.29,
            ),
            child: Image.asset(AppAssets.blueLogo),
            ),
          ],
        ),
    );
  }
}
