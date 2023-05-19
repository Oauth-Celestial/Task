import 'package:flutter/material.dart';

class AnimatedDrawerController with ChangeNotifier {
  bool isDrawerOpen = false;
  AnimationController? animationController;

  // changeDrawerState() {
  //   isDrawerOpen = !isDrawerOpen;
  //   notifyListeners();
  // }

  openDrawer() {
    isDrawerOpen = true;
    animationController?.forward();
    notifyListeners();
  }

  closeDrawer() {
    isDrawerOpen = false;
    animationController?.reverse();
    notifyListeners();
  }
}
