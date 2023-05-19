import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:taskmanagment/Constants/AppColors.dart';
import 'package:taskmanagment/Constants/HelperWidget.dart';
import 'package:taskmanagment/Controller/TaskController.dart';

class AddTask extends StatelessWidget {
  AddTask({super.key});
  String dropdownValue = 'Personal';
  TextEditingController dateController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  FocusNode titleNode = FocusNode();
  FocusNode descriptionNode = FocusNode();

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
              child: Padding(
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
                          "Add New Things",
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
                          Icon(
                            Icons.settings,
                            color: AppColors.navigationButtonColor,
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
                  style: TextStyle(color: Colors.white, fontSize: 17),
                  focusNode: AlwaysDisabledFocusNode(),
                  controller: dateController,
                  onTap: () {
                    Provider.of<TaskController>(context, listen: false)
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
                          Provider.of<TaskController>(context, listen: false)
                              .showDateDialogue(context, dateController);
                          return;
                        }

                        bool hasAdded = await Provider.of<TaskController>(
                                context,
                                listen: false)
                            .createTask(
                                title: titleController.text,
                                description: descriptionController.text,
                                date: dateController.text);
                        if (hasAdded) {
                          Navigator.of(context).pop();
                          HelperWidget.showToast("Task Added");
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
                          "Add Your Thing",
                          style: TextStyle(color: Colors.white, fontSize: 16),
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
          ))),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
