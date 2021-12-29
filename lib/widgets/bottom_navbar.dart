import 'package:animated_tesla_app/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
    required this.selectedTab,
    required this.onTap,
  }) : super(key: key);
  final int selectedTab;
  final ValueChanged<int> onTap;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: onTap,
      currentIndex: selectedTab,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.black,
      elevation: 0,
      items: List.generate(
        bottomNavIcons.length,
        (index) => BottomNavigationBarItem(
          label: "",
          icon: SvgPicture.asset(
            bottomNavIcons[index],
            color: index == selectedTab ? primaryColor : Colors.white30,
          ),
        ),
      ),
    );
  }
}

List<String> bottomNavIcons = [
  "assets/icons/Lock.svg",
  "assets/icons/Charge.svg",
  "assets/icons/Temp.svg",
  "assets/icons/Tyre.svg",
];
