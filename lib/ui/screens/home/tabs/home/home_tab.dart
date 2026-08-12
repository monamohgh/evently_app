import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/firebase_utils.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/model/event.dart';
import 'package:evently_app/providers/app_language_provider.dart';
import 'package:evently_app/providers/user_provider.dart';
import 'package:evently_app/ui/screens/home/tabs/home/tab_item_widget.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_style.dart';
import 'package:evently_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/app_theme_provider.dart';
import 'event_item_widget.dart';

class HomeTab extends StatefulWidget {
  HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int selectedIndex = 0;
  List<Event> eventList = [];
  Stream<List<Event>>? eventStream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    eventStream = FirebaseUtils.getAllEvents();
  }
  void updateStream(int index){
    selectedIndex=index;
    if(selectedIndex==0){
      eventStream=FirebaseUtils.getAllEvents();
    }else{
      eventStream=FirebaseUtils.getFilterEvents(selectedIndex: selectedIndex);
    }
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    List<String> eventsNameList = [
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.book_club,
      AppLocalizations.of(context)!.exhibition,
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.width(context) * .04,
          ),
          child: DefaultTabController(
            length: eventsNameList.length,
            child: Column(
              spacing: SizeConfig.height(context) * .03,
              children: [
                Row(
                  children: [
                    Column(
                      spacing: SizeConfig.height(context) * .02,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${AppLocalizations.of(context)!.welcome_back}✨',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          userProvider.currentUser!.name,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ],
                    ),
                    Spacer(),
                    Icon(
                      themeProvider.isDarkMode()
                          ? Icons.dark_mode_outlined
                          : Icons.wb_sunny_outlined,
                      color: Theme.of(context).cardColor,
                    ),
                    SizedBox(width: SizeConfig.width(context) * .02),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.width(context) * .02,
                        vertical: SizeConfig.height(context) * .01,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        languageProvider.appLanguage.toUpperCase(),
                        style: AppStyle.semi14WhiteColor,
                      ),
                    ),
                  ],
                ),
                TabBar(
                  onTap: (index) {
                    updateStream(index);
                  },
                  tabAlignment: TabAlignment.start,
                  labelPadding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.width(context) * .02,
                  ),
                  indicatorColor: AppColors.transparentColor,
                  isScrollable: true,
                  dividerColor: AppColors.transparentColor,
                  tabs: eventsNameList.map((eventName) {
                    return TabItemWidget(
                      isSelected:
                          selectedIndex == eventsNameList.indexOf(eventName),
                      eventName: eventName,
                    );
                  }).toList(),
                ),
                Expanded(
                  child: StreamBuilder<List<Event>>(
                    stream: eventStream,
                    builder: (context, snapshot) {
                      //todo:loading
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: AppColors.mainLightColor,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            snapshot.error.toString(),
                            style: Theme
                                .of(context)
                                .textTheme
                                .headlineMedium,
                          ),
                        );
                      } else if (!snapshot.hasData && snapshot.data!.isEmpty) {
                        return Center(
                          child: Text(
                            AppLocalizations.of(context)!.no_events_found,
                            style: Theme
                                .of(context)
                                .textTheme
                                .headlineMedium,
                          ),
                        );
                      } else {
                        eventList = snapshot.data!;
                        return eventList.isEmpty?
                            Center(
                              child: Text(AppLocalizations.of(context)!.no_events_found,
                              style: Theme.of(context).textTheme.headlineMedium,
                              ),
                            )
                            :
                          ListView.separated(
                            itemBuilder: (context, index) {
                              return EventItemWidget(
                                  event: eventList[index]);
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: SizeConfig.height(context) * .02,
                              );
                            },
                            itemCount: eventList.length,
                          );
                      }
                    }
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }



 
}
