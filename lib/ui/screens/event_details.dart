import 'package:evently_app/ui/screens/widgets/elevated_button_widget.dart';
import 'package:evently_app/ui/screens/widgets/text_form_field_widget.dart';
import 'package:evently_app/utils/app_routes.dart';
import 'package:evently_app/utils/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../firebase_utils.dart';
import '../../l10n/app_localizations.dart';
import '../../model/event.dart';
import '../../providers/app_theme_provider.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_style.dart';
import '../../utils/size_config.dart';
import '../../utils/toast_utils.dart';
import 'home/tabs/home/add_event/date_or_time_widget.dart';
import 'home/tabs/home/tab_item_widget.dart';

class EventDetails extends StatefulWidget {
  const EventDetails({super.key});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  List<String> eventLightImagesList = [
    AppAssets.sportLight,
    AppAssets.birthdayLight,
    AppAssets.meetingLight,
    AppAssets.bookClubLight,
    AppAssets.exhibitionLight,
  ];

  List<String> eventDarkImagesList = [
    AppAssets.sportDark,
    AppAssets.birthdayDark,
    AppAssets.meetingDark,
    AppAssets.bookClubDark,
    AppAssets.exhibitionDark,
  ];

  int selectedIndex = 0;
  TimeOfDay? selectedTime;
  String formateTime = '';
  DateTime? selectedDate;
  String formateDate = '';
  var formKey = GlobalKey<FormState>();
  var title = '';
  var description = '';
  String selectedEventImage = '';
  String selectedEventName = '';

  @override
  Widget build(BuildContext context) {
    var event = ModalRoute.of(context)!.settings.arguments as Event;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    List<String> eventsNameList = [
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.book_club,
      AppLocalizations.of(context)!.exhibition,
    ];
    String currentImage = themeProvider.isDarkMode()
        ? event.eventImage.replaceAll('Light', 'Dark').replaceAll('light', 'dark')
        : event.eventImage.replaceAll('Dark', 'Light').replaceAll('dark', 'light');
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
              color: Theme.of(context).highlightColor,
              borderRadius: BorderRadius.circular(8),
              border: BoxBorder.all(color: Theme.of(context).dividerColor),
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
          horizontal: SizeConfig.width(context) * .03,
        ),
        backgroundColor: AppColors.transparentColor,
        title: Text(
          AppLocalizations.of(context)!.event_details,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        centerTitle: true,
        actions: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.width(context) * .02,
              vertical: SizeConfig.height(context) * .01,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).highlightColor,
              borderRadius: BorderRadius.circular(8),
              border: BoxBorder.all(color: Theme.of(context).dividerColor),
            ),
            child: InkWell(
              onTap: () {
                //todo: Navigate to edit screen
                Navigator.pushNamed(context, AppRoutes.editEventRouteName,arguments:event);
              },
              child: Icon(
                size: 30,
                Icons.edit,
                color: themeProvider.isDarkMode()
                    ? AppColors.whiteColor
                    : AppColors.mainLightColor,
              ),
            ),
          ),
          SizedBox(width: SizeConfig.width(context)*.02,),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.width(context) * .02,
              vertical: SizeConfig.height(context) * .01,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).highlightColor,
              borderRadius: BorderRadius.circular(8),
              border: BoxBorder.all(color: Theme.of(context).dividerColor),
            ),
            child: InkWell(
              onTap: () {
                //todo:delete
                deleteEvent(eventId: event.eventId);
              },
              child: Icon(size: 30, Icons.delete, color: AppColors.redColor),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.width(context) * .04,
          vertical: SizeConfig.height(context) * .02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: SizeConfig.height(context) * .02,
          children: [
            Container(
              height: SizeConfig.height(context) * .25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Theme.of(context).dividerColor,
                  width: 2,
                ),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(currentImage),
                ),
              ),
            ),
            Text(
              event.eventTitle,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).highlightColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Theme.of(context).dividerColor,
                  width: 2,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: SizeConfig.width(context) * .05,
                      vertical: SizeConfig.height(context) * .02,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.width(context) * .02,
                    ),
                    decoration: BoxDecoration(
                      color: themeProvider.isDarkMode()
                      ?AppColors.darkInputColor
                      :AppColors.lightBgColor,
                      border: Border.all(color: Theme.of(context).dividerColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: EdgeInsetsGeometry.symmetric(
                        vertical: SizeConfig.height(context) * .01,
                      ),
                      child: Icon(
                        Icons.date_range,
                        color: Theme.of(context).cardColor,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(DateFormat('dd MMMM').format(event.eventDate,),style:Theme.of(context).textTheme.displayLarge,),
                      Text(
                        DateFormat('hh:mm a').format(event.eventDate),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Text(
              AppLocalizations.of(context)!.description,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Container(
              width: double.infinity,
              height: SizeConfig.height(context) * .3,
              decoration: BoxDecoration(
                color: Theme.of(context).highlightColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Theme.of(context).dividerColor,
                  width: 2,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.width(context) * .03,
                  vertical: SizeConfig.height(context) * .03,
                ),
                child: Text(
                  event.eventDescription,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  void deleteEvent({required String eventId}){
    FirebaseUtils.deleteEventFireSore(eventId).then((value) {
      ToastUtils.showToastMessage(
          message: 'Event Deleted Successfully',
          backgroundColor: AppColors.mainLightColor,
          textColor: AppColors.whiteColor
      );
      Navigator.pop(context);
    },);

  }

}
