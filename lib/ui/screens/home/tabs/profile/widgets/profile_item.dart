import 'package:evently_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../providers/app_theme_provider.dart';

class ProfileItem extends StatelessWidget {
   ProfileItem({super.key, required this.title,required this.icon});
   String title;
   Widget icon;

  @override
  Widget build(BuildContext context) {
    var themeProvider=Provider.of<AppThemeProvider>(context);
    return  Container(
        decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: themeProvider.isDarkMode()
                  ?AppColors.darkInputColor
                  :AppColors.whiteColor
               ,border: Border.all(
              color: Theme.of(context).dividerColor,
          width: 2
            ),
    ),
        child:  ListTile(
          title: Text(title, style: Theme.of(context).textTheme.headlineMedium),
          trailing: icon,)
);}}