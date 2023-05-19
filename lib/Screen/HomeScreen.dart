import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import 'package:taskmanagment/Constants/AppColors.dart';

import 'package:taskmanagment/Controller/AnimatedDrawerController.dart';
import 'package:taskmanagment/CustomWidgets/SectionListView.dart';
import 'package:taskmanagment/Model/HomeDataModel.dart';
import 'package:taskmanagment/Model/SectionModel.dart';

import 'package:taskmanagment/Screen/AddTask.dart';

import 'package:taskmanagment/Screen/TopSection.dart';
import 'package:taskmanagment/Services/FirebaseServices/TaskService.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateFormat dateFormat = DateFormat("MMM dd, yyyy");
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static FirebaseAuth auth = FirebaseAuth.instance;

// FloatingActionButton(
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onPanUpdate: (details) {
        // Swiping in left direction.
        if (details.delta.dx < 0) {
          Provider.of<AnimatedDrawerController>(context, listen: false)
              .closeDrawer();
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.purpleBackground,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: OpenContainer(
          transitionType: ContainerTransitionType.fade,
          transitionDuration: Duration(milliseconds: 800),
          openBuilder: (context, _) => AddTask(),
          closedElevation: 0,
          closedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          closedColor: Colors.blue,
          closedBuilder: (context, _) => Container(
            alignment: Alignment.center,
            color: AppColors.buttonColor,
            width: 60,
            height: 60,
            child: Text(
              "+",
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
          ),
        ),
        body: SafeArea(
            child: StreamBuilder<QuerySnapshot>(
                stream: firestore
                    .collection("Users")
                    .doc(auth.currentUser!.uid)
                    .collection("Task")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print("fetched data");
                    HomeDataModel taskData =
                        TaskService.shared.convertToHomeData(snapshot.data);

                    return Column(
                      children: [
                        TopSection(
                          size: size,
                          dateFormat: dateFormat,
                          data: taskData,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Expanded(
                          child: Container(
                            color: Colors.white,
                            child: SectionListView(
                              sections: taskData.sectionData,
                            ),
                          ),
                        )
                      ],
                    );
                  } else {
                    return Container(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColors.purpleBackground,
                        ),
                      ),
                    );
                  }
                })),
      ),
    );
  }
}
