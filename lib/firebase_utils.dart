import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/model/event.dart';
import 'package:evently_app/model/my_user.dart';
import 'package:evently_app/utils/dialog_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

///withConverter=>make the firestore know the type of the variable that store in it
class FirebaseUtils {
  static CollectionReference<MyUser> getUserCollections() {
    /// get or create collection
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
          fromFirestore: (snapshot, options) =>
              MyUser.fromFireStore(snapshot.data()!),
          toFirestore: (user, options) => user.toFireStore(),
        );
  }

  static CollectionReference<Event> getEventsCollections() {
    return FirebaseFirestore.instance
        .collection(Event.collectionName)
        .withConverter<Event>(
          fromFirestore: (snapshot, options) =>
              Event.fromFireStore(snapshot.data()!),
          toFirestore: (event, options) => event.toFireStore(),
        );
  }

  static Future<void> addUserInFireStore(MyUser myUser) {
    //todo:1- create collection
    CollectionReference<MyUser> collectionRef = getUserCollections();
    //todo:2-create document
    DocumentReference<MyUser> docRef = collectionRef.doc(myUser.id);
    //todo:add data
    return docRef.set(myUser);

    ///the solution in one line
    /// getUserCollections().doc(myUser.id).set(mFuture<MyUser?>
  }

  static Future<MyUser?> readUserFromFireStore(String uId) async {
    DocumentSnapshot<MyUser> querySnapshot = await getUserCollections()
        .doc(uId)
        .get();
    return querySnapshot.data();
  }

  static Future<void> addEventInFireStore(Event event) {
    //todo:1- collection
    CollectionReference<Event> collectionRef = getEventsCollections();
    //todo:2-document
    DocumentReference<Event> docRef = collectionRef.doc();
    //todo:auto id
    event.eventId = docRef.id;

    ///auto id
    //todo:save data
    return docRef.set(event);
  }

  //todo:Real Time Changes=>snapshot method
  static Stream<List<Event>> getAllEvents() {
    ///Stream=>list of future=>without await and async
    Stream<QuerySnapshot<Event>> stream = FirebaseUtils.getEventsCollections()
        .orderBy('event_date')
        .snapshots();
    return stream.map((querySnapshot) {
      //todo:List<QueryDocumentSnapshot<Event>> => List<Event>
      return querySnapshot.docs.map((doc) {
        return doc.data();
      }).toList();
    });
  }

  //todo:filter events
  static Stream<List<Event>> getFilterEvents({required int selectedIndex}) {
    ///Stream=>list of future=>without await and async
    Stream<QuerySnapshot<Event>> stream = FirebaseUtils.getEventsCollections()
        .where('event_category_index', isEqualTo: selectedIndex)
        .orderBy('event_date')
        .snapshots();
    return stream.map((querySnapshot) {
      //todo:List<QueryDocumentSnapshot<Event>> => List<Event>
      return querySnapshot.docs.map((doc) {
        return doc.data();
      }).toList();
    });
  }

  static Future<void> updateIsFavourite(Event event) {
    return getEventsCollections().doc(event.eventId).update({
      'is_favourite': !event.isFavourite,
    });
  }

  static Stream<List<Event>> getAllFavouriteEvents() {
    return getEventsCollections()
        .where('is_favourite', isEqualTo: true)
        .orderBy('event_date')
        .snapshots()
        .map((querySnapshot) {
          return querySnapshot.docs.map((doc) {
            return doc.data();
          }).toList();
        });
  }



}

///filter by method  where in list
/* if(selectedIndex==0){
                         filterEventList=eventList;
                         filterEventList.sort((event1, event2) {
                           return event1.eventDate.compareTo(event2.eventDate);
                         },);
                        }else{
                          /// use where method to filter the list
                          /// where=>take list and return a new list depends on the condition
                          filterEventList=eventList.where((event) {
                           return event.eventCategoryIndex==selectedIndex;
                          },).toList();
                         ///order by date using sort method
                          filterEventList.sort((event1, event2) {
                            return event1.eventDate.compareTo(event2.eventDate);
                          },);*/
// //todo:one time read=>get method
// void getAllEvents1() async {
//   var querySnapshot = await FirebaseUtils.getEventsCollections().get();
//   //todo:List<QueryDocumentSnapshot<Event>> => List<Event>
//   eventList = querySnapshot.docs.map((doc) {
//     return doc.data();
//   }).toList();
//   setState(() {});
// }
