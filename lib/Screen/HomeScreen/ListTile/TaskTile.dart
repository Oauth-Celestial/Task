import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taskmanagment/Constants/AppColors.dart';
import 'package:taskmanagment/Constants/HelperWidget.dart';
import 'package:taskmanagment/Helpers/DateHelper.dart';
import 'package:taskmanagment/Model/TaskModel.dart';

class TaskTile extends StatelessWidget {
  final TaskModel task;
  final int index;
  TaskTile({required this.task, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 80,
        child: Column(
          children: [
            HelperWidget.addVerticalSpace(of: 5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HelperWidget.addHorizontalSpace(of: 10),
                Container(
                  alignment: Alignment.center,
                  width: 60,
                  height: 60,
                  child: Container(
                      width: 40,
                      height: 40,
                      child: Image.asset("Assets/icons/${task.taskType}.png")),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 0.5),
                      borderRadius: BorderRadius.circular(30)),
                ),
                HelperWidget.addHorizontalSpace(of: 20),
                Expanded(
                  flex: 4,
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${task.title ?? "-"}",
                            maxLines: 1,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 17,
                                decoration: (task.hasCompleted ?? false)
                                    ? TextDecoration.lineThrough
                                    : null),
                          ),
                          HelperWidget.addVerticalSpace(of: 5),
                          Container(
                            child: Text(
                              "${task.description ?? "-"}",
                              maxLines: 1,
                              style: TextStyle(
                                  color: AppColors.textColor,
                                  decoration: (task.hasCompleted ?? false)
                                      ? TextDecoration.lineThrough
                                      : null),
                            ),
                          ),
                          HelperWidget.addVerticalSpace(of: 5),
                        ],
                      ),
                    ),
                  ),
                ),
                HelperWidget.addHorizontalSpace(of: 8),
                Container(
                  alignment: Alignment.topLeft,
                  width: 55,
                  height: 60,
                  child: Text(
                      "${DateHelper.shared.getAMorPm(task.endsOn ?? Timestamp.now())}"
                          .toLowerCase(),
                      style: TextStyle(
                        color: AppColors.textColor,
                      )),
                )
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 0.5,
                    color: Colors.grey,
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
