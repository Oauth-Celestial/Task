import 'package:taskmanagment/Model/SectionModel.dart';

class HomeDataModel {
  final int inProgressTask;
  final int completedTask;
  final double percentage;
  final List<SectionModel> sectionData;

  HomeDataModel(this.inProgressTask, this.completedTask, this.percentage,
      this.sectionData);
}
