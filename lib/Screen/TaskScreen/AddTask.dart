import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:taskmanagment/Constants/AppColors.dart';
import 'package:taskmanagment/Constants/HelperWidget.dart';
import 'package:taskmanagment/Controller/InputController.dart';
import 'package:taskmanagment/Controller/TaskController.dart';
import 'package:taskmanagment/Helpers/DateHelper.dart';
import 'package:taskmanagment/Helpers/FontHelper.dart';

class AddTask extends StatelessWidget {
  AddTask({super.key});
  String dropdownValue = 'Personal';
  TextEditingController dateController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  FocusNode titleNode = FocusNode();
  FocusNode descriptionNode = FocusNode();
  FocusNode placeNode = FocusNode();

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
            child: SingleChildScrollView(
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
                  HelperWidget.addVerticalSpace(of: 30),
                  Consumer<TaskController>(
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
                  Consumer<TaskController>(
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
                      onChanged: (String? newValue) {
                        controller.changeTask(newValue ?? "Personal");
                      },
                    );
                  }),
                  HelperWidget.addVerticalSpace(of: 10),
                  Consumer<InputController>(
                      builder: (context, controller, snapshot) {
                    return TextField(
                      style: FontHelper.shared.fieldInputStyle(),
                      controller: titleController,
                      focusNode: titleNode,
                      onChanged: (value) {
                        controller.hasChangedInput();
                      },
                      decoration: InputDecoration(
                          suffixIcon: titleController.text.length > 0
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
                      onChanged: (v) {
                        controller.hasChangedInput();
                      },
                      style: FontHelper.shared.fieldInputStyle(),
                      focusNode: descriptionNode,
                      controller: descriptionController,
                      decoration: InputDecoration(
                          suffixIcon: descriptionController.text.length > 0
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
                      onChanged: (_) {
                        controller.hasChangedInput();
                      },
                      style: FontHelper.shared.fieldInputStyle(),
                      focusNode: placeNode,
                      controller: placeController,
                      decoration: InputDecoration(
                          suffixIcon: placeController.text.length > 0
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
                    style: FontHelper.shared.fieldInputStyle(),
                    focusNode: AlwaysDisabledFocusNode(),
                    controller: dateController,
                    onTap: () async {
                      DateTime? date = await Provider.of<TaskController>(
                              context,
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
                  Container(
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
                          DateTime? date = await Provider.of<TaskController>(
                                  context,
                                  listen: false)
                              .showDateTimePicker(context: context);
                          dateController.text = DateHelper.shared
                              .datetoString(date ?? DateTime.now());
                          return;
                        }

                        bool hasAdded = await Provider.of<TaskController>(
                                context,
                                listen: false)
                            .createTask(
                                title: titleController.text,
                                description: descriptionController.text,
                                place: placeController.text,
                                taskType: Provider.of<TaskController>(context,
                                        listen: false)
                                    .selectedItem);
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
                  SizedBox(
                    height: 40,
                  )
                ],
              ),
            ),
          ))),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
