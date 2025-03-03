import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_management/core/theme/app_dimensions.dart';

import '../../core/theme/app_colors.dart';

class TextFormApp extends StatelessWidget {
  const TextFormApp({
    super.key,
    required this.controller,
    required this.label,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validate = true,
    this.readOnly = false,
    this.onTap
  });

  final TextEditingController controller;
  final String label;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool validate;
  final bool readOnly;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: AppDimensions.getResponsivePaddingH(context),
          vertical: AppDimensions.getResponsivePaddingV(context)),
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(AppDimensions.getBorderRadius(context)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextFormField(
        onTap: onTap,
        readOnly: readOnly,
        obscureText: obscureText,
        keyboardType: keyboardType,
        controller: controller,
        decoration: InputDecoration(
          labelStyle: GoogleFonts.raleway(
              fontWeight: FontWeight.normal,
              color: ColorApp.black,
              fontSize: 18.0),
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimensions.getBorderRadius(context)),
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(0.5),
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimensions.getBorderRadius(context)),
            borderSide: const BorderSide(
              color: ColorApp.blue,
              width: 2.0,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimensions.getBorderRadius(context)),
            borderSide: const BorderSide(
              color: ColorApp.red,
              width: 2.0,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimensions.getBorderRadius(context)),
            borderSide: const BorderSide(
              color: ColorApp.red,
              width: 2.0,
            ),
          ),
          contentPadding: EdgeInsets.all(AppDimensions.getResponsivePaddingV(context)),
          constraints: const BoxConstraints(
            minWidth: 200,
          ),
        ),
        validator: (value) {
          if (validate && (value == null || value.isEmpty)) {
            return 'Este campo no puede estar vacio';
          }
          return null;
        },
      ),
    );
  }
}
