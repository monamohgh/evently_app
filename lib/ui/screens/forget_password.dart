import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/ui/screens/widgets/elevated_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/app_theme_provider.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_style.dart';
import '../../utils/size_config.dart';


class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.width(context) * .02,
            vertical: SizeConfig.height(context) * .01,
          ),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.width(context) * .03,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: BoxBorder.all(
                color: themeProvider.isDarkMode()
                    ? AppColors.strokeDarkColor
                    : AppColors.strokeWhiteColor,
              ),
            ),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                size: 30,
                Icons.arrow_back_ios,
                color: themeProvider.isDarkMode()
                    ? AppColors.whiteColor
                    : AppColors.mainLightColor,
              ),
            ),
          ),
        ),
        actionsPadding: EdgeInsets.symmetric(
          horizontal: SizeConfig.width(context) * .02,
        ),
        backgroundColor: AppColors.transparentColor,
        title: Text(
          AppLocalizations.of(context)!.forget_password,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.width(context) * .03,
          vertical: SizeConfig.height(context) * .03,
        ),
        child: Column(
          spacing: SizeConfig.height(context) * .04,
          children: [
            Image(
              image: AssetImage(
                themeProvider.isDarkMode()
                    ? AppAssets.forgetPasswordDark
                    : AppAssets.forgetPasswordLight,
              ),
            ),
            ElevatedButtonWidget(
              //todo:navigate to reset password
              onPressed: () {},
              verticalPadding: SizeConfig.height(context) * .01,
              backgroundColor: Theme.of(context).cardColor,
              child: Text(
                AppLocalizations.of(context)!.reset_password,
                style: AppStyle.medium20White,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
