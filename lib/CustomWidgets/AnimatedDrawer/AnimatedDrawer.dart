import 'dart:math';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:taskmanagment/Constants/AppColors.dart';
import 'package:taskmanagment/Controller/AnimatedDrawerController.dart';

class AnimatedDrawer extends StatefulWidget {
  Widget? drawerWiget;
  Widget? baseWidget;

  AnimatedDrawer({this.drawerWiget, this.baseWidget});

  @override
  State<AnimatedDrawer> createState() => _AnimatedDrawerState();
}

class _AnimatedDrawerState extends State<AnimatedDrawer>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late Animation<double> scaleanimation;

  @override
  void initState() {
    // TODO: implement initState

    Provider.of<AnimatedDrawerController>(context, listen: false)
            .animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200))
          ..addListener(() {
            setState(() {});
          });
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: Provider.of<AnimatedDrawerController>(context, listen: false)
            .animationController!,
        curve: Curves.fastOutSlowIn));
    scaleanimation = Tween<double>(begin: 1, end: 0.9).animate(CurvedAnimation(
        parent: Provider.of<AnimatedDrawerController>(context, listen: false)
            .animationController!,
        curve: Curves.fastOutSlowIn));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.drawerBackground,
      body: Consumer<AnimatedDrawerController>(
          builder: (context, snapshot, child) {
        return Stack(
          children: [
            AnimatedPositioned(
                curve: Curves.fastOutSlowIn,
                duration: Duration(milliseconds: 200),
                left: snapshot.isDrawerOpen ? 0 : -260,
                width: 260,
                height: MediaQuery.of(context).size.height,
                child: widget.drawerWiget ?? Container()),
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(animation.value - 30 * animation.value * pi / 180),
              child: Transform.translate(
                offset: Offset(animation.value * 260, 0),
                child: Transform.scale(
                  scale: scaleanimation.value,
                  child: ClipRRect(
                    borderRadius: snapshot.isDrawerOpen
                        ? BorderRadius.circular(10)
                        : BorderRadius.circular(0),
                    child: widget.baseWidget ?? Container(),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
