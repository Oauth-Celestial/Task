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
              children: [
                HelperWidget.addHorizontalSpace(of: 10),
                Container(
                  alignment: Alignment.center,
                  width: 60,
                  height: 60,
                  child: (task.hasCompleted ?? false)
                      ? Icon(
                          Icons.task_alt,
                          color: AppColors.purpleBackground,
                          size: 40,
                        )
                      : Text("${index}"),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 0.5),
                      borderRadius: BorderRadius.circular(30)),
                ),
                HelperWidget.addHorizontalSpace(of: 20),
                Expanded(
                  flex: 4,
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${task.title ?? "-"}",
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
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
                        if (!(task.hasCompleted ?? false)) ...[
                          Container(
                            child: Text(
                              "Task Ends on :- ${DateHelper.shared.stringFromTimeStamp(task.endsOn!)}",
                              maxLines: 2,
                              style:
                                  TextStyle(color: AppColors.purpleBackground),
                            ),
                          )
                        ]
                      ],
                    ),
                  ),
                ),
                HelperWidget.addHorizontalSpace(of: 8),
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
