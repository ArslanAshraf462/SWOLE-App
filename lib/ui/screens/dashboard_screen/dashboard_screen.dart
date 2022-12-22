import 'package:flutter/material.dart';
import 'package:swole_app/constants/colors.dart';
import 'package:swole_app/ui/screens/dashboard_screen/components/progress/progress.dart';
import 'package:swole_app/ui/screens/dashboard_screen/components/workout/workout_screen.dart';
import 'package:swole_app/ui/utils/ui_helper/ui_helper.dart';
import 'package:swole_app/ui/widgets/text_widget.dart';
import '../../../constants/app_strings.dart';
import '../../../constants/dimens.dart';
import '../../widgets/icon_widget.dart';
import 'components/home/home_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  List<Widget> screens = <Widget>[
    const HomeScreen(),
    WorkoutScreen(),
    ProgressScreen(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: screens.elementAt(_selectedIndex),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        child: Container(
          height: 92,
          child: BottomNavigationBar(
            backgroundColor: AppColors.textFieldColor,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: [
              _bottomNavBarItem(
                  title: AppStrings.homeText,
                  iconAsset: Icons.home_outlined,
                  activeIconAsset: Icons.home),
              _bottomNavBarItem(
                  title: AppStrings.workoutText,
                  iconAsset: Icons.workspaces_outline,
                  activeIconAsset: Icons.workspaces_outline),
              _bottomNavBarItem(
                  title: AppStrings.progressText,
                  iconAsset: Icons.auto_graph,
                  activeIconAsset: Icons.auto_graph),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _bottomNavBarItem({
    required String title,
    required IconData iconAsset,
    required IconData activeIconAsset,
  }) =>
      BottomNavigationBarItem(
        backgroundColor: AppColors.textFieldColor,
        label: '',
        icon: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconWidget(
              icon: iconAsset,
              color: AppColors.textTextFieldColor,
            ),
            UIHelper.verticalSpace(Dimens.size5),
            TextWidget(
              title: title,
              color: AppColors.textTextFieldColor,
            ),
          ],
        ),
        activeIcon: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconWidget(
              icon: activeIconAsset,
              color: AppColors.appBlueColor,
            ),
            UIHelper.verticalSpace(Dimens.size5),
            TextWidget(
              title: title,
              color: AppColors.whiteColor,
            ),
          ],
        ),
      );
}
