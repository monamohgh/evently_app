import 'package:evently_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(AppLocalizations.of(context)!.event_description ),
      ),
      body: Center(
        child: Text(AppLocalizations.of(context)!.second_onboarding),
      ),
    );
  }
}
