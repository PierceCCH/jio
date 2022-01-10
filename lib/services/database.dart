import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jio/models/meetings.dart';
import 'package:jio/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference users =
      FirebaseFirestore.instance.collection('Users');
  final CollectionReference userLocations =
      FirebaseFirestore.instance.collection('userLocations');
  final CollectionReference meetups =
      FirebaseFirestore.instance.collection('Meetings');

  Future updateUserData(String uid, String name, String email) async {
    return await users.doc(uid).set({
      'uid': uid,
      'name': name,
      'email': email,
    });
  }

  Future updateUserLocation(
      String uid, double latitude, double longitude) async {
    return await userLocations.doc(uid).set({
      'uid': uid,
      "latitude": latitude,
      "longitude": longitude,
    });
  }

  //userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      name: "Bobby",
      uid: "20202",

      // name: snapshot.data['name'],
      // uid: uid,
    );
  }

  List<Person> _friendrequestsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Person(
        uid: "20202002",
        //username: doc.data['name'] ?? '' //username for display in pages
      );
    }).toList();
  }

  List<Person> _friendsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Person(
          uid: "20202002", username: "Pierce" //username for display in pages

          // uid: doc.data['uid'] ?? '',
          // username: doc.data['name'] ?? '' //username for display in pages
          );
    }).toList();
  }

  List<Meeting> _meetingListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Meeting(
          friends: ["Tim", "Tam", "Tom"],
          time: "12 July 9pm",
          address: "330 De Neve Drive",
          name: "Pierce");
      // friends: List.from(doc['friends']),
      // time: doc.data['time'] ?? '',
      // address: doc.data['address'] ?? '',
      // name: doc.data['name'] ?? '');
    }).toList();
  }

  Stream<UserData> get userData {
    return users.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  Stream<UserData> get userLocation {
    return userLocations.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  Stream<List<Person>> get requests {
    return users
        .doc(uid)
        .collection("FriendRequests")
        .snapshots()
        .map(_friendrequestsListFromSnapshot);
  }

  Stream<List<Person>> get friends {
    return users
        .doc(uid)
        .collection("Friendship")
        .snapshots()
        .map(_friendsListFromSnapshot);
  }

  Stream<List<Meeting>> get meeting {
    return meetups
        .doc(uid)
        .collection("Meetings")
        .snapshots()
        .map(_meetingListFromSnapshot);
  }
}
