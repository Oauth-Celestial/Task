import 'package:flutter/material.dart';
import 'package:taskmanagment/main.dart';

class AnimatedDrawerController extends DisposableProvider {
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

  @override
  void disposeValues() {
    bool isDrawerOpen = false;
    AnimationController? animationController;
    // TODO: implement disposeValues
  }
}
