import 'package:evently_app/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';
import '../../../providers/app_theme_provider.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_routes.dart';
import '../../../utils/size_config.dart';
import '../widgets/elevated_button_widget.dart';
import '../widgets/text_form_field_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
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
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.width(context) * .04,
          vertical: SizeConfig.height(context) * .03,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: SizeConfig.height(context) * .015,
            children: [
              Text(
                AppLocalizations.of(context)!.login_to_your_account,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              TextFormFieldWidget(
                borderColor: Theme.of(context).dividerColor,
                filled: true,
                fillColor: themeProvider.isDarkMode()
                    ? AppColors.darkInputColor
                    : AppColors.strokeWhiteColor,
                hintText: AppLocalizations.of(context)!.enter_your_email,
                hintStyle: Theme.of(context).textTheme.bodyLarge,
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: AppColors.lightGrayColor,
                ),
              ),
              TextFormFieldWidget(
                borderColor: Theme.of(context).dividerColor,
                filled: true,
                fillColor: themeProvider.isDarkMode()
                    ? AppColors.darkInputColor
                    : AppColors.strokeWhiteColor,
                hintText: AppLocalizations.of(context)!.enter_your_password,
                hintStyle: Theme.of(context).textTheme.bodyLarge,
                prefixIcon: Icon(
                  Icons.lock_outline,
                  color: AppColors.lightGrayColor,
                ),
                suffixIcon: Icon(
                  Icons.visibility_off,
                  color: AppColors.lightGrayColor,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      //todo:navigate to forget password
                      Navigator.pushNamed(context, AppRoutes.forgetPasswordRouteName);
                    },
                    child: Text(
                      '${AppLocalizations.of(context)!.forget_password} ?',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        decoration: TextDecoration.underline,
                        decorationThickness: 2,
                        decorationColor: Theme.of(context).cardColor,
                      ),
                    ),
                  ),
                ],
              ),
              ElevatedButtonWidget(
                //todo:navigate to login screen
                onPressed: login,
                verticalPadding: SizeConfig.height(context) * .01,
                backgroundColor: Theme.of(context).cardColor,
                child: Text(
                  AppLocalizations.of(context)!.login,
                  style: AppStyle.medium20White,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${AppLocalizations.of(context)!.dont_have_an_account}?',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  TextButton(
                    onPressed: () {
                      //todo:navigate to register screen
                      Navigator.pushNamed(context, AppRoutes.registerRouteName);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.sign_up,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        decoration: TextDecoration.underline,
                        decorationThickness: 2,
                        decorationColor: Theme.of(context).cardColor,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Theme.of(context).dividerColor,
                      thickness: 2,
                      indent: SizeConfig.width(context) * .01,
                      endIndent: SizeConfig.width(context) * .04,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.or,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  Expanded(
                    child: Divider(
                      color: Theme.of(context).dividerColor,
                      thickness: 2,
                      indent: SizeConfig.width(context) * .04,
                      endIndent: SizeConfig.width(context) * .01,
                    ),
                  ),
                ],
              ),
              ElevatedButtonWidget(
                onPressed: () {
                  //todo:login with google
                },
                verticalPadding: SizeConfig.height(context) * .02,
                backgroundColor: themeProvider.isDarkMode()
                    ? AppColors.darkInputColor
                    : AppColors.whiteColor,
                borderColor: Theme.of(context).dividerColor,
                child: Row(
                  spacing: SizeConfig.width(context) * .04,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(AppAssets.googleIcon),
                    Text(
                      AppLocalizations.of(context)!.login_with_google,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void login() {
    Navigator.pushNamed(context, AppRoutes.homeRouteName);
  }
}
