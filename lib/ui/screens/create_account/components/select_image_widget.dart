import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';

class SelectImageWidget extends StatelessWidget {
  final VoidCallback onTap;
  const SelectImageWidget({Key? key,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const CircleAvatar(
        backgroundColor: AppColors.textFieldColor,
        radius: 60,
        child: Icon(
          Icons.image_outlined,
          color: AppColors.whiteColor,
          size: 40,
        ),
      ),
    );
  }
}
