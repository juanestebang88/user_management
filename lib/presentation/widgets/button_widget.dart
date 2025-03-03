import 'package:flutter/material.dart';

import '../../core/theme/app_dimensions.dart';
import '../../core/theme/app_text.dart';

class ButtonApp extends StatelessWidget {
  const ButtonApp({
    super.key,
    required this.onTap,
    required this.text,
    required this.size,
    required this.colorButton,
    required this.colorText,
  });
  final void Function() onTap;
  final String text;
  final double size;
  final Color colorButton;
  final Color colorText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.getResponsivePaddingH(context),
            vertical: AppDimensions.getResponsivePaddingV(context)),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 5),
              ),
            ],
            color: colorButton,
            borderRadius:
                BorderRadius.circular(AppDimensions.getBorderRadius(context))),
        child: TextNormalApp(
          text: text,
          color: colorText,
          size: size,
        ),
      ),
    );
  }
}
