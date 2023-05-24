import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskmanagment/Model/TaskModel.dart';
import 'package:taskmanagment/Services/FirebaseServices/TaskService.dart';
import 'package:taskmanagment/main.dart';

class ManipulateTaskController extends DisposableProvider {
  DateTime? userDate;
  List<String> taskType = [
    "Personal",
    "Business",
  ];
  String selectedItem = "Personal";

  changeTask(String item) {
    selectedItem = item;
    notifyListeners();
  }

  Future<bool> createTask(
      {required String title,
      required String description,
      required String place,
      required String taskType}) async {
    TaskModel task = TaskModel(
        title: title,
        description: description,
        createdOn: Timestamp.now(),
        endsOn: Timestamp.fromDate(userDate ?? DateTime.now()),
        completedOn: null,
        place: place,
        taskType: taskType,
        hasCompleted: false);

    bool hasAddedTask = await TaskService.shared.createTask(task);
    userDate = null;
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
        hasCompleted: false,
        taskType: '',
        place: '');

    bool hasAddedTask = await TaskService.shared.updateTask(task, id);
    userDate = null;
    return hasAddedTask;
  }

  Future<DateTime?> showDateTimePicker({
    required BuildContext context,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    initialDate ??= DateTime.now();
    firstDate ??= initialDate.subtract(const Duration(days: 365 * 100));
    lastDate ??= firstDate.add(const Duration(days: 365 * 200));

    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (selectedDate == null) return null;

    if (!context.mounted) return selectedDate;

    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedDate),
    );
    userDate = selectedTime == null
        ? selectedDate
        : DateTime(
            selectedDate.year,
            selectedDate.month,
            selectedDate.day,
            selectedTime.hour,
            selectedTime.minute,
          );
    return userDate;
  }

  clearData() {
    userDate = null;

    selectedItem = "Personal";
  }

  @override
  void disposeValues() {
    // TODO: implement disposeValues
  }
}
