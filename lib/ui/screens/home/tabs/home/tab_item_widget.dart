import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_style.dart';
import 'package:evently_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/app_theme_provider.dart';

class TabItemWidget extends StatelessWidget {
  final bool isSelected;
   final String eventName;
  const TabItemWidget({super.key,required this.isSelected,required this.eventName});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.width(context)*.03,
          vertical: SizeConfig.height(context)*.01
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color:isSelected
          ?Theme.of(context).cardColor
            :Theme.of(context).highlightColor,
          border: Border.all(
          color:Theme.of(context).dividerColor
      )
      ),
      child: Row(
        children: [
          Text(eventName,style: isSelected?AppStyle.medium16White:
            Theme.of(context).textTheme.headlineMedium,),
        ],
      ),
    );
  }
}
