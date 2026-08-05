import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../l10n/app_localizations.dart';
import '../../../../../../providers/app_language_provider.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_style.dart';
import '../../../../../../utils/size_config.dart';


void changeLanguage(BuildContext context){
  var languageProvider = Provider.of<AppLanguageProvider>(context,listen: false);
  showDialog(context: context, builder:  (context) {
    return AlertDialog(
      backgroundColor: AppColors.whiteColor,
      title: Column(
        spacing: SizeConfig.height(context)*.03,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton( onPressed: () {
            //todo:change language to english
            languageProvider.changeLanguage('en');
            Navigator.pop(context);
          },
            child: Text(AppLocalizations.of(context)!.english,style: AppStyle.medium20Black,),),
          TextButton( onPressed: () {
            //todo:change language to arabic
            languageProvider.changeLanguage('ar');
            Navigator.pop(context);

          },
            child: Text(AppLocalizations.of(context)!.arabic,style: AppStyle.medium20Black,),),
        ],
      ),
    );
  },);
}

