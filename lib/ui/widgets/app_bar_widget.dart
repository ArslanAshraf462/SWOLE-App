import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget with PreferredSizeWidget {
  final Widget title;
  final bool centerTitle;
  final List<Widget>? actions;

  const AppBarWidget(
      {Key? key,
      required this.title,
      required this.centerTitle,
      this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      centerTitle: centerTitle,
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      actions: actions,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
