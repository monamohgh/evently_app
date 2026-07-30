import 'package:evently_app/home/home_screen.dart';
import 'package:evently_app/utils/app_routes.dart';
import 'package:flutter/material.dart';

import 'l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
    initialRoute:AppRoutes.homeRouteName ,
      routes: {
      AppRoutes.homeRouteName:(context)=>HomeScreen(),
      },
      locale: Locale('ar'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}


