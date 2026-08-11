import 'package:evently_app/firebase_utils.dart';
import 'package:evently_app/model/my_user.dart';
import 'package:evently_app/providers/user_provider.dart';
import 'package:evently_app/utils/app_style.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';
import '../../../providers/app_theme_provider.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_routes.dart';
import '../../../utils/dialog_utils.dart';
import '../../../utils/size_config.dart';

import '../widgets/elevated_button_widget.dart';
import '../widgets/text_form_field_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var nameController = TextEditingController(text:'Mona');
  var emailController = TextEditingController(text:'mona@gmail.com');
  var passwordController = TextEditingController(text: '123456' );
  var rePasswordController = TextEditingController(text: '123456' );
  var formKey = GlobalKey<FormState>();
  bool _passwordVisible =true;
  bool _rePasswordVisible =true;
  @override
  void initState() {
    _passwordVisible = false;
    _rePasswordVisible=false;
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
            key:formKey ,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: SizeConfig.height(context) * .02,
              children: [
                Text(
                  AppLocalizations.of(context)!.create_your_account,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                TextFormFieldWidget(
                  keyboardType: TextInputType.text,
                  controller: nameController,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return "Please enter your name";
                    }
                    return null;
                  },
                  borderColor: Theme.of(context).dividerColor,
                  filled: true,
                  fillColor: themeProvider.isDarkMode()
                      ? AppColors.darkInputColor
                      : AppColors.strokeWhiteColor,
                  hintText: AppLocalizations.of(context)!.enter_your_name,
                  hintStyle: Theme.of(context).textTheme.bodyLarge,
                  prefixIcon: Icon(
                    Icons.person_outline,
                    color: AppColors.lightGrayColor,
                  ),
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

                TextFormFieldWidget(
                  keyboardType: TextInputType.number,
                  obscureText: !_rePasswordVisible,
                  ///This will obscure text dynamically
                  controller: rePasswordController,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return "Please enter your password";
                    }
                    if (text!=passwordController.text ) {
                      return "Password should be the same ";

                    }
                    return null;
                  },
                  borderColor: Theme.of(context).dividerColor,
                  filled: true,
                  fillColor: themeProvider.isDarkMode()
                      ? AppColors.darkInputColor
                      : AppColors.strokeWhiteColor,
                  hintText: AppLocalizations.of(context)!.confirm_your_password,
                  hintStyle: Theme.of(context).textTheme.bodyLarge,
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: AppColors.lightGrayColor,
                  ),
                  suffixIcon: IconButton(
                    color: AppColors.lightGrayColor,
                    icon: Icon(
                      /// Based on passwordVisible state choose the icon
                      _rePasswordVisible
                          ? Icons.visibility_rounded
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        /// Update the state i.e. toogle the state of passwordVisible variable
                        _rePasswordVisible = !_rePasswordVisible;
                      });
                    },
                  ),
                ),
                SizedBox(height: SizeConfig.height(context)*.02,),
                ElevatedButtonWidget(
                  //todo:navigate to register screen
                  onPressed: register,
                  verticalPadding: SizeConfig.height(context) * .01,
                  backgroundColor: Theme.of(context).cardColor,
                  child: Text(
                    AppLocalizations.of(context)!.sign_up,
                    style: AppStyle.medium20White,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${AppLocalizations.of(context)!.already_have_an_account}?',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    TextButton(
                      onPressed: () {
                        //todo:navigate to login screen
                        Navigator.pop(context);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.login,
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
                    //todo:sign up with google
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
                        AppLocalizations.of(context)!.sign_up_with_google,
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
  void register()async {
    if (formKey.currentState?.validate()==true){
      //todo:register
      ///FirebaseAuth.instance=>create object from FirebaseAuth class
      try {
        //todo:1-show loading
        DialogUtils.showLoading(context: context, loadingText: 'Waiting....');
        //todo:2-firebaseAuth
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        MyUser myUser=MyUser(
            name: nameController.text,
            email: emailController.text,
            id: credential.user?.uid??'');
        //todo:3-save user in  firestore
        await FirebaseUtils.addUserInFireStore(myUser);

        /// we create provider outside the build but make listen=false
        /// listen=false => it means give me the data once if it changed I will not be notified
        /// because i am outside the build I am not interested of the  identity of the user in the provider
        //todo:4-save user  provider
        var userProvider=Provider.of<UserProvider>(context,listen: false);
        userProvider.updateUser(myUser);
        //todo:5-hide loading
        DialogUtils.hideLoading(context: context);
        //todo:6-show message=>success
        DialogUtils.showMessage(context: context,
          message: 'Register Successfully',
          title: 'Success',
          positiveActionName: 'Ok',
          positiveAction: () {
            Navigator.pushNamed(context, AppRoutes.homeRouteName);
          },
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          //todo:hide loading
          DialogUtils.hideLoading(context: context);
          //todo:show message=>error
          DialogUtils.showMessage(
            context: context,
            message: 'The password provided is too weak.',
            title: 'Error ',
            positiveActionName: 'Ok',

          );
        } else if (e.code == 'email-already-in-use') {
          //todo:hide loading
          DialogUtils.hideLoading(context: context);
          //todo:show message=>error
          DialogUtils.showMessage(
            context: context,
            message: 'The account already exists for that email.',
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
