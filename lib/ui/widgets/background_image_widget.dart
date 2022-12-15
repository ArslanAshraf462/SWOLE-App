import 'package:flutter/material.dart';

class BackgroundImageWidget extends StatelessWidget {
  final String image;
  final Color upperColor;
  final Color lowerColor;
  final Widget child;

  const BackgroundImageWidget(
      {Key? key,
      required this.image,
      required this.upperColor,
      required this.lowerColor,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(image),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                upperColor,
                lowerColor,
              ]),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: child,
        ),
      ),
    );
  }
}
