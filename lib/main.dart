import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanagment/Controller/TaskController.dart';
import 'package:taskmanagment/Controller/AnimatedDrawerController.dart';
import 'package:taskmanagment/CustomWidgets/AnimatedDrawer/AnimatedDrawer.dart';
import 'package:taskmanagment/CustomWidgets/AnimatedDrawer/Drawer.dart';
import 'package:taskmanagment/CustomWidgets/ResetAppState.dart';
import 'package:taskmanagment/Screen/HomeScreen.dart';
import 'package:taskmanagment/Screen/Login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(RestartWidget(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => TaskController()),
          ChangeNotifierProvider(create: (_) => AnimatedDrawerController())
        ],
        builder: (context, snapshot) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: StreamBuilder<User?>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return AnimatedDrawer(
                      baseWidget: HomeScreen(),
                      drawerWiget: HomeDrawer(),
                    );
                  } else {
                    return LoginScreen();
                  }
                }),
          );
        });
  }
}
