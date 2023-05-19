import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanagment/Constants/AppColors.dart';
import 'package:taskmanagment/Constants/AssetPath.dart';
import 'package:taskmanagment/Constants/HelperWidget.dart';

import 'package:taskmanagment/Controller/AnimatedDrawerController.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
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
                    CircleAvatar(
                      radius: 30.0,
                      backgroundImage: Image.asset(googleicon).image,
                      backgroundColor: Colors.transparent,
                    ),
                    HelperWidget.addVerticalSpace(of: 15),
                    Text("Ravi Pai",
                        style: TextStyle(
                            fontSize: 19,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                    HelperWidget.addVerticalSpace(of: 5),
                    Text("ravi.983365@gmail.com",
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
