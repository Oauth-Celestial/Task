import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskmanagment/Helpers/DateHelper.dart';
import 'package:taskmanagment/Model/TaskModel.dart';
import 'package:taskmanagment/Services/FirebaseServices/TaskService.dart';
import 'package:taskmanagment/main.dart';

import '../Constants/AppColors.dart';

class TaskController extends DisposableProvider {
  DateTime? selectedDate;
  Future<bool> createTask(
      {required String title,
      required String description,
      required String date}) async {
    DateTime enteredDate = DateHelper.shared.stringToDate(date);
    TaskModel task = TaskModel(
        title: title,
        description: description,
        createdOn: Timestamp.now(),
        endsOn: Timestamp.fromDate(enteredDate ?? DateTime.now()),
        completedOn: null,
        hasCompleted: false);

    bool hasAddedTask = await TaskService.shared.createTask(task);
    selectedDate = null;
    return hasAddedTask;
  }

  Future<bool> updateTask(
      {required String title,
      required String description,
      required String date,
      required String id}) async {
    DateFormat format = DateFormat.yMMMMd('en_US');
    DateTime enteredDate = format.parse(date);
    TaskModel task = TaskModel(
        title: title,
        description: description,
        createdOn: Timestamp.now(),
        endsOn: Timestamp.fromDate(enteredDate),
        hasCompleted: false);

    bool hasAddedTask = await TaskService.shared.updateTask(task, id);
    selectedDate = null;
    return hasAddedTask;
  }

  showDateDialogue(context, TextEditingController controller) {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100, 12),
        builder: (context, picker) {
          return Theme(
            //TODO: change colors
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: AppColors.headingColor,
                onPrimary: AppColors.background,
                surface: AppColors.background,
                onSurface: AppColors.headingColor,
              ),
              dialogBackgroundColor: AppColors.background,
            ),
            child: picker!,
          );
        }).then((date) {
      //TODO: handle selected date
      if (date != null) {
        selectedDate = date;
        controller.text = DateHelper.shared.datetoString(date);
      }
    });
  }

  @override
  void disposeValues() {
    // TODO: implement disposeValues
  }
}
