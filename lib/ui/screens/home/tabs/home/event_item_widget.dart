import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/app_theme_provider.dart';

class EventItemWidget extends StatelessWidget {
  const EventItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Container(
      height: SizeConfig.height(context)*.25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).dividerColor,
          width: 2
        ),
          image: DecorationImage(
            fit: BoxFit.fill,
          image:
              AssetImage(AppAssets.birthdayLight )
      )
      ),
      child: Padding(
        padding:  EdgeInsets.symmetric(
            horizontal: SizeConfig.width(context)*.02,
            vertical: SizeConfig.height(context)*.01
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding:  EdgeInsets.symmetric(
                  horizontal: SizeConfig.width(context)*.01,
                  vertical: SizeConfig.height(context)*.01
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).dividerColor,
                  width: 2
                ),
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).highlightColor
              ),
              child: Text('21 Jan',style: Theme.of(context).textTheme.bodyMedium,),
            ),
            Container(

              decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).dividerColor,
                      width: 2
                  ),
                  borderRadius: BorderRadius.circular(8),
                  color: themeProvider.isDarkMode()
                      ?AppColors.darkInputColor
                      :AppColors.strokeWhiteColor
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(AppLocalizations.of(context)!.this_is_a_birthday_party,
                    style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  IconButton( onPressed: () {
                    //todo:add favorite event
                  }, icon: Icon(Icons.favorite_border_outlined,color: Theme.of(context).cardColor),)
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }
}
