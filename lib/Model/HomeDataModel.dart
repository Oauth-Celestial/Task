import 'package:taskmanagment/Model/SectionModel.dart';

class HomeDataModel {
  final int inProgressTask;
  final int completedTask;
  final double percentage;
  final List<SectionModel> sectionData;
  final int totalTask;
  final int personalTask;
  final int businessTask;

  HomeDataModel(this.inProgressTask, this.completedTask, this.percentage,
      this.sectionData, this.totalTask, this.personalTask, this.businessTask);
}
