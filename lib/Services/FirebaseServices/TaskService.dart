import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskmanagment/Helpers/DocumentHelper.dart';
import 'package:taskmanagment/Model/HomeDataModel.dart';
import 'package:taskmanagment/Model/SectionModel.dart';
import 'package:taskmanagment/Model/TaskModel.dart';

class TaskService {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static TaskService shared = TaskService();

  /// Creates task on firbase
  Future<bool> createTask(TaskModel task) async {
    try {
      await firestore
          .collection("Users")
          .doc(auth.currentUser!.uid)
          .collection("Task")
          .doc()
          .set(task.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

// Delete task from firebase
  Future<bool> deleteTask(String id) async {
    try {
      await firestore
          .collection("Users")
          .doc(auth.currentUser!.uid)
          .collection("Task")
          .doc(id)
          .delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Update Task on firesbase
  Future<bool> updateTask(TaskModel task, String taskId) async {
    try {
      await firestore
          .collection("Users")
          .doc(auth.currentUser!.uid)
          .collection("Task")
          .doc(taskId)
          .update(task.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Update task status on firebase
  Future<bool> updateTaskStatus(String taskid, bool taskStatus) async {
    try {
      await firestore
          .collection("Users")
          .doc(auth.currentUser!.uid)
          .collection("Task")
          .doc(taskid)
          .update({
        "hasCompleted": taskStatus,
        "completedOn": taskStatus ? Timestamp.now() : null
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Converts user task documents to section data used by section list
  HomeDataModel convertToHomeData(QuerySnapshot? taskData) {
    List<SectionModel> sections = [];
    List<TaskModel> completed = [];
    List<TaskModel> inProgress = [];
    List<QueryDocumentSnapshot>? taskDocuments = taskData?.docs ?? [];

    for (DocumentSnapshot task in taskDocuments ?? []) {
      TaskModel userTask = TaskModel.fromJson(
          json: DocumentHelper.convertToJson(doc: task), taskId: task.id);

      if (userTask.hasCompleted ?? false) {
        completed.add(userTask);
      } else {
        inProgress.add(userTask);
      }
    }
    if (inProgress.length > 0) {
      sections.add(SectionModel(title: "Inbox", sectionTask: inProgress));
    }
    if (completed.length > 0) {
      sections.add(SectionModel(title: "Completed", sectionTask: completed));
    }
    double percentage = 0;
    // Calculate task
    if (taskDocuments.length > 0) {
      percentage = completed.length / taskDocuments.length;
    }

    return HomeDataModel(inProgress.length, completed.length, percentage * 100,
        sections, taskDocuments.length);
  }
}
