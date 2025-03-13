

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/config/color_app.dart';

class AlertLoading {
  AlertLoading._();

  static bool _isDialogOpen = false;

  static show(BuildContext context, String? text) {
    if (_isDialogOpen) return; // Mencegah dialog terbuka dua kali
    _isDialogOpen = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: _customDialog(context, text),
        );
      },
    );
  }

  static hide(BuildContext context) {
    if (!_isDialogOpen) return; // Jika dialog tidak aktif, abaikan
    _isDialogOpen = false;

    if (Navigator.canPop(context)) {
      context.pop();
    }
  }

  static _customDialog(BuildContext context, String? text) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircularProgressIndicator(
                strokeWidth: 5, // Sesuaikan ketebalan garis
                valueColor:
                    AlwaysStoppedAnimation(ColorApp.brand500), // Main Color
                backgroundColor: ColorApp.brand100, // Secondary Color
              ),
              const SizedBox(height: 20),
              Text(
                text ?? "",
                style: TextStyle(
                    color: ColorApp.slate700,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
