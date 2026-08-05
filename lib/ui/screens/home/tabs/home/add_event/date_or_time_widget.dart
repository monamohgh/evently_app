import 'package:flutter/material.dart';

import '../../../../../../l10n/app_localizations.dart';
import '../../../../../../utils/size_config.dart';

class DateOrTimeWidget extends StatelessWidget {
  DateOrTimeWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.chooseText,
    required this.onChooseDateOrTime
  });

  IconData icon;
  String title;
  String chooseText;
  VoidCallback onChooseDateOrTime;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: SizeConfig.width(context) * .01,
      children: [
        Icon(icon, color: Theme.of(context).cardColor),
        Text(title, style: Theme.of(context).textTheme.headlineMedium),
        Spacer(),
        TextButton(
          onPressed: onChooseDateOrTime,
          child:Text(chooseText, style: Theme.of(context).textTheme.titleLarge!.copyWith(
            decoration: TextDecoration.underline,
            decorationThickness: 2,
            decorationColor: Theme.of(context).cardColor,
          ),) ,


        ),
      ],
    );
  }
}
