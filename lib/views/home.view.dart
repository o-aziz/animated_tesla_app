import 'package:animated_tesla_app/const.dart';
import 'package:animated_tesla_app/services/home.services.dart';
import 'package:animated_tesla_app/widgets/battery_status.dart';
import 'package:animated_tesla_app/widgets/bottom_navbar.dart';
import 'package:animated_tesla_app/widgets/door_lock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final HomeController _homeController = HomeController();
  late AnimationController _batteryAnimationController;
  late Animation<double> _batteryAnimation;
  late Animation<double> _batteryStatusAnimation;
  late AnimationController _tempAnimationController;
  late Animation<double> _carShiftAnimation;
  void setupAnimations() {
    // batteryanimation :
    _batteryAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _batteryAnimation = CurvedAnimation(
        parent: _batteryAnimationController, curve: const Interval(0, 0.5));
    _batteryStatusAnimation = CurvedAnimation(
        parent: _batteryAnimationController, curve: const Interval(0.6, 1));
    // temp animation:
    _tempAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    _carShiftAnimation = CurvedAnimation(
        parent: _tempAnimationController, curve: const Interval(0.3, 0.5));
  }

  @override
  void initState() {
    setupAnimations();
    super.initState();
  }

  @override
  void dispose() {
    _batteryAnimationController.dispose();
    _tempAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: Listenable.merge([
          _homeController,
          _batteryAnimationController,
          _tempAnimationController
        ]),
        builder: (context, snapshot) {
          return Scaffold(
            body: SafeArea(
              child: LayoutBuilder(
                builder: (context, constrains) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: constrains.maxHeight,
                        width: constrains.maxWidth,
                      ),
                      Positioned(
                        height: constrains.maxHeight,
                        width: constrains.maxWidth,
                        left:
                            constrains.maxWidth / 2 * _carShiftAnimation.value,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: constrains.maxHeight * 0.1),
                          child: SvgPicture.asset(
                            "assets/icons/Car.svg",
                            width: double.infinity,
                          ),
                        ),
                      ),
                      AnimatedPositioned(
                        duration: defaultDuration,
                        right: _homeController.selectedBottomNavItem == 0
                            ? constrains.maxWidth * 0.03
                            : constrains.maxWidth / 2,
                        child: AnimatedOpacity(
                          duration: defaultDuration,
                          opacity: _homeController.selectedBottomNavItem == 0
                              ? 1
                              : 0,
                          child: DoorLock(
                            isLock: _homeController.isRightDoorLocked,
                            press: _homeController.updateRightDoorLock,
                          ),
                        ),
                      ),
                      AnimatedPositioned(
                        duration: defaultDuration,
                        left: _homeController.selectedBottomNavItem == 0
                            ? constrains.maxWidth * 0.03
                            : constrains.maxWidth / 2,
                        child: AnimatedOpacity(
                          duration: defaultDuration,
                          opacity: _homeController.selectedBottomNavItem == 0
                              ? 1
                              : 0,
                          child: DoorLock(
                            isLock: _homeController.isLeftDoorLocked,
                            press: _homeController.updateLeftDoorLock,
                          ),
                        ),
                      ),
                      AnimatedPositioned(
                        duration: defaultDuration,
                        top: _homeController.selectedBottomNavItem == 0
                            ? constrains.maxHeight * 0.13
                            : constrains.maxHeight / 2,
                        child: AnimatedOpacity(
                          duration: defaultDuration,
                          opacity: _homeController.selectedBottomNavItem == 0
                              ? 1
                              : 0,
                          child: DoorLock(
                            isLock: _homeController.isToptDoorLocked,
                            press: _homeController.updateTopDoorLock,
                          ),
                        ),
                      ),
                      AnimatedPositioned(
                        duration: defaultDuration,
                        bottom: _homeController.selectedBottomNavItem == 0
                            ? constrains.maxHeight * 0.17
                            : constrains.maxHeight / 2,
                        child: AnimatedOpacity(
                          duration: defaultDuration,
                          opacity: _homeController.selectedBottomNavItem == 0
                              ? 1
                              : 0,
                          child: DoorLock(
                            isLock: _homeController.isBottomDoorLocked,
                            press: _homeController.updateBottomDoorLock,
                          ),
                        ),
                      ),
                      Opacity(
                        opacity: _batteryAnimation.value,
                        child: SvgPicture.asset(
                          "assets/icons/Battery.svg",
                          width: constrains.maxWidth * 0.5,
                        ),
                      ),
                      Positioned(
                        top: 50 * (1 - _batteryStatusAnimation.value),
                        height: constrains.maxHeight,
                        width: constrains.maxWidth,
                        child: Opacity(
                          opacity: _batteryStatusAnimation.value,
                          child: BatteryStatus(
                            constrains: constrains,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            bottomNavigationBar: BottomNavBar(
              onTap: (value) {
                if (value == 1) {
                  _batteryAnimationController.forward();
                } else if (_homeController.selectedBottomNavItem == 1 &&
                    value != 1) {
                  _batteryAnimationController.reverse(from: 0.7);
                }

                if (value == 2) {
                  _tempAnimationController.forward();
                } else if (_homeController.selectedBottomNavItem == 2 &&
                    value != 2) {
                  _tempAnimationController.reverse(from: 0.4);
                }
                _homeController.onBottomNavTabChange(value);
              },
              selectedTab: _homeController.selectedBottomNavItem,
            ),
          );
        });
  }
}
