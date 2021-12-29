import 'package:flutter/cupertino.dart';

class HomeController extends ChangeNotifier {
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
}
