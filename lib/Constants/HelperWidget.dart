import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:taskmanagment/Constants/AppColors.dart';

class HelperWidget {
  static Widget addHorizontalSpace({required double of}) {
    return SizedBox(
      width: of,
    );
  }

  static Widget addVerticalSpace({required double of}) {
    return SizedBox(
      height: of,
    );
  }

  static showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.purpleBackground,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
