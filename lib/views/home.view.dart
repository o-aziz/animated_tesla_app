import 'package:animated_tesla_app/const.dart';
import 'package:animated_tesla_app/models/tyre_psi.dart';
import 'package:animated_tesla_app/services/home.services.dart';
import 'package:animated_tesla_app/widgets/battery_status.dart';
import 'package:animated_tesla_app/widgets/bottom_navbar.dart';
import 'package:animated_tesla_app/widgets/door_lock.dart';
import 'package:animated_tesla_app/widgets/temp_btn.dart';
import 'package:animated_tesla_app/widgets/temp_details.dart';
import 'package:animated_tesla_app/widgets/tyre_psi_card.dart';
import 'package:animated_tesla_app/widgets/tyres.dart';
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
  late Animation<double> _tempInfoAnimation;
  late Animation<double> _glowAnimation;
  late AnimationController _tyreAnimationController;
  late Animation<double> _tyre1Animation;
  late Animation<double> _tyre2Animation;
  late Animation<double> _tyre3Animation;
  late Animation<double> _tyre4Animation;

  late List<Animation<double>> tyreAnimations;

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
    _tempInfoAnimation = CurvedAnimation(
        parent: _tempAnimationController, curve: const Interval(0.55, 0.75));
    _glowAnimation = CurvedAnimation(
        parent: _tempAnimationController, curve: const Interval(0.8, 1));

    // tyre animations:
    _tyreAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));
    _tyre1Animation = CurvedAnimation(
        parent: _tyreAnimationController, curve: const Interval(0.34, 0.5));
    _tyre2Animation = CurvedAnimation(
        parent: _tyreAnimationController, curve: const Interval(0.5, 0.66));
    _tyre3Animation = CurvedAnimation(
        parent: _tyreAnimationController, curve: const Interval(0.66, 0.82));
    _tyre4Animation = CurvedAnimation(
        parent: _tyreAnimationController, curve: const Interval(0.82, 1));
  }

  @override
  void initState() {
    setupAnimations();
    tyreAnimations = [
      _tyre1Animation,
      _tyre2Animation,
      _tyre3Animation,
      _tyre4Animation
    ];
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
          _tempAnimationController,
          _tyreAnimationController,
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
                      // battery page:
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
                      // temp page:
                      Positioned(
                        height: constrains.maxHeight,
                        width: constrains.maxWidth,
                        top: 20 * (1 - _tempInfoAnimation.value),
                        child: Opacity(
                          opacity: _tempInfoAnimation.value,
                          child: TempDetails(homeController: _homeController),
                        ),
                      ),
                      Positioned(
                        right: -180 * (1 - _glowAnimation.value),
                        child: Image.asset(
                          _homeController.isCoolSelected
                              ? "assets/images/Cool_glow_2.png"
                              : "assets/images/Hot_glow_4.png",
                          width: 200,
                        ),
                      ),
                      // tyre :
                      if (_homeController.showTyres) ...tyres(constrains),
                      if (_homeController.showTyresStatus)
                        GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 4,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: defaultPadding,
                              crossAxisSpacing: defaultPadding,
                              childAspectRatio:
                                  constrains.maxWidth / constrains.maxHeight,
                            ),
                            itemBuilder: (context, index) {
                              return ScaleTransition(
                                scale: tyreAnimations[index],
                                child: TyrePsiCard(
                                  isBottomTyres: index > 1,
                                  tyrePsi: demoPsiList[index],
                                ),
                              );
                            }),
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

                if (value == 3) {
                  _tyreAnimationController.forward();
                } else if (_homeController.selectedBottomNavItem == 3 &&
                    value != 3) {
                  _tyreAnimationController.reverse(from: 0.4);
                }

                _homeController.onBottomNavTabChange(value);
                _homeController.updateShowTyres(value);
              },
              selectedTab: _homeController.selectedBottomNavItem,
            ),
          );
        });
  }
}
