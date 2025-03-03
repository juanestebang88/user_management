import 'package:flutter/material.dart';

class AppDimensions {
  // Obtener el tamaño de la pantalla
  static Size getScreenSize(BuildContext context) {
    return MediaQuery.sizeOf(context);
  }

  // Espacios base responsivos
  static double getResponsivePaddingH(BuildContext context) {
    return getScreenSize(context).width * 0.05; // 5% del ancho de la pantalla
  }

  static double getResponsivePaddingV(BuildContext context) {
    return getScreenSize(context).width * 0.03; // 3% del alto de la pantalla
  }

  static double getResponsiveMargin(BuildContext context) {
    return getScreenSize(context).width * 0.03; // 3% del ancho de la pantalla
  }

  // Tamaños de íconos
  static double getIconSize(BuildContext context) {
    return getScreenSize(context).width * 0.06; // 6% del ancho de la pantalla
  }

  // Altura de botones
  static double getButtonHeight(BuildContext context) {
    return getScreenSize(context).height * 0.07; // 7% de la altura de la pantalla
  }

  // Radio de bordes
  static double getBorderRadius(BuildContext context) {
    return getScreenSize(context).width * 0.04; // 2% del ancho de la pantalla
  }
}