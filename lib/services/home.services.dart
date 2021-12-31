import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  int selectedBottomNavItem = 0;

  void onBottomNavTabChange(index) {
    selectedBottomNavItem = index;
    notifyListeners();
  }

  bool isRightDoorLocked = true;
  bool isLeftDoorLocked = true;
  bool isToptDoorLocked = true;
  bool isBottomDoorLocked = true;

  void updateRightDoorLock() {
    isRightDoorLocked = !isRightDoorLocked;
    notifyListeners();
  }

  void updateLeftDoorLock() {
    isLeftDoorLocked = !isLeftDoorLocked;
    notifyListeners();
  }

  void updateTopDoorLock() {
    isToptDoorLocked = !isToptDoorLocked;
    notifyListeners();
  }

  void updateBottomDoorLock() {
    isBottomDoorLocked = !isBottomDoorLocked;
    notifyListeners();
  }

  bool isCoolSelected = true;
  updateCoolSelectedTab() {
    isCoolSelected = !isCoolSelected;
    notifyListeners();
  }

  bool showTyres = false;
  bool showTyresStatus = false;

  updateShowTyres(int index) {
    if (index == 3 && selectedBottomNavItem == 3) {
      Future.delayed(
        const Duration(milliseconds: 400),
        () {
          showTyres = true;
          notifyListeners();
          Future.delayed(
            const Duration(milliseconds: 200),
            () {
              showTyresStatus = true;
              notifyListeners();
            },
          );
        },
      );
    } else {
      showTyres = false;
      showTyresStatus = false;
      notifyListeners();
    }
  }
}
