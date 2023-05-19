import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import 'package:taskmanagment/Constants/AppColors.dart';
import 'package:taskmanagment/Constants/HelperWidget.dart';
import 'package:taskmanagment/Controller/TaskController.dart';
import 'package:taskmanagment/Model/TaskModel.dart';
import 'package:taskmanagment/Services/FirebaseServices/TaskService.dart';

class ManipulateTask extends StatefulWidget {
  TaskModel taskData;
  ManipulateTask({required this.taskData});

  @override
  State<ManipulateTask> createState() => _ManipulateTaskState();
}

class _ManipulateTaskState extends State<ManipulateTask> {
  String dropdownValue = 'Personal';

  TextEditingController dateController = TextEditingController();

  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  FocusNode titleNode = FocusNode();

  FocusNode descriptionNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController.text = widget.taskData.title ?? "";
    descriptionController.text = widget.taskData.title ?? "";
    var date = new DateTime.fromMillisecondsSinceEpoch(
        widget.taskData.endsOn!.millisecondsSinceEpoch);
    dateController.text = DateFormat.yMMMMd().format(date);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    titleController.dispose();
    dateController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.purpleBackground,
        body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 50,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              widget.taskData.hasCompleted!
                                  ? "Completed"
                                  : "Update",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18),
                            ),
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: AppColors.navigationButtonColor,
                                  ),
                                ),
                              ),
                              Expanded(child: Container()),
                              Visibility(
                                visible: !widget.taskData.hasCompleted!,
                                child: InkWell(
                                  onTap: () async {
                                    bool hasDeletedTask = await TaskService
                                        .shared
                                        .deleteTask(widget.taskData.taskId!);
                                    if (hasDeletedTask) {
                                      Navigator.of(context).pop();
                                      HelperWidget.showToast("Deleted Task");
                                    }
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: AppColors.navigationButtonColor,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      child: Icon(
                        Icons.add_task,
                        size: 50,
                        color: AppColors.background,
                      ),
                    ),
                    TextField(
                      style: TextStyle(color: Colors.white, fontSize: 17),
                      controller: titleController,
                      readOnly: widget.taskData.hasCompleted ?? false,
                      focusNode: titleNode,
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          labelText: 'Title',
                          labelStyle: TextStyle(color: Colors.grey)),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      height: 100,
                      child: TextField(
                        readOnly: widget.taskData.hasCompleted ?? false,
                        style: TextStyle(color: Colors.white, fontSize: 17),
                        focusNode: descriptionNode,
                        controller: descriptionController,
                        maxLines: null, // Set this
                        expands: true, // and this
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            labelText: 'Description',
                            labelStyle: TextStyle(color: Colors.grey)),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextField(
                      readOnly: widget.taskData.hasCompleted!,
                      style: TextStyle(color: Colors.white, fontSize: 17),
                      focusNode: AlwaysDisabledFocusNode(),
                      controller: dateController,
                      onTap: widget.taskData.hasCompleted!
                          ? null
                          : () {
                              Provider.of<TaskController>(context,
                                      listen: false)
                                  .showDateDialogue(context, dateController);
                            },
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          labelText: 'Date',
                          labelStyle: TextStyle(color: Colors.grey)),
                    ),
                    SizedBox(
                      height: 80,
                    ),
                    Expanded(
                      child: Visibility(
                        visible: !widget.taskData.hasCompleted!,
                        child: Container(
                          alignment: Alignment.topCenter,
                          child: InkWell(
                            onTap: () async {
                              if (titleController.text == "") {
                                titleNode.requestFocus();
                                return;
                              }

                              if (descriptionController.text == "") {
                                descriptionNode.requestFocus();
                                return;
                              }

                              if (dateController.text == "") {
                                Provider.of<TaskController>(context,
                                        listen: false)
                                    .showDateDialogue(context, dateController);
                                return;
                              }
                              bool hasAdded = await Provider.of<TaskController>(
                                      context,
                                      listen: false)
                                  .updateTask(
                                      title: titleController.text,
                                      description: descriptionController.text,
                                      date: dateController.text,
                                      id: widget.taskData.taskId ?? "");
                              if (hasAdded) {
                                Navigator.of(context).pop();
                                HelperWidget.showToast("Task Updated");
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                color: AppColors.buttonColor,
                              ),
                              child: Text(
                                "Update",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  color: AppColors.drawerBackground,
                  height: 50,
                  child: InkWell(
                    onTap: () async {
                      bool hasUpdated = await TaskService.shared
                          .updateTaskStatus(widget.taskData.taskId ?? "",
                              !(widget.taskData.hasCompleted ?? false));
                      Navigator.of(context).pop();
                      HelperWidget.showToast("Status Updated");
                    },
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              child: Text(
                                widget.taskData.hasCompleted ?? false
                                    ? "Mark As Incomplete"
                                    : "Mark as Completed",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            HelperWidget.addHorizontalSpace(of: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
