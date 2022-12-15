import 'dart:async';

import 'package:flutter/material.dart';
import 'package:swole_app/constants/assets.dart';
import 'package:swole_app/constants/colors.dart';
import 'package:swole_app/routes/routes_name.dart';
import 'package:swole_app/view/welcome_screen.dart';
class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    Timer(const Duration(seconds: 5),() {
      Navigator.pushNamed(context, RoutesName.welcomeScreen);
    },
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            Container(
              constraints: const BoxConstraints.expand(),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(AppAssets.splashBackgroundImage),
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.splashOverlayColor1,
                      AppColors.splashOverlayColor2,
                    ]),
              ),
            ),
            Center(child: Image.asset(AppAssets.splashLogo))
          ],
        ),
      ),
    );
  }
}