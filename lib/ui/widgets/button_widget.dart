import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final Color color;
  final Color titleColor;
  final String icon;
  final String title;
  const ButtonWidget({Key? key,required this.color,required this.title,this.icon = '',required this.titleColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: color,
        ),
        height: 50,
        width: 300,
        child: Row(
          children: [
            SizedBox(width: 19,),
            Image.asset(icon),
            SizedBox(width: 71,),
            Center(
              child: Text(
                title,
                style: TextStyle(
                  color: titleColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
