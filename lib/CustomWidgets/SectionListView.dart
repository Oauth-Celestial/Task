import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:taskmanagment/Constants/AppColors.dart';
import 'package:taskmanagment/Constants/HelperWidget.dart';
import 'package:taskmanagment/Model/SectionModel.dart';
import 'package:taskmanagment/Screen/HomeScreen/ListTile/TaskTile.dart';
import 'package:taskmanagment/Screen/TaskScreen/ManipulateTask.dart';

class SectionListView extends StatelessWidget {
  final List<SectionModel> sections;

  SectionListView({required this.sections});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: sections.length,
      itemBuilder: (BuildContext context, int sectionIndex) {
        SectionModel section = sections[sectionIndex];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10, left: 20, bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    section.title.toUpperCase(),
                    style: TextStyle(
                        color: AppColors.textColor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  HelperWidget.addHorizontalSpace(of: 10),
                  if (section.title.toLowerCase() == "completed") ...[
                    Container(
                      alignment: Alignment.center,
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                          color: AppColors.textColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        "${section.sectionTask?.length}",
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ),
                  ]
                ],
              ),
            ),
            Container(
              height: (section.sectionTask?.length ?? 1) * 93,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: section.sectionTask?.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 5, bottom: 5),
                    child: OpenContainer(
                      transitionType: ContainerTransitionType.fade,
                      transitionDuration: Duration(milliseconds: 450),
                      openBuilder: (context, _) => ManipulateTask(
                        taskData: section.sectionTask![index],
                      ),
                      closedElevation: 0,
                      closedBuilder: (context, _) => TaskTile(
                        task: section.sectionTask![index],
                        index: index + 1,
                      ),
                    ),

                    // TaskTile(
                    //   task: section.sectionTask![index],
                    //   index: index + 1,
                    // ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
