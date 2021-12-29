import 'package:animated_tesla_app/services/home.services.dart';
import 'package:animated_tesla_app/widgets/bottom_navbar.dart';
import 'package:animated_tesla_app/widgets/door_lock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final HomeController _homeController = HomeController();
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _homeController,
        builder: (context, snapshot) {
          return Scaffold(
            body: SafeArea(
              child: LayoutBuilder(
                builder: (context, constrains) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: constrains.maxHeight * 0.1),
                        child: SvgPicture.asset(
                          "assets/icons/Car.svg",
                          width: double.infinity,
                        ),
                      ),
                      Positioned(
                        right: constrains.maxWidth * 0.03,
                        child: DoorLock(
                          isLock: _homeController.isRightDoorLocked,
                          press: _homeController.updateRightDoorLock,
                        ),
                      ),
                      Positioned(
                        left: constrains.maxWidth * 0.03,
                        child: DoorLock(
                          isLock: _homeController.isLeftDoorLocked,
                          press: _homeController.updateLeftDoorLock,
                        ),
                      ),
                      Positioned(
                        top: constrains.maxHeight * 0.13,
                        child: DoorLock(
                          isLock: _homeController.isToptDoorLocked,
                          press: _homeController.updateTopDoorLock,
                        ),
                      ),
                      Positioned(
                        bottom: constrains.maxHeight * 0.17,
                        child: DoorLock(
                          isLock: _homeController.isBottomDoorLocked,
                          press: _homeController.updateBottomDoorLock,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            bottomNavigationBar: BottomNavBar(
              onTap: (value) {},
              selectedTab: 0,
            ),
          );
        });
  }
}
