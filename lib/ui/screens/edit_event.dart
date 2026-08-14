import 'package:evently_app/ui/screens/widgets/elevated_button_widget.dart';
import 'package:evently_app/ui/screens/widgets/text_form_field_widget.dart';
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

class EditEvent extends StatefulWidget {
  const EditEvent({super.key});

  @override
  State<EditEvent> createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
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
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  int selectedIndex = 0;
  TimeOfDay? selectedTime;
  String formateTime = '';
  DateTime? selectedDate;
  String formateDate = '';
  var formKey=GlobalKey<FormState>();
  bool isInitialized = false;
  late Event event;
 @override
 ///didChangeDependencies come after initState()
 ///in didChangeDependencies we can access context unlike initState so we use it here because we need the context in      event = ModalRoute.of(context)!.settings.arguments as Event;
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
   // تهيئة البيانات أول مرة فقط عند فتح الشاشة
   if(!isInitialized){
      event = ModalRoute.of(context)!.settings.arguments as Event;
      selectedIndex=(event.eventCategoryIndex??1)-1;
      titleController=TextEditingController(text: event.eventTitle);
      descriptionController=TextEditingController(text: event.eventDescription);
      selectedDate=event.eventDate;
      selectedTime=TimeOfDay.fromDateTime(event.eventDate);
      formateDate= DateFormat('MMM dd y ').format(selectedDate!);
      formateTime=selectedTime!.format(context);
      isInitialized=true;
   }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
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
     String selectedEventName=eventsNameList[selectedIndex];
    String selectedEventImage=themeProvider.isDarkMode()
        ?eventDarkImagesList[selectedIndex]
        :eventLightImagesList[selectedIndex];
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
          AppLocalizations.of(context)!.edit_event,
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
          child: Form(
            key:  formKey ,
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
                          selectedEventImage
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
              TextFormFieldWidget(borderColor:Theme.of(context).dividerColor,
              controller: titleController,
                  filled: true,
                fillColor: Theme.of(context).highlightColor,
                hintText: AppLocalizations.of(context)!.event_title,
                validator: (text) {
                  if(text==null||text.isEmpty){
                    return 'Enter Event Title';
                  }
                  return null;
                },
              ),

                Text(
                  AppLocalizations.of(context)!.description,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                TextFormFieldWidget(borderColor:Theme.of(context).dividerColor,
                  controller: descriptionController,
                  maxLines: 5,
                  filled: true,
                  fillColor: Theme.of(context).highlightColor,
                  hintText: AppLocalizations.of(context)!.event_description,
                  validator: (text) {
                    if(text==null||text.isEmpty){
                      return 'Enter Event Description';
                    }
                    return null;
                  },
                ),


                DateOrTimeWidget(
                  onChooseDateOrTime: onChooseDate,
                  title: AppLocalizations.of(context)!.event_date,
                  icon: Icons.date_range,
                  chooseText:formateDate
                ),
                DateOrTimeWidget(
                    onChooseDateOrTime: onChooseTime,
                    title: AppLocalizations.of(context)!.event_time,
                    icon: Icons.watch_later_outlined,
                    chooseText:formateTime
                ),
                ElevatedButtonWidget(
                  onPressed: () {
                    //todo:update event
                    updateEvent(categoryImage:selectedEventImage ,categoryName:selectedEventName );
                  },
                  verticalPadding: SizeConfig.height(context) * .01,
                  backgroundColor: Theme.of(context).cardColor,
                  child: Text(
                    AppLocalizations.of(context)!.update_event,
                    style: AppStyle.medium20White,
                  ),
                ),
                SizedBox(height: SizeConfig.height(context) * .04),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onChooseDate() async {
    DateTime now = DateTime.now();
    // إزالة الوقت من تاريخ اليوم ليصبح عند الساعة 00:00
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime initial = selectedDate ?? today;
    // إذا كان تاريخ الفعالية قديم، نجعله هو الـ firstDate لكي لا يحدث تعارض
    DateTime first = initial.isBefore(today) ? initial : today;
    var chooseDate = await showDatePicker(
      context: context,
      initialDate:initial ,
      firstDate: first,
      lastDate: now.add(Duration(days: 356)),
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
      initialTime: selectedTime??TimeOfDay.now(),

    );
    if(chooseTime!=null){
      selectedTime=chooseTime;
      formateTime=selectedTime!.format(context);
      setState(() {

      });
    }
  }
  void updateEvent({ required String categoryName, required String categoryImage}){
   if(formKey.currentState?.validate()==true){
     Event updateEvent=Event(
         eventName: categoryName,
         eventId: event.eventId,
         eventDate: DateTime(
           selectedDate!.year,
           selectedDate!.month,
           selectedDate!.day,
           selectedTime!.hour,
           selectedTime!.minute
         ),
         eventDescription: descriptionController.text,
         eventImage: categoryImage  ,
         eventTitle: titleController.text,
         eventCategoryIndex: selectedIndex+1);
     FirebaseUtils.updateEventFirestore(updateEvent).then((value) {
       ToastUtils.showToastMessage(
           message: 'Event Updated Successfully',
           backgroundColor: AppColors.mainLightColor,
           textColor: AppColors.whiteColor
       );
       Navigator.pop(context);
       Navigator.pop(context);
     },).catchError((error) {
       ToastUtils.showToastMessage(
           message: error.toString(),
           backgroundColor: AppColors.redColor,
           textColor: AppColors.whiteColor
       );
     },
     );

   }

  }
}
