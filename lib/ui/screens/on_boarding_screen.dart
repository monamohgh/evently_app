import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/ui/screens/widgets/elevated_button_widget.dart';
import 'package:evently_app/utils/app_routes.dart';
import 'package:evently_app/utils/app_style.dart';
import 'package:evently_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';

import '../../providers/app_language_provider.dart';
import '../../providers/app_theme_provider.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_colors.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var currentMode = themeProvider.isDarkMode()
        ? ThemeMode.dark
        : ThemeMode.light;
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
        title: Image(
          image: AssetImage(
            themeProvider.isDarkMode()
                ? AppAssets.eventlyDarkAppbar
                : AppAssets.eventlyLightAppbar,
          ),
        ),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.loginRouteName);
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.width(context) * .05,
                vertical: SizeConfig.height(context) * .01,
              ),
              decoration: BoxDecoration(
                border: BoxBorder.all(
                  color: themeProvider.isDarkMode()
                      ? AppColors.strokeDarkColor
                      : AppColors.strokeWhiteColor,
                ),
                borderRadius: BorderRadius.circular(8),
                color: themeProvider.isDarkMode()
                    ? AppColors.darkInputColor
                    : AppColors.whiteColor,
              ),
              child: Text(
                AppLocalizations.of(context)!.skip,
                  style: Theme.of(context).textTheme.displaySmall
                  // themeProvider.isDarkMode()
                  //     ?AppStyle.medium18White
                  //     :AppStyle.medium18MainColor
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          PageView(
            controller: controller,
            children: [
              pageViewItem(
                image: themeProvider.isDarkMode()
                    ? Image.asset(AppAssets.secondOnBoardingDark)
                    : Image.asset(AppAssets.secondOnBoardingLight),
                title: AppLocalizations.of(
                  context,
                )!.find_events_that_inspire_you,
                body: AppLocalizations.of(context)!.second_onboarding,

                button: ElevatedButtonWidget(
                  verticalPadding: SizeConfig.height(context)*.01,
                  child:Text(AppLocalizations.of(context)!.next,style: AppStyle.medium20White,) ,
                  onPressed: () {
                    controller.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                    );
                  },
                  backgroundColor: themeProvider.isDarkMode()
                      ?AppColors.mainDarkColor
                      :AppColors.mainLightColor,
                ),
              ),
              pageViewItem(
                image: themeProvider.isDarkMode()
                    ? Image.asset(AppAssets.thirdOnBoardingDark)
                    : Image.asset(AppAssets.thirdOnBoardingLight),
                title: AppLocalizations.of(context)!.effortless_event_planning,
                body: AppLocalizations.of(context)!.third_onboarding,
                button: ElevatedButtonWidget(
                  verticalPadding: SizeConfig.height(context)*.01,

                  child:Text( AppLocalizations.of(context)!.next,style: AppStyle.medium20White,),
                  onPressed: () {
                    controller.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                    );
                  },
                  backgroundColor: themeProvider.isDarkMode()
                      ?AppColors.mainDarkColor
                      :AppColors.mainLightColor,
                ),
              ),
              pageViewItem(
                image: themeProvider.isDarkMode()
                    ? Image.asset(AppAssets.fourthOnBoardingDark)
                    : Image.asset(AppAssets.fourthOnBoardingLight),
                title: AppLocalizations.of(
                  context,
                )!.connect_with_friends_share_moments,
                body: AppLocalizations.of(context)!.fourth_onboarding,
                button: ElevatedButtonWidget(
                  verticalPadding: SizeConfig.height(context)*.01,
                  child: Text(AppLocalizations.of(context)!.get_started,style: AppStyle.medium20White,),
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.loginRouteName);
                  },
                  backgroundColor: themeProvider.isDarkMode()
                      ?AppColors.mainDarkColor
                      :AppColors.mainLightColor,
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment(0, 0),
            child: SmoothPageIndicator(
            controller: controller,
                count: 3,
               effect: CustomizableEffect(
                   dotDecoration: DotDecoration(
                     borderRadius: BorderRadius.circular(15),
                     color: themeProvider.isDarkMode()
                         ?  AppColors.lightBgColor
                           :AppColors.greyColor
                   ),
                   activeDotDecoration: DotDecoration(
                       borderRadius: BorderRadius.circular(15),
                       color: themeProvider.isDarkMode()
                           ?  AppColors.mainDarkColor
                           :AppColors.mainLightColor,
                     width: 25
                   )
               ),
            ),
          ),
        ],
      ),
    );
  }

  Widget pageViewItem({
    required Image image,
    required String title,
    required String body,
    required ElevatedButtonWidget button,
  }) {
    return Container(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.width(context) * .03,
        ),
        child: Column(
          spacing: SizeConfig.height(context) * .02,
          children: [
            image,
            SizedBox(height: SizeConfig.height(context) * .1),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                title,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            Text(body, style: Theme.of(context).textTheme.bodyLarge),
            button,
          ],
        ),
      ),
    );
  }
}
