import 'package:evently_app/firebase_utils.dart';
import 'package:evently_app/providers/user_provider.dart';
import 'package:evently_app/utils/app_style.dart';
import 'package:evently_app/utils/dialog_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  var emailController = TextEditingController(text: 'mona@gmail.com');
  var passwordController = TextEditingController(text: '123456');
  var formKey = GlobalKey<FormState>();
  bool _passwordVisible = true;

  @override
  void initState() {
    _passwordVisible = false;
  }

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
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: SizeConfig.height(context) * .015,
              children: [
                Text(
                  AppLocalizations.of(context)!.login_to_your_account,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                TextFormFieldWidget(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return "Please enter your email";
                    }
                    final bool emailValid = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                    ).hasMatch(emailController.text);
                    if (!emailValid) {
                      return "Please Enter valid email";
                    }
                    return null;
                  },
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
                  keyboardType: TextInputType.number,
                  obscureText: !_passwordVisible,

                  ///This will obscure text dynamically
                  controller: passwordController,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return "Please enter your password";
                    }
                    if (text.length < 6) {
                      return "Password should be at least 6 chars ";
                    }
                    return null;
                  },
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
                  suffixIcon: IconButton(
                    color: AppColors.lightGrayColor,

                    icon: Icon(
                      /// Based on passwordVisible state choose the icon
                      _passwordVisible
                          ? Icons.visibility_rounded
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        /// Update the state i.e. toogle the state of passwordVisible variable
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        //todo:navigate to forget password
                        Navigator.pushNamed(
                          context,
                          AppRoutes.forgetPasswordRouteName,
                        );
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
                        Navigator.pushNamed(
                          context,
                          AppRoutes.registerRouteName,
                        );
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
      ),
    );
  }

  void login() async {
    if (formKey.currentState!.validate() == true) {
      //todo:login
      try {
        //todo:1-show loading
        DialogUtils.showLoading(context: context, loadingText: 'Loading...');
        //todo:2-login FirebaseAuth
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            );
        //todo:3-read user from fireStore
       var user= await FirebaseUtils.readUserFromFireStore(credential.user?.uid??'');
       if(user==null){
         return;
       }
        //todo:4-save user in provider
        var userProvider=Provider.of<UserProvider>(context,listen: false);
        userProvider.updateUser(user);
        //todo:5-hide loading
        DialogUtils.hideLoading(context: context);
        //todo:6-show message=>success
        DialogUtils.showMessage(
          context: context,
          message: 'Login Successfully',
          title: 'Success',
          positiveActionName: 'Ok',
          positiveAction: () {
            Navigator.pushNamed(context, AppRoutes.homeRouteName);
          },
        );

      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
          //todo:hide loading
          DialogUtils.hideLoading(context: context);

          //todo:show message=>error
          DialogUtils.showMessage(
            context: context,
            message:
                'The supplied auth credential is incorrect, malformed or has expired.',
            title: 'Error ',
            positiveActionName: 'Ok',

          );
        }
      } catch (e) {
        //todo:hide loading
        DialogUtils.hideLoading(context: context);
        //todo:show message=>error
        DialogUtils.showMessage(
          context: context,
          message: e.toString(),
                title: 'Error ',
          positiveActionName: 'Ok',

        );
      }
    }
  }
}
