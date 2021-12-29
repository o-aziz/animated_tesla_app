import 'package:animated_tesla_app/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DoorLock extends StatelessWidget {
  const DoorLock({
    Key? key,
    required this.press,
    required this.isLock,
  }) : super(key: key);

  final GestureTapCallback press;
  final bool isLock;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: AnimatedSwitcher(
        duration: defaultDuration,
        transitionBuilder: (child, animation) => ScaleTransition(
          scale: animation,
          child: child,
        ),
        switchInCurve: Curves.easeInOutBack,
        child: isLock
            ? SvgPicture.asset(
                "assets/icons/door_lock.svg",
                key: const ValueKey("RightLock"),
              )
            : SvgPicture.asset(
                "assets/icons/door_unlock.svg",
                key: const ValueKey("RightUnLock"),
              ),
      ),
    );
  }
}
