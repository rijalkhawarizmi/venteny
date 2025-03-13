import 'package:flutter/material.dart';
import 'package:venteny/core/config/color_app.dart';

class StatusTask {
  static String statusTask({required int status}) {
    if (status == 1) {
      return "PENDING";
    } else if (status == 2) {
      return "IN PROGRESS";
    } else {
      return "COMPLETED";
    }
  }

  static Color colorStatusTask({required int status}) {
    if (status == 1) {
      return Colors.yellow.shade600;
    } else if (status == 2) {
      return Colors.blue;
    } else {
      return Colors.greenAccent;
    }
  }
}
