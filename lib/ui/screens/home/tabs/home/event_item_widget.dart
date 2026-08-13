import 'package:evently_app/firebase_utils.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/model/event.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/size_config.dart';
import 'package:evently_app/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/app_theme_provider.dart';

class EventItemWidget extends StatelessWidget {
  final Event event;

  const EventItemWidget({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Container(
      height: SizeConfig.height(context) * .25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).dividerColor, width: 2),
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(event.eventImage),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.width(context) * .02,
          vertical: SizeConfig.height(context) * .01,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.width(context) * .01,
                vertical: SizeConfig.height(context) * .01,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).dividerColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).highlightColor,
              ),
              child: Text(
                DateFormat('dd MMM').format(event.eventDate).toString(),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).dividerColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
                color: themeProvider.isDarkMode()
                    ? AppColors.darkInputColor
                    : AppColors.strokeWhiteColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      event.eventTitle,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),

                  IconButton(
                    onPressed: () {
                      //todo:add favorite event
                      FirebaseUtils.updateIsFavourite(event)
                          .then((value) {
                            ToastUtils.showToastMessage(
                              message: 'Event Updated Successfully',
                              backgroundColor: AppColors.greenColor,
                              textColor: AppColors.whiteColor,
                            );
                          })
                          .catchError((error) {
                            ToastUtils.showToastMessage(
                              message: error.toString(),
                              backgroundColor: AppColors.greenColor,
                              textColor: AppColors.whiteColor,
                            );
                          });
                    },
                    icon: event.isFavourite
                        ? Icon(
                            Icons.favorite,
                            color: Theme.of(context).cardColor,
                          )
                        : Icon(
                            Icons.favorite_border_outlined,
                            color: Theme.of(context).cardColor,
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
