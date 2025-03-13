import 'package:flutter/material.dart';

import '../../core/config/color_app.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      required this.title,
      required this.fontSize,
      this.backgroundColor,
      this.onPressed,
      this.fontWeight,
      this.colorTitle,
      this.width,
      this.height,
      this.borderColor,
      this.borderRadius,
      this.widthBorder,
      this.icon,
      this.iconEnd,
      this.padding})
      : super(key: key);
  final void Function()? onPressed;
  final String title;
  final Color? colorTitle;
  final Color? backgroundColor;
  final double? width;
  final double? height;
  final Color? borderColor;
  final double? borderRadius;
  final double? widthBorder;
  final double fontSize;
  final FontWeight? fontWeight;
  final Widget? icon;
  final Widget? iconEnd;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          if (onPressed != null) {
            onPressed!();
          }
        },
        style: ElevatedButton.styleFrom(
            padding: padding ?? EdgeInsets.all(0),
            elevation: 0,
            side: BorderSide(
                width: widthBorder ?? 1.5,
                color: borderColor ?? Colors.transparent),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 8)),
            minimumSize: Size(width ?? double.infinity, height ?? 50),
            backgroundColor: backgroundColor ?? ColorApp.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon ?? SizedBox(),
            icon != null
                ? SizedBox(
                    width: 10,
                  )
                : SizedBox(),
            Text(
              title,
              style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: fontWeight ?? FontWeight.normal,
                  color: colorTitle ?? ColorApp.black),
            ),
            if (iconEnd != null) ...[
              SizedBox(width: 10),
              iconEnd!,
            ],
          ],
        ));
  }
}
