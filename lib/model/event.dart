 import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  //todo:collectionName
   static const String collectionName='Events';
  //todo:Attributes
  String eventId;
  String eventImage;
  String eventName;
  String eventTitle;
  String eventDescription;
  DateTime eventDate;
  int eventCategoryIndex;
  bool isFavourite;
  //todo:constructor
   Event({
     this.eventId='',
     required this.eventName,
     required this.eventDate,
     required this.eventDescription,
     required this.eventImage,
     required this.eventTitle,
     required this.eventCategoryIndex,
      this.isFavourite=false,
 });
   //todo:json=>object
  Event.fromFireStore(Map<String,dynamic>data):this(
     eventDate:(data['event_date']as Timestamp).toDate() ,
    eventDescription:data['event_description']  ,
    eventImage:data['event_image']  ,
    eventName: data['event_name'] ,
    eventTitle:data['event_title']  ,
      eventId:data['event_id']  ,
      eventCategoryIndex:data['event_category_index']  ,
    isFavourite: data['is_favourite']
  );
 //todo:object=>json
 Map<String,dynamic>toFireStore(){
   return{
     'event_id':eventId,
     'event_name':eventName,
     'event_date':eventDate,///timestamp
     'event_description':eventDescription,
     'event_image':eventImage,
     'event_title':eventTitle,
     'is_favourite':isFavourite,
     'event_category_index':eventCategoryIndex,

   };
 }
 }