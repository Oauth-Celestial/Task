import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:taskmanagment/Constants/AppColors.dart';
import 'package:taskmanagment/Constants/AssetPath.dart';
import 'package:taskmanagment/Constants/HelperWidget.dart';
import 'package:taskmanagment/Helpers/FontHelper.dart';
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
      height: size.height * 0.28,
      decoration: BoxDecoration(
          color: AppColors.purpleBackground,
          image: DecorationImage(
            opacity: 0.5,
            image: AssetImage(mountain),
            fit: BoxFit.fill,
          )),
      child: Row(
        children: [
          Expanded(
              flex: 4,
              child: Container(
                color: Colors.black.withOpacity(0.1),
                child: Padding(
                  padding: const EdgeInsets.only(left: 25, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          if (Provider.of<AnimatedDrawerController>(context,
                                  listen: false)
                              .isDrawerOpen) {
                            Provider.of<AnimatedDrawerController>(context,
                                    listen: false)
                                .closeDrawer();
                          } else {
                            Provider.of<AnimatedDrawerController>(context,
                                    listen: false)
                                .openDrawer();
                          }
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          alignment: Alignment.centerLeft,
                          child: Icon(
                            Icons.menu,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "Your\nThings",
                          style: FontHelper.shared.setLiteraRegular(
                              style:
                                  TextStyle(fontSize: 33, color: Colors.white)),
                        ),
                      ),
                      HelperWidget.addVerticalSpace(of: 5),
                      Expanded(
                          child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  "${dateFormat.format(DateTime.now())}",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.textColor))))
                    ],
                  ),
                ),
              )),
          Expanded(
              flex: 3,
              child: Container(
                color: Colors.black.withOpacity(0.33),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(flex: 2, child: Container()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "${data.personalTask}",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            ),
                            Text(
                              "Personal",
                              style: FontHelper.shared.setLiteraRegular(
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: AppColors.textColor)),
                            )

                            // Text("${data.inProgressTask} \nIn Progress",
                            //     style: TextStyle(
                            //         fontSize: 15, color: Colors.white)),
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "${data.businessTask}",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            ),
                            Text("Business",
                                style: FontHelper.shared.setLiteraRegular(
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.textColor)))

                            // Text("${data.inProgressTask} \nIn Progress",
                            //     style: TextStyle(
                            //         fontSize: 15, color: Colors.white)),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Container(
                          height: 20,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                child: CircularPercentIndicator(
                                  radius: 10.0,
                                  animation: true,
                                  animationDuration: 1200,
                                  lineWidth: 2.0,
                                  percent: data.percentage / 100,
                                  rotateLinearGradient: true,
                                  linearGradient: LinearGradient(colors: [
                                    Colors.white,
                                    AppColors.buttonColor
                                  ]),
                                ),
                              ),
                              HelperWidget.addHorizontalSpace(of: 5),
                              Text("${data.percentage.toInt()} % done",
                                  style: FontHelper.shared.setLiteraRegular(
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: AppColors.textColor))),
                              HelperWidget.addHorizontalSpace(of: 10)
                            ],
                          ),
                        ),
                      ),
                    ),
                    HelperWidget.addVerticalSpace(of: 10),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
