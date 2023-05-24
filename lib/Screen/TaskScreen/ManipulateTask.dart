import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:taskmanagment/Constants/AppColors.dart';
import 'package:taskmanagment/Constants/HelperWidget.dart';
import 'package:taskmanagment/Controller/InputController.dart';
import 'package:taskmanagment/Controller/ManipulateTaskController.dart';
import 'package:taskmanagment/Controller/TaskController.dart';
import 'package:taskmanagment/Helpers/DateHelper.dart';
import 'package:taskmanagment/Helpers/FontHelper.dart';
import 'package:taskmanagment/Model/TaskModel.dart';
import 'package:taskmanagment/Services/FirebaseServices/TaskService.dart';

class ManipulateTask extends StatefulWidget {
  final TaskModel taskData;
  ManipulateTask({required this.taskData});

  @override
  State<ManipulateTask> createState() => _ManipulateTaskState();
}

class _ManipulateTaskState extends State<ManipulateTask> {
  String dropdownValue = 'Personal';

  TextEditingController dateController = TextEditingController();

  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  TextEditingController placeController = TextEditingController();

  FocusNode titleNode = FocusNode();

  FocusNode descriptionNode = FocusNode();

  FocusNode placeNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController.text = widget.taskData.title ?? "";
    descriptionController.text = widget.taskData.description ?? "";
    placeController.text = widget.taskData.place ?? "";
    dateController.text = DateHelper.shared
        .stringFromTimeStamp(widget.taskData.endsOn ?? Timestamp.now());
    Provider.of<ManipulateTaskController>(context, listen: false).selectedItem =
        widget.taskData.taskType ?? "Personal";
    Provider.of<ManipulateTaskController>(context, listen: false).userDate =
        DateTime.fromMillisecondsSinceEpoch(
            widget.taskData.endsOn?.millisecondsSinceEpoch ??
                DateTime.now().millisecondsSinceEpoch);
    ;
  }

  @override
  Widget build(BuildContext context) {
    bool isCompleted = (widget.taskData.hasCompleted ?? false);
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
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      HelperWidget.addVerticalSpace(of: 10),
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
                                isCompleted ? "Completed" : " Update",
                                style: FontHelper.shared.fieldInputStyle(),
                              ),
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Provider.of<ManipulateTaskController>(
                                            context,
                                            listen: false)
                                        .clearData();
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
                                  visible:
                                      !(widget.taskData.hasCompleted ?? false),
                                  child: InkWell(
                                    onTap: () async {
                                      bool hasDeleted = await TaskService.shared
                                          .deleteTask(
                                              widget.taskData.taskId ?? "");
                                      if (hasDeleted) {
                                        HelperWidget.showToast("Task Deleted");
                                        Navigator.of(context).pop();
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
                      HelperWidget.addVerticalSpace(of: 30),
                      Consumer<ManipulateTaskController>(
                          builder: (context, controller, snapshot) {
                        return Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(45)),
                          alignment: Alignment.center,
                          child: Container(
                              width: 45,
                              height: 45,
                              child: Image.asset(
                                  "Assets/icons/${controller.selectedItem}.png")),
                        );
                      }),
                      HelperWidget.addVerticalSpace(of: 40),
                      Consumer<ManipulateTaskController>(
                          builder: (context, controller, snapshot) {
                        return DropdownButton(
                          isExpanded: true,
                          style: FontHelper.shared.fieldInputStyle(),
                          value: controller.selectedItem,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          dropdownColor: AppColors.purpleBackground,
                          items: controller.taskType.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          onChanged: isCompleted
                              ? null
                              : (String? newValue) {
                                  controller.changeTask(newValue ?? "Personal");
                                },
                        );
                      }),
                      HelperWidget.addVerticalSpace(of: 10),
                      Consumer<InputController>(
                          builder: (context, controller, snapshot) {
                        return TextField(
                          readOnly: isCompleted,
                          style: FontHelper.shared
                              .fieldInputStyle(iscompleted: isCompleted),
                          controller: titleController,
                          focusNode: titleNode,
                          onChanged: (value) {
                            controller.hasChangedInput();
                          },
                          decoration: InputDecoration(
                              suffixIcon: titleController.text.length > 0 &&
                                      !isCompleted
                                  ? IconButton(
                                      onPressed: () {
                                        titleController.clear();
                                        controller.hasChangedInput();
                                      },
                                      icon: Icon(Icons.cancel),
                                    )
                                  : null,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              hintText: "Title",
                              hintStyle: TextStyle(color: Colors.grey),
                              labelStyle: TextStyle(color: Colors.grey)),
                        );
                      }),
                      HelperWidget.addVerticalSpace(of: 25),
                      Consumer<InputController>(
                          builder: (context, controller, snapshot) {
                        return TextField(
                          readOnly: isCompleted,
                          onChanged: (v) {
                            controller.hasChangedInput();
                          },
                          style: FontHelper.shared
                              .fieldInputStyle(iscompleted: isCompleted),
                          focusNode: descriptionNode,
                          controller: descriptionController,
                          decoration: InputDecoration(
                              suffixIcon:
                                  descriptionController.text.length > 0 &&
                                          !isCompleted
                                      ? IconButton(
                                          onPressed: () {
                                            descriptionController.clear();
                                            controller.hasChangedInput();
                                          },
                                          icon: Icon(Icons.cancel),
                                        )
                                      : null,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              hintText: 'Description',
                              hintStyle: TextStyle(color: Colors.grey)),
                        );
                      }),
                      HelperWidget.addVerticalSpace(of: 10),
                      Consumer<InputController>(
                          builder: (context, controller, snapshot) {
                        return TextField(
                          readOnly: isCompleted,
                          onChanged: (_) {
                            controller.hasChangedInput();
                          },
                          style: FontHelper.shared
                              .fieldInputStyle(iscompleted: isCompleted),
                          focusNode: placeNode,
                          controller: placeController,
                          decoration: InputDecoration(
                              suffixIcon: placeController.text.length > 0 &&
                                      !isCompleted
                                  ? IconButton(
                                      onPressed: () {
                                        placeController.clear();
                                        controller.hasChangedInput();
                                      },
                                      icon: Icon(Icons.cancel),
                                    )
                                  : null,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              hintText: 'Place',
                              hintStyle: TextStyle(color: Colors.grey)),
                        );
                      }),
                      HelperWidget.addVerticalSpace(of: 10),
                      TextField(
                        readOnly: isCompleted,
                        style: FontHelper.shared
                            .fieldInputStyle(iscompleted: isCompleted),
                        focusNode: AlwaysDisabledFocusNode(),
                        controller: dateController,
                        onTap: isCompleted
                            ? null
                            : () async {
                                DateTime? date =
                                    await Provider.of<TaskController>(context,
                                            listen: false)
                                        .showDateTimePicker(context: context);
                                dateController.text = DateHelper.shared
                                    .datetoString(date ?? DateTime.now());
                              },
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            labelText: 'Time',
                            labelStyle: TextStyle(color: Colors.grey)),
                      ),
                      HelperWidget.addVerticalSpace(of: 35),
                      if (isCompleted) ...[
                        Text(
                          "Task Completed on :- ${DateHelper.shared.stringFromTimeStamp(widget.taskData.completedOn ?? Timestamp.now())}",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                      Visibility(
                        visible: !(widget.taskData.hasCompleted ?? false),
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

                              if (placeController.text == "") {
                                placeNode.requestFocus();
                                return;
                              }

                              if (dateController.text == "") {
                                DateTime? date =
                                    await Provider.of<TaskController>(context,
                                            listen: false)
                                        .showDateTimePicker(context: context);
                                dateController.text = DateHelper.shared
                                    .datetoString(date ?? DateTime.now());
                                return;
                              }

                              bool hasAdded = await Provider.of<TaskController>(
                                      context,
                                      listen: false)
                                  .updateTask(
                                      title: titleController.text,
                                      description: descriptionController.text,
                                      place: placeController.text,
                                      taskType:
                                          Provider.of<ManipulateTaskController>(
                                                  context,
                                                  listen: false)
                                              .selectedItem,
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
                      SizedBox(
                        height: 40,
                      )
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: 50,
                  color: Colors.deepPurple.shade400,
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    InkWell(
                      onTap: () async {
                        bool hasUpdatedTask = await TaskService.shared
                            .updateTaskStatus(widget.taskData.taskId ?? "",
                                !(widget.taskData.hasCompleted ?? false));

                        if (hasUpdatedTask) {
                          HelperWidget.showToast("Task Status Updated");
                          Navigator.of(context).pop();
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        child: Text(
                          (widget.taskData.hasCompleted ?? false)
                              ? "Mark has Incomplete"
                              : "Mark has complete",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    HelperWidget.addHorizontalSpace(of: 10),
                  ]),
                ),
              )
            ],
          ))),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
