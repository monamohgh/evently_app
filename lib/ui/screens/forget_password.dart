import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/ui/screens/widgets/elevated_button_widget.dart';
import 'package:evently_app/ui/screens/widgets/text_form_field_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/app_theme_provider.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_style.dart';
import '../../utils/dialog_utils.dart';
import '../../utils/size_config.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
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
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
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
                TextFormFieldWidget(
                  borderColor: Theme.of(context).dividerColor,
                  hintText: AppLocalizations.of(context)!.enter_your_email,
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.enter_your_email;
                    }
                    return null;
                  },
                ),
                ElevatedButtonWidget(
                  //todo: reset password
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      //todo: Call reset logic
                      resetPassword(email: emailController.text);
                    }
                  },
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
        ),
      ),
    );
  }

  Future<void> resetPassword({required String email}) async {
    //todo:show loading
    DialogUtils.showLoading(context: context, loadingText: 'Loading...');
    try {
      //todo:send request to firebase
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.trim());
      //todo:hide loading
      //mounted is true=>success
      if(mounted)DialogUtils.hideLoading(context: context);
      if(mounted){
        DialogUtils.showMessage(context: context,
            message: 'Reset link has been sent to your email!',
        positiveActionName: 'OK',
        );
      }
    }on FirebaseAuthException catch(e){
      //todo:hide loading in error state
      if(mounted)DialogUtils.hideLoading(context: context);
      String errorMessage = 'Something went wrong';
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found with this email.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'The email address is not valid.';
      }
      //todo:show error message
      if(mounted){
   DialogUtils.showMessage(context: context, message: errorMessage,positiveActionName: 'OK');
      }
    }catch(e){
      if (mounted) DialogUtils.hideLoading(context: context,);
      if(mounted){      DialogUtils.showMessage(context: context, message: e.toString(),positiveActionName: 'Ok');
      }
    }
  }
}
