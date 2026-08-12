// import 'package:flutter/widgets.dart';
//
// import '../firebase_utils.dart';
// import '../model/event.dart';
//
// class EventProvider extends ChangeNotifier {
//   //todo:data - function
//   List<Event> eventList = [];
//   void getAllEvents() async {
//     var querySnapshot = await FirebaseUtils.getEventsCollections().get();
//     //todo:List<QueryDocumentSnapshot<Event>> => List<Event>
//     eventList = querySnapshot.docs.map((doc) {
//       return doc.data();
//     }).toList();
//    notifyListeners();
//   }
// }