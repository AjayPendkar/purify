import 'package:flutter/material.dart';

class ResponsiveFunctions {
  late int designHeight;
  late int designWidth;
  final double fontCalculation = 0.87;

  // Initialize with device dimensions
  void init(BuildContext context) {
    designHeight = MediaQuery.of(context).size.height.toInt();
    designWidth = MediaQuery.of(context).size.width.toInt();
  }

  double buildWidth(BuildContext context, double width) {
    init(context); // Initialize dimensions
    return width * MediaQuery.of(context).size.width / designWidth;
  }

  double buildHeight(BuildContext context, double height) {
    init(context);
    return height * MediaQuery.of(context).size.height / designHeight;
  }

  double buildFont(BuildContext context, int fontSize) {
    init(context);
    return fontSize * (MediaQuery.of(context).size.height / designHeight * fontCalculation);
  }

  double buildPadding(BuildContext context, double padding) {
    init(context);
    return padding * MediaQuery.of(context).size.width / designWidth;
  }

  double buildMargin(BuildContext context, double margin) {
    init(context);
    return margin * MediaQuery.of(context).size.width / designWidth;
  }

  double buildIconSize(BuildContext context, double size) {
    init(context);
    return size * MediaQuery.of(context).size.width / designWidth;
  }
}