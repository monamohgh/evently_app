import 'package:evently_app/providers/app_language_provider.dart';
import 'package:evently_app/providers/app_theme_provider.dart';
import 'package:evently_app/providers/user_provider.dart';

import 'package:evently_app/ui/screens/forget_password.dart';
import 'package:evently_app/ui/screens/home/home_screen.dart';
import 'package:evently_app/ui/screens/home/tabs/home/add_event/add_event_screen.dart';
import 'package:evently_app/ui/screens/login/login_screen.dart';
import 'package:evently_app/ui/screens/on_boarding_screen.dart';
import 'package:evently_app/ui/screens/register/register_screen.dart';
import 'package:evently_app/ui/screens/welcome_screen.dart';
import 'package:evently_app/utils/app_routes.dart';
import 'package:evently_app/utils/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'l10n/app_localizations.dart';

void main()async {
  /// when the main is async should write this line=>wait until the firebase initialize then run the app
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) =>AppLanguageProvider(),),
          ChangeNotifierProvider(create: (context) => AppThemeProvider(),),
          ChangeNotifierProvider(create: (context) => UserProvider(),)

    ],
    child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    var languageProvider=Provider.of<AppLanguageProvider>(context);
    var themeProvider=Provider.of<AppThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.welcomeRouteName,
      routes: {
        AppRoutes.homeRouteName: (context) => HomeScreen(),
        AppRoutes.welcomeRouteName: (context) => WelcomeScreen(),
        AppRoutes.onBoardingRouteName:(context)=>OnBoardingScreen(),
        AppRoutes.loginRouteName:(context)=>LoginScreen(),
        AppRoutes.registerRouteName:(context)=>RegisterScreen(),
        AppRoutes.forgetPasswordRouteName:(context)=>ForgetPassword(),
        AppRoutes.addEventRouteName:(context)=>AddEventScreen(),
      },
      locale: Locale(languageProvider.appLanguage),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.appTheme,
    );
  }
}
