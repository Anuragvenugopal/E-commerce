import 'package:flutter/material.dart';

import '../utils/appcolors.dart';


class BuildElivatedButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;
  final Color foregroundColor;
  final BorderSide borderSide;
  final double fontSize;
  final FontWeight fontWeight;
  final IconData? icon;
  final double iconSize;
  final double iconRightPadding;

  const BuildElivatedButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
    this.borderRadius = 12,
    this.padding = const EdgeInsets.symmetric(vertical: 14),
    this.backgroundColor = Appcolors.light_green,
    this.foregroundColor = Appcolors.white,
    this.borderSide = const BorderSide(color: Appcolors.white70, width: 1),
    this.fontSize = 16,
    this.fontWeight = FontWeight.bold,
    this.icon,
    this.iconSize = 20,
    this.iconRightPadding = 40,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          padding: padding,
          side: borderSide,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: 0,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                ),
              ),
            ),
            if (icon != null)
              Positioned(
                right: iconRightPadding,
                child: Icon(icon, size: iconSize),
              ),
          ],
        ),
      ),
    );
  }
}
