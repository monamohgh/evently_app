
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/ui/screens/home/tabs/profile/widgets/change_language.dart';
import 'package:evently_app/ui/screens/home/tabs/profile/widgets/profile_item.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_style.dart';
import 'package:evently_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/app_theme_provider.dart';
import '../../../../../providers/user_provider.dart';


class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var userProvider=Provider.of<UserProvider>(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.width(context) * .04,
        vertical: SizeConfig.height(context) * .04,
      ),
      child: SafeArea(
        child: Column(
          spacing: SizeConfig.height(context) * .02,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(AppAssets.route),
            ),
            Text(userProvider.currentUser!.name, style: Theme.of(context).textTheme.headlineLarge),
            Text(
              userProvider.currentUser!.email,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            ProfileItem(
              title: AppLocalizations.of(context)!.dark_mode,
              icon: Switch(
                trackOutlineColor: WidgetStateProperty.resolveWith<Color?>((
                  Set<WidgetState> states,
                ) {
                  if (states.contains(WidgetState.selected)) {
                    return AppColors.transparentColor;
                  }
                  return AppColors.whiteColor; // Use the default color.
                }),
                activeTrackColor: AppColors.mainDarkColor,
                inactiveTrackColor: AppColors.lightGrayColor,
                activeThumbColor: AppColors.whiteColor,
                inactiveThumbColor: AppColors.whiteColor,
                value: themeProvider.isDarkMode(),
                onChanged: (value) {
             themeProvider.changeTheme(value?ThemeMode.dark:ThemeMode.light);
                },
              ),
            ),
            ProfileItem(
              title: AppLocalizations.of(context)!.language,
              icon: IconButton(
                onPressed: () {
                  //todo:show language bottom sheet
                  changeLanguage(context);
                },
                icon: Icon(Icons.arrow_forward_ios, size: 25),
                color: Theme.of(context).cardColor,
              ),
            ),
            ProfileItem(
              title: AppLocalizations.of(context)!.logout,
              icon: IconButton(
                onPressed: () {
                  //todo:logout
                },
                icon: Icon(Icons.logout, size: 25),
                color: AppColors.redColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

