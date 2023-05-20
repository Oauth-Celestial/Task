import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:taskmanagment/CustomWidgets/AnimatedDrawer/AnimatedDrawer.dart';
import 'package:taskmanagment/CustomWidgets/AnimatedDrawer/Drawer.dart';
import 'package:taskmanagment/Helpers/AppProviders.dart';
import 'package:taskmanagment/Screen/HomeScreen/HomeScreen.dart';
import 'package:taskmanagment/Screen/Login.dart';
import 'package:taskmanagment/Screen/NoInternet.dart';
import 'package:taskmanagment/Services/NetworkService/NetworkCheck.dart';

// abstract method to reset provider if necessary
abstract class DisposableProvider with ChangeNotifier {
  void disposeValues();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, userData) {
          return MultiProvider(
              providers: AppProviders.shared.providers,
              builder: (context, snapshot) {
                NetworkCheck.shared
                    .setup(widgetForNoInternet: CustomNoInternet());

                return MaterialApp(
                  navigatorKey: NetworkCheck.contextKey,
                  title: 'Tasks',
                  theme: ThemeData(
                    primarySwatch: Colors.blue,
                  ),
                  home: userData.hasData
                      // Custom drawer for animation
                      ? AnimatedDrawer(
                          baseWidget: HomeScreen(),
                          drawerWiget: HomeDrawer(),
                        )
                      : LoginScreen(),
                );
              });
        });
  }
}
