import 'package:flutter/material.dart';

class InputController with ChangeNotifier {
  hasChangedInput() {
    notifyListeners();
  }
}
