import 'package:flutter/material.dart';
import 'package:taskmanagment/Constants/AppColors.dart';
import 'package:taskmanagment/Constants/HelperWidget.dart';
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
                  child: Text("${index}"),
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
                              fontSize: 15),
                        ),
                        HelperWidget.addVerticalSpace(of: 10),
                        Container(
                          child: Text(
                            "${task.description ?? "-"}",
                            maxLines: 2,
                            style: TextStyle(color: AppColors.textColor),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                HelperWidget.addHorizontalSpace(of: 8),
                // Container(
                //     height: 50,
                //     alignment: Alignment.topCenter,
                //     child: Container(
                //       child: Text(
                //         "9 am",
                //         style: TextStyle(color: AppColors.textColor),
                //       ),
                //     )),
                // HelperWidget.addHorizontalSpace(of: 8),
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
