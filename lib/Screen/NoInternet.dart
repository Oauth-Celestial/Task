import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:taskmanagment/Constants/AppColors.dart';
import 'package:taskmanagment/Constants/AssetPath.dart';
import 'package:taskmanagment/Services/NetworkService/NetworkCheck.dart';

class CustomNoInternet extends StatefulWidget {
  const CustomNoInternet({super.key});

  @override
  State<CustomNoInternet> createState() => _CustomNoInternetState();
}

class _CustomNoInternetState extends State<CustomNoInternet>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  @override
  void initState() {
    // TODO: implement initState
    controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.purpleBackground,
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Container(
            alignment: Alignment.center,
            child: LottieBuilder.asset(nointernet,
                width: 300,
                height: MediaQuery.of(context).size.height * 0.5,
                repeat: false, onLoaded: (composition) {
              controller?.duration = composition.duration;

              controller?.forward().whenComplete(() async {
                print("dONE");
              });
            }),
          ),
          Text(
            "No Internet connection.",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.center,
              child: Text(
                "Please check your internet connection and try again.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Expanded(
            child: Container(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: InkWell(
                  onTap: () {
                    NetworkCheck.shared.isConnectedtoNetwork();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 180,
                    decoration: BoxDecoration(
                        color: AppColors.buttonColor,
                        borderRadius: BorderRadius.circular(30)),
                    height: 50,
                    child: Text(
                      "Try Again",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
