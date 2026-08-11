
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_style.dart';
import 'package:evently_app/utils/size_config.dart';
import 'package:flutter/material.dart';

class DialogUtils {
  static void showLoading({ required BuildContext context,required String loadingText}){
    showDialog(
      barrierDismissible: false,
        context: context,
        builder:(context) {
          return AlertDialog(
           content:Row(
             mainAxisAlignment: MainAxisAlignment.center,
             spacing: SizeConfig.width(context)*.04,
             children: [
             CircularProgressIndicator(
               color: AppColors.mainLightColor,
             ),
             Text(loadingText,style: AppStyle.semi16MainLightColor  ,)
           ],),
          );
        }, );
  }
  static void hideLoading({required BuildContext context}){
    Navigator.pop(context);
  }
  static void showMessage({required BuildContext context,
  required  String message,String? title='',
    String? positiveActionName,VoidCallback? positiveAction,
    String? negativeActionName,VoidCallback? negativeAction
  }){
    List<Widget>actions=[];
   if(positiveActionName!=null){
     actions.add(TextButton(
         onPressed: () {
           Navigator.pop(context);
           positiveAction?.call();
           ///call=>execute the function
         },
         child: Text(positiveActionName,style: AppStyle.semi16MainLightColor,)));
   }
   if(negativeActionName!=null){
     actions.add(TextButton(
         onPressed:() {
           Navigator.pop(context);
           negativeAction?.call();
         },
         child: Text(negativeActionName,style: AppStyle.semi16MainLightColor,)));
   }
  showDialog(context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(message,style: AppStyle.semi16MainLightColor,),
          title: Text(title!,style: AppStyle.semi16MainLightColor,)  ,
          actions:actions,
        );
      },
  );

  }
}