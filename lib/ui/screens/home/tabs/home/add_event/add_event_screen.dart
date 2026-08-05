import 'package:evently_app/ui/screens/home/tabs/home/add_event/date_or_time_widget.dart';
import 'package:evently_app/ui/screens/home/tabs/home/tab_item_widget.dart';
import 'package:evently_app/ui/screens/widgets/elevated_button_widget.dart';
import 'package:evently_app/ui/screens/widgets/text_form_field_widget.dart';
import 'package:evently_app/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../../l10n/app_localizations.dart';
import '../../../../../../providers/app_theme_provider.dart';
import '../../../../../../utils/app_assets.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/size_config.dart';

class AddEventScreen extends StatefulWidget {
  AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
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

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    List<String> eventsNameList = [
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.book_club,
      AppLocalizations.of(context)!.exhibition,
    ];
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
          horizontal: SizeConfig.width(context) * .02,
        ),
        backgroundColor: AppColors.transparentColor,
        title: Text(
          AppLocalizations.of(context)!.add_event,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.width(context) * .04,
          vertical: SizeConfig.height(context) * .02,
        ),
        child: SingleChildScrollView(
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
                    image: AssetImage(
                      themeProvider.isDarkMode()
                          ? eventDarkImagesList[selectedIndex]
                          : eventLightImagesList[selectedIndex],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.height(context) * .05,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        selectedIndex = index;
                        setState(() {});
                      },
                      child: TabItemWidget(
                        isSelected: selectedIndex == index,
                        eventName: eventsNameList[index],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(width: SizeConfig.width(context) * .02);
                  },
                  itemCount: eventsNameList.length,
                ),
              ),
              Text(
                AppLocalizations.of(context)!.title,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              TextFormFieldWidget(
                filled: true,
                fillColor: Theme.of(context).highlightColor,
                borderColor: Theme.of(context).dividerColor,
                hintText: AppLocalizations.of(context)!.event_title,
                hintStyle: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                AppLocalizations.of(context)!.description,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              TextFormFieldWidget(
                maxLines: 6,
                filled: true,
                fillColor: Theme.of(context).highlightColor,
                borderColor: Theme.of(context).dividerColor,
                hintText: AppLocalizations.of(context)!.event_description,
                hintStyle: Theme.of(context).textTheme.bodyLarge,
              ),
              DateOrTimeWidget(
                onChooseDateOrTime: onChooseDate,
                title: AppLocalizations.of(context)!.event_date,
                icon: Icons.date_range,
                chooseText: selectedDate == null
                    ? AppLocalizations.of(context)!.choose_date
                    : formateDate,
                // :'${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'//format date manual
              ),
              DateOrTimeWidget(
                onChooseDateOrTime: onChooseTime,
                title: AppLocalizations.of(context)!.event_time,
                icon: Icons.watch_later_outlined,
                chooseText:selectedTime==null
                ?AppLocalizations.of(context)!.choose_time
                    :formateTime
              ),
              ElevatedButtonWidget(
                onPressed: addEvent,
                verticalPadding: SizeConfig.height(context) * .01,
                backgroundColor: Theme.of(context).cardColor,
                child: Text(
                  AppLocalizations.of(context)!.add_event,
                  style: AppStyle.medium20White,
                ),
              ),
              SizedBox(height: SizeConfig.height(context) * .04),
            ],
          ),
        ),
      ),
    );
  }

  void addEvent() {}

  void onChooseDate() async {
    var chooseDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 356)),
    );
    if (chooseDate != null) {
      selectedDate = chooseDate;
      formateDate = DateFormat(
        'dd/MM/yyyy',
      ).format(selectedDate!); //format date with package intel
      setState(() {});
    }
  }

  void onChooseTime()async {
  var chooseTime=await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),

    );
  if(chooseTime!=null){
    selectedTime=chooseTime;
    formateTime=selectedTime!.format(context);
    setState(() {

    });
  }
  }
}
