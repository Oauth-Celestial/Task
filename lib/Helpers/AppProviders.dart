import 'dart:math';

import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:taskmanagment/Controller/AnimatedDrawerController.dart';
import 'package:taskmanagment/Controller/HomeScreenController.dart';
import 'package:taskmanagment/Controller/TaskController.dart';
import 'package:taskmanagment/main.dart';

class AppProviders {
  static AppProviders shared = AppProviders();

  List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (_) => TaskController()),
    ChangeNotifierProvider(create: (_) => AnimatedDrawerController()),
    ChangeNotifierProvider(create: (_) => HomeScreenController())
  ];
}
