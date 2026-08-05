import 'package:evently_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/app_theme_provider.dart';
typedef OnChanged =void Function(String)?;
class TextFormFieldWidget extends StatelessWidget {
  final double? radius;
  final Color borderColor;
  final bool? filled;
  final Color? fillColor;
  final String? hintText;
  final String? labelText;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLines;
  final TextEditingController? controller;
  final OnChanged onChanged;
   TextFormFieldWidget({super.key,  this.maxLines=1,required this.borderColor,this.radius,this.filled,this.fillColor,
     this.hintText,this.labelText,this.hintStyle,this.labelStyle,
   this.prefixIcon,this.suffixIcon,
     this.onChanged,this.controller
   });

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);

    return TextFormField(
      decoration: InputDecoration(
        enabledBorder: builtDecorationBorder(
            borderColor:borderColor
            ,radius: radius??16),
        focusedBorder:builtDecorationBorder(
            borderColor:borderColor
            ,radius: radius??16) ,
        errorBorder: builtDecorationBorder(
            borderColor:AppColors.redColor
            ,radius: radius??16),
        focusedErrorBorder:builtDecorationBorder(
            borderColor:AppColors.redColor
            ,radius: radius??16) ,
        filled: filled,
        fillColor: fillColor,
        hintText:hintText ,
        hintStyle: hintStyle,
        labelText: labelText,
        labelStyle:labelStyle,
        prefixIcon:prefixIcon ,
        suffixIcon: suffixIcon,
      ),
      maxLines: maxLines,
      controller:controller ,
      onChanged:onChanged ,
    );
  }
  OutlineInputBorder builtDecorationBorder({required double radius,required Color borderColor}){
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(
        color:borderColor ,
        width: 2,
      )
    );
  }
}
