import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import '../../common/common_widget/custom_snackbar.dart';
import 'color_app.dart';

class AppConnectivity {
  static final Connectivity _connectivity = Connectivity();

  static final AppConnectivity _instance = AppConnectivity._internal();

  factory AppConnectivity() {
    return _instance;
  }

  static StreamSubscription<ConnectivityResult>? _subscription;

  AppConnectivity._internal();

  
  static void checkConnectivity() {
    _subscription?.cancel();
    _connectivity.onConnectivityChanged.listen((result) {
      if (result.contains(ConnectivityResult.wifi) || result.contains(ConnectivityResult.mobile)) {
        CustomSnackbar.infoConnectionSnackBar(
            title: "connected to the network.",
            backgroundColor: ColorApp.green400);
        scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
      } else if (result.contains(ConnectivityResult.none)) {
        CustomSnackbar.infoConnectionSnackBar(
            title: "not connected to the network.You mode offline",
            backgroundColor: ColorApp.red500,duration: const Duration(hours: 1));
      }
    });
  }

  static void dispose() {
    _subscription?.cancel();
    _subscription = null;
  }
}
