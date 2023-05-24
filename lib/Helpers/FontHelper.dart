import 'package:flutter/material.dart';

class FontHelper {
  static FontHelper shared = FontHelper();

  TextStyle setLiteraRegular({required TextStyle style}) {
    return style.copyWith(fontFamily: "Litera");
  }

  TextStyle fieldInputStyle({bool iscompleted = false}) {
    return TextStyle(
        color: iscompleted ? Colors.grey : Colors.white, fontSize: 17);
  }
}
