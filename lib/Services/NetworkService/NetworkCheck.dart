import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:taskmanagment/Constants/HelperWidget.dart';

class NetworkCheck {
  static final GlobalKey<NavigatorState> contextKey =
      GlobalKey<NavigatorState>();
  static NetworkCheck shared = NetworkCheck();
  OverlayEntry? entry;
  List<OverlayEntry> entries = [];
  OverlayState? overlayState;
  Widget? noInternetWidget;

  setup({Widget? widgetForNoInternet}) async {
    noInternetWidget = widgetForNoInternet;

    InternetConnectionChecker().onStatusChange.listen((status) {
      overlayState = (contextKey.currentState!.overlay);
      switch (status) {
        case InternetConnectionStatus.connected:
          try {
            removeNoInternet();
          } catch (e) {}
          print('You are Connected to the internet.');
          break;
        case InternetConnectionStatus.disconnected:
          showNoInternet();
          print('You are disconnected from the internet.');
          break;
      }
    });
  }

  isConnectedtoNetwork() async {
    bool isconnected = await InternetConnectionChecker().hasConnection;
    if (isconnected) {
      //removeNoInternet();
    } else {
      HelperWidget.showToast("No Internet");
    }
  }

  removeNoInternet() {
    entries.forEach((entry) => entry.remove());
    entries.clear();
  }

  showNoInternet() {
    BuildContext? insertcontext;
    entry = OverlayEntry(builder: (context) {
      insertcontext = context;
      return noInternetWidget ?? Container();
    });
    entries.add(entry!);
    overlayState?.insert(entry!);
  }
}
