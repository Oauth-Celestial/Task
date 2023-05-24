import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  String? taskId;
  String? title;
  String? taskType;
  String? place;
  String? description;
  Timestamp? createdOn;
  Timestamp? endsOn;
  bool? hasCompleted;
  Timestamp? completedOn;

  TaskModel(
      {required this.title,
      this.taskId,
      required this.taskType,
      required this.place,
      required this.description,
      required this.createdOn,
      required this.endsOn,
      required this.hasCompleted,
      this.completedOn});

  factory TaskModel.fromJson(
      {required Map<String, dynamic> json, String? taskId}) {
    return TaskModel(
        taskId: taskId,
        taskType: json["taskType"],
        place: json["place"],
        title: json["title"],
        description: json["description"],
        createdOn: json["createdOn"],
        endsOn: json["endsOn"],
        hasCompleted: json["hasCompleted"],
        completedOn: json["completedOn"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "taskType": this.taskType,
      "place": this.place,
      "title": this.title,
      "description": this.description,
      "createdOn": this.createdOn,
      "endsOn": this.endsOn,
      "hasCompleted": this.hasCompleted,
      "completedOn": this.completedOn,
    };
  }
}
