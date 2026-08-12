import 'package:evently_app/firebase_utils.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../../../../model/event.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/size_config.dart';
import '../../../widgets/text_form_field_widget.dart';
import '../home/event_item_widget.dart';

class FavoriteTab extends StatefulWidget {
  const FavoriteTab({super.key});

  @override
  State<FavoriteTab> createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab> {
  Stream<List<Event>>? favouriteStream;
  List<Event>favouriteList=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    favouriteStream=FirebaseUtils.getAllFavouriteEvents();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Padding(
         padding: EdgeInsets.symmetric(
           horizontal: SizeConfig.width(context) * .04,
           vertical: SizeConfig.height(context) * .02,

         ),
         child: SafeArea(
           child: Column(
             spacing: SizeConfig.height(context)*.02,
             children: [
               TextFormFieldWidget(borderColor:Theme.of(context).dividerColor,
                 filled: true,
                 fillColor: Theme.of(context).highlightColor,
               hintText: AppLocalizations.of(context)!.search_for_event,
                 hintStyle:Theme.of(context).textTheme.bodyLarge ,
                 suffixIcon: Icon(Icons.search,color: Theme.of(context).cardColor,size: 30,),
               ),
               Expanded(
                 child: StreamBuilder<List<Event>>(
                     stream: favouriteStream,
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
                         favouriteList = snapshot.data!;
                         return favouriteList.isEmpty?
                         Center(
                           child: Text(AppLocalizations.of(context)!.no_events_found,
                             style: Theme.of(context).textTheme.headlineMedium,
                           ),
                         )
                             :
                         ListView.separated(
                           itemBuilder: (context, index) {
                             return EventItemWidget(
                                 event: favouriteList[index]);
                           },
                           separatorBuilder: (context, index) {
                             return SizedBox(
                               height: SizeConfig.height(context) * .02,
                             );
                           },
                           itemCount: favouriteList.length,
                         );
                       }
                     }
                 ),
               ),
             ],
           ),
         ),
       ),
    );
  }
}
