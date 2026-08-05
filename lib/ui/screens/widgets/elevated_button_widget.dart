import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_style.dart';
import 'package:evently_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/app_theme_provider.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? verticalPadding;
  final double? radius;

  ElevatedButtonWidget({
    required this.child,
    this.onPressed,required this.backgroundColor,this.verticalPadding,
    this.radius,
  this.borderColor});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var currentMode = themeProvider.isDarkMode()
        ? ThemeMode.dark
        : ThemeMode.light;
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: child,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: verticalPadding??0),
          backgroundColor: backgroundColor??AppColors.transparentColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ?? 16),
              side:BorderSide(
                color:borderColor??AppColors.transparentColor ,
                width: 2,
              )

          ),
        ),
      ),
    );
  }
}
