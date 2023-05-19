import 'package:taskmanagment/Model/TaskModel.dart';

class SectionModel {
  String title;
  List<TaskModel>? sectionTask;

  SectionModel({this.sectionTask, required this.title});
}
