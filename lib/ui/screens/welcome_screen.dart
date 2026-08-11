import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/ui/screens/widgets/elevated_button_widget.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_routes.dart';
import 'package:evently_app/utils/app_style.dart';
import 'package:evently_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_language_provider.dart';
import '../../providers/app_theme_provider.dart';


class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var currentMode = themeProvider.isDarkMode()
        ? ThemeMode.dark
        : ThemeMode.light;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparentColor,
        title: Image(
          image: AssetImage(
            themeProvider.isDarkMode()
                ? AppAssets.eventlyDarkAppbar
                : AppAssets.eventlyLightAppbar,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.width(context) * .03,
        ),
        child: SingleChildScrollView(
          child: Column(
            spacing: SizeConfig.height(context) * .04,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                fit: BoxFit.fill,
                width: double.infinity,
                image: AssetImage(
                  themeProvider.isDarkMode()
                      ? AppAssets.firstOnBoardingDark
                      : AppAssets.firstOnBoardingLight,
                ),
              ),
              Text(
                AppLocalizations.of(context)!.personalize_your_experience,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Text(
                AppLocalizations.of(context)!.first_onboarding,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Row(
                // spacing: SizeConfig.width(context) * .1,
                children: [
                  Text(
                    AppLocalizations.of(context)!.language,
                    style: Theme.of(context).textTheme.displaySmall
                    // themeProvider.isDarkMode()
                    //     ? AppStyle.medium18White
                    //     : AppStyle.medium18MainColor,
                  ),
                  Spacer(),
                  Row(
                    spacing: SizeConfig.width(context) * .04,
                    children: [
                      //todo:change language to English
                      buildLanguageOption(
                        languageProvider: languageProvider,
                        langCode: 'en',
                        languageLabel: AppLocalizations.of(context)!.english,
                        mode: currentMode,
                      ),
                      buildLanguageOption(
                        //todo:change language to Arabic
                        languageProvider: languageProvider,
                        langCode: 'ar',
                        languageLabel: AppLocalizations.of(context)!.arabic,
                        mode: currentMode,
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                // spacing: SizeConfig.width(context) * .20,
                children: [
                  Text(
                    AppLocalizations.of(context)!.theme,
                    style:Theme.of(context).textTheme.displaySmall
                    // themeProvider.isDarkMode()
                    //     ? AppStyle.medium18White
                    //     : AppStyle.medium18MainColor,
                  ),
                  Spacer(),
                  Row(
                    spacing: SizeConfig.width(context) * .04,
                    children: [
                      //todo:change theme to Light
                      buildThemeOption(
                        themeProvider: themeProvider,
                        itemMode: ThemeMode.light,
                        currentMode: currentMode,
                        selectedIcon: Icons.sunny,
                        unSelectedIcon: Icons.wb_sunny_outlined,
                      ),
          
                      //todo:change theme to Dark
                      buildThemeOption(
                        themeProvider: themeProvider,
                        itemMode: ThemeMode.dark,
                        currentMode: currentMode,
                        selectedIcon: Icons.dark_mode,
                        unSelectedIcon: Icons.dark_mode_outlined,
                      ),
                    ],
                  ),
                ],
              ),
              ElevatedButtonWidget(
                verticalPadding: SizeConfig.height(context) * .01,
                child: Text(
                  AppLocalizations.of(context)!.lets_start,
                  style: AppStyle.medium20White,
                ),
                onPressed: () {
                  //todo:navigate to onboarding screen
                  Navigator.pushNamed(context, AppRoutes.onBoardingRouteName);
                },
                backgroundColor: themeProvider.isDarkMode()
                    ? AppColors.mainDarkColor
                    : AppColors.mainLightColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getSelectedLanguageItem({
    required String language,
    required ThemeMode mode,
  }) {
    if (mode == ThemeMode.dark) {
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.width(context) * .04,
          vertical: SizeConfig.height(context) * .01,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.mainDarkColor,
          border: Border.all(color: AppColors.transparentColor),
        ),
        child: Text(language, style: AppStyle.semi14WhiteColor),
      );
    } else {
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.width(context) * .04,
          vertical: SizeConfig.height(context) * .01,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.mainLightColor,
          border: Border.all(color: AppColors.transparentColor),
        ),
        child: Text(language, style: AppStyle.semi14WhiteColor),
      );
    }
  }

  Widget getUnSelectedLanguageItem({
    required String language,
    required ThemeMode mode,
  }) {
    if (mode == ThemeMode.dark) {
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.width(context) * .04,
          vertical: SizeConfig.height(context) * .01,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.darkInputColor,
          border: Border.all(color: AppColors.strokeDarkColor),
        ),
        child: Text(language, style: AppStyle.semi14WhiteColor),
      );
    } else {
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.width(context) * .04,
          vertical: SizeConfig.height(context) * .01,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.whiteColor,
          border: Border.all(color: AppColors.strokeWhiteColor, width: .5),
        ),
        child: Text(language, style: AppStyle.regular14MainLightColor),
      );
    }
  }

  Widget getSelectedThemeItem({
    required ThemeMode mode,
    required IconData icon,
  }) {
    if (mode == ThemeMode.dark) {
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.width(context) * .06,
          vertical: SizeConfig.height(context) * .01,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.mainDarkColor,
          border: Border.all(color: AppColors.transparentColor),
        ),
        child: Icon(icon, size: 24, color: AppColors.whiteColor),
      );
    } else {
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.width(context) * .06,
          vertical: SizeConfig.height(context) * .01,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.mainLightColor,
          border: Border.all(color: AppColors.transparentColor),
        ),
        child: Icon(icon, size: 24, color: AppColors.whiteColor),
      );
    }
  }

  Widget getUnSelectedThemeItem({
    required ThemeMode mode,
    required IconData icon,
  }) {
    if (mode == ThemeMode.dark) {
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.width(context) * .06,
          vertical: SizeConfig.height(context) * .01,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.darkInputColor,
          border: Border.all(color: AppColors.strokeDarkColor),
        ),
        child: Icon(icon, size: 24, color: AppColors.whiteColor),
      );
    } else {
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.width(context) * .06,
          vertical: SizeConfig.height(context) * .01,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.whiteColor,
          border: Border.all(color: AppColors.strokeWhiteColor),
        ),
        child: Icon(icon, size: 24, color: AppColors.mainLightColor),
      );
    }
  }

  Widget buildThemeOption({
    required AppThemeProvider themeProvider,
    required ThemeMode itemMode, //the selected
    required ThemeMode currentMode,
    required IconData selectedIcon,
    required IconData unSelectedIcon,
  }) {
    bool isSelected = itemMode == currentMode;
    return InkWell(
      onTap: () {
        themeProvider.changeTheme(itemMode);
      },
      child: isSelected
          ? getSelectedThemeItem(mode: currentMode, icon: selectedIcon)
          : getUnSelectedThemeItem(mode: currentMode, icon: unSelectedIcon),
    );
  }

  Widget buildLanguageOption({
    required AppLanguageProvider languageProvider,
    required String langCode,
    required String languageLabel,
    required ThemeMode mode,
  }) {
    bool isSelected = languageProvider.appLanguage == langCode;
    return InkWell(
      onTap: () {
        languageProvider.changeLanguage(langCode);
      },
      child: isSelected
          ? getSelectedLanguageItem(language: languageLabel, mode: mode)
          : getUnSelectedLanguageItem(language: languageLabel, mode: mode),
    );
  }
}
