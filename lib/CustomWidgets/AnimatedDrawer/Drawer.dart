import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanagment/Constants/AppColors.dart';
import 'package:taskmanagment/Constants/AssetPath.dart';
import 'package:taskmanagment/Constants/HelperWidget.dart';

import 'package:taskmanagment/Controller/AnimatedDrawerController.dart';
import 'package:taskmanagment/Controller/ManipulateTaskController.dart';
import 'package:taskmanagment/Controller/TaskController.dart';
import 'package:taskmanagment/CustomWidgets/ResetAppState.dart';
import 'package:taskmanagment/Services/FirebaseServices/AuthService.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  static FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        // Swiping in left direction.
        if (details.delta.dx < 0) {
          Provider.of<AnimatedDrawerController>(context, listen: false)
              .closeDrawer();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          width: 260,
          height: double.infinity,
          child: ListView(
            children: [
              Container(
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: CachedNetworkImage(
                        imageUrl: auth.currentUser?.photoURL ?? "",
                        imageBuilder: (context, imageProvider) => CircleAvatar(
                          radius: 32.0,
                          backgroundColor: AppColors.background,
                          child: CircleAvatar(
                            radius: 30.0,
                            backgroundImage: imageProvider,
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                        placeholder: (context, url) => Icon(
                          Icons.task_alt_outlined,
                          size: 40,
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    // CircleAvatar(
                    //   radius: 30.0,
                    //   backgroundImage: Image.asset(googleicon).image,
                    //   backgroundColor: Colors.transparent,
                    // ),
                    HelperWidget.addVerticalSpace(of: 15),
                    Text("${auth.currentUser?.displayName ?? "-"}",
                        style: TextStyle(
                            fontSize: 19,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                    HelperWidget.addVerticalSpace(of: 5),
                    Text("${auth.currentUser?.email ?? ""}",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        )),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Container(
                  height: 50,
                  child: InkWell(
                    onTap: () {
                      // set up the buttons
                      Widget cancelButton = TextButton(
                        child: Text("Cancel"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      );
                      Widget continueButton = TextButton(
                        child: Text("Logout"),
                        onPressed: () async {
                          Navigator.of(context).pop();
                          Provider.of<TaskController>(context, listen: false)
                              .clearData();
                          Provider.of<ManipulateTaskController>(context,
                                  listen: false)
                              .clearData();

                          //RestartWidget.restartApp(context);

                          await AuthService.signout();
                        },
                      );

                      // set up the AlertDialog
                      AlertDialog alert = AlertDialog(
                        title: Text("Are you sure ?"),
                        content: Text("Would you like to Logout"),
                        actions: [
                          continueButton,
                          cancelButton,
                        ],
                      );

                      // show the dialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout,
                          color: Colors.white,
                        ),
                        HelperWidget.addHorizontalSpace(of: 10),
                        Text("Logout",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ))
                      ],
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
