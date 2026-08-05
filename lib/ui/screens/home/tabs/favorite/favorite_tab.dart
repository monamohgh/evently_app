import 'package:evently_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/size_config.dart';
import '../../../widgets/text_form_field_widget.dart';
import '../home/event_item_widget.dart';

class FavoriteTab extends StatelessWidget {
  const FavoriteTab({super.key});

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
                 child: ListView.separated(
                   itemBuilder: (context, index) {
                     return EventItemWidget();
                   },
                   separatorBuilder: (context, index) {
                     return SizedBox(
                       height: SizeConfig.height(context)*.02,
                     );
                   },
                   itemCount: 20,
                 ),
               ),
             ],
           ),
         ),
       ),
    );
  }
}
