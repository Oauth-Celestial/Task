import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:taskmanagment/Constants/AppColors.dart';
import 'package:taskmanagment/Constants/HelperWidget.dart';
import 'package:taskmanagment/Model/HomeDataModel.dart';

import '../../Controller/AnimatedDrawerController.dart';

class TopSection extends StatelessWidget {
  const TopSection({
    super.key,
    required this.size,
    required this.dateFormat,
    required this.data,
  });

  final Size size;
  final DateFormat dateFormat;
  final HomeDataModel data;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.25,
      color: AppColors.purpleBackground,
      child: Row(
        children: [
          Expanded(
              flex: 3,
              child: Container(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.only(left: 25, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Provider.of<AnimatedDrawerController>(context,
                                  listen: false)
                              .openDrawer();
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Icon(
                              Icons.menu,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "Your\nThings",
                          style: TextStyle(fontSize: 35, color: Colors.white),
                        ),
                      ),
                      Expanded(
                          child: Container(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                  "${dateFormat.format(DateTime.now())}",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white))))
                    ],
                  ),
                ),
              )),
          Expanded(
              flex: 3,
              child: Container(
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(child: Container()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${data.inProgressTask} \nIn Progress",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white)),
                            SizedBox(
                              width: 20,
                            ),
                            Text("${data.completedTask} \nCompleted",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white))
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          children: [
                            Container(
                              child: CircularPercentIndicator(
                                radius: 20.0,
                                animation: true,
                                animationDuration: 1200,
                                lineWidth: 5.0,
                                percent: data.percentage / 100,
                                center: new Text(
                                  "${data.percentage.toInt()}%",
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10.0,
                                      color: Colors.white),
                                ),
                                rotateLinearGradient: true,
                                progressColor: AppColors.buttonColor,
                              ),
                            ),
                            HelperWidget.addHorizontalSpace(of: 10),
                            Text("Task Done",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                    color: Colors.white))
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
