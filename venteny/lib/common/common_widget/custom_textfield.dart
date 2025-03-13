import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../core/config/color_app.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      this.controller,
      this.validator,
      this.onChanged,
      this.onSaved,
      this.onTap,
      this.readOnly,
      this.suffixIcon,
      this.borderRadius,
      this.obscureText,
      this.borderWidth,
      this.prefixIcon,
      this.colorEnabledBorder,
      this.colorFocusedBorder,
      this.hintText,
      this.hintStyle,
      this.helperText,
      this.helperStyle,
      this.helperMaxLines = 1,
      this.keyboardType,
      this.isError = false,
      this.maxLines,
      this.minLines,
      this.labelStyle,
      this.inputFormatter,
      this.enabled = true});
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final void Function()? onTap;
  final bool? readOnly;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? obscureText;
  final Color? colorEnabledBorder;
  final Color? colorFocusedBorder;
  final double? borderRadius;
  final double? borderWidth;
  final String? hintText;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final TextInputType? keyboardType;
  final bool isError;
  final int? maxLines;
  final int? minLines;
  final List<TextInputFormatter>? inputFormatter;
  final bool? enabled;
  final String? helperText;
  final TextStyle? helperStyle;
  final int? helperMaxLines;

  @override
  Widget build(BuildContext context) {
    final int? localMinLines = minLines;
    final int? localMaxLines = maxLines;

    final bool isMultiline = localMinLines != null && localMinLines > 1;

    return TextFormField(
      onTap: onTap,
      readOnly: (readOnly ?? false),
      inputFormatters: inputFormatter,
      validator: validator,
      onChanged: onChanged,
      onSaved: onSaved,
      controller: controller,
      obscureText: obscureText ?? false,
      keyboardType: keyboardType,
      maxLines: isMultiline ? localMaxLines : 1,
      minLines: minLines,
      enabled: enabled,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: ColorApp.slate700,
      ),
      decoration: InputDecoration(
          fillColor: (enabled ?? false) ?  ColorApp.white : ColorApp.white,
          filled: true,
          hintText: hintText,
          hintStyle: hintStyle,
          helperText: helperText,
          helperStyle: helperStyle,
          helperMaxLines: helperMaxLines,
          errorStyle: TextStyle(color: ColorApp.red500),
          contentPadding: isMultiline
              ? const EdgeInsets.symmetric(horizontal: 10, vertical: 10)
              : const EdgeInsets.symmetric(horizontal: 10),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          labelStyle: TextStyle(color: ColorApp.slate700),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 8),
              borderSide: BorderSide(color: ColorApp.slate200)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 8),
              borderSide: BorderSide(
                  color:
                      (enabled ?? true) ? ColorApp.slate200 : ColorApp.brand500,
                  width: borderWidth ?? 1)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 8),
              borderSide: BorderSide(
                  color: colorFocusedBorder ?? ColorApp.brand500,
                  width: borderWidth ?? 1.5)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 8),
              borderSide: BorderSide(color: ColorApp.red500, width: 1.5)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 8),
              borderSide: BorderSide(color: ColorApp.red500, width: 1.5))),
    );
  }
}
