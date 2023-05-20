import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:taskmanagment/Constants/AppColors.dart';
import 'package:taskmanagment/Constants/AssetPath.dart';
import 'package:taskmanagment/Services/FirebaseServices/AuthService.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.purpleBackground,
      body: SafeArea(
          child: Container(
        child: Column(
          children: [
            Container(
              width: double.infinity,
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              padding: EdgeInsets.only(left: 15),
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Manage Your Daily Task",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text("With",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Tasks",
                          style: TextStyle(
                              color: AppColors.headingColor,
                              fontSize: 25,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.topCenter,
              child: FittedBox(
                child: LottieBuilder.asset(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.5,
                    loginLottie),
              ),
            ),
            Expanded(
                child: Container(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () async {
                  await AuthService.siginwithGoogle();
                },
                child: Container(
                  width: 250,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(35)),
                  child: Stack(
                    fit: StackFit.loose,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 15,
                            ),
                            Image.asset(
                              googleicon,
                              width: 30,
                              height: 30,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            "Sigin with Google",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ))
          ],
        ),
      )),
    );
  }
}
