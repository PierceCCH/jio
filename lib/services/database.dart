import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jio/models/meetings.dart';
import 'package:jio/models/user.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  //collection reference
  final CollectionReference users = Firestore.instance.collection('Users');
  final CollectionReference userLocations = Firestore.instance.collection('userLocations');
  final CollectionReference meetups = Firestore.instance.collection('Meetings');

  Future updateUserData(String uid, String name, String email) async {
    return await users.document(uid).setData({
      'uid': uid,
      'name': name,
      'email': email,
    });
  }

  Future updateUserLocation(String uid, double latitude, double longitude) async {
    return await userLocations.document(uid).setData({
      'uid': uid,
      "latitude": latitude,
      "longitude": longitude,
    });
  }

  //userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      name: snapshot.data['name'],
      uid: uid,
    );
  }

  List<User> _friendrequestsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return User(
        uid: doc.data['uid'] ?? '',
        //username: doc.data['name'] ?? '' //username for display in pages
        );
    }).toList();
  }

  List<User> _friendsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return User(
        uid: doc.data['uid'] ?? '',
        username: doc.data['name'] ?? '' //username for display in pages
        );
      }).toList();
    }
  
  List<Meeting> _meetingListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Meeting(
        friends: List.from(doc['friends']),
        time: doc.data['time'] ?? '',
        address: doc.data['address'] ?? '',
        name: doc.data['name'] ?? ''
        );
      }).toList();
    }

  Stream<UserData> get userData {
    return users.document(uid).snapshots()
    .map(_userDataFromSnapshot);
  }

  Stream<UserData> get userLocation {
    return userLocations.document(uid).snapshots()
    .map(_userDataFromSnapshot);
  }

  Stream <List<User>> get requests {
    return users.document(uid).collection("FriendRequests").snapshots()
    .map(_friendrequestsListFromSnapshot);
  }

  Stream <List<User>> get friends {
    return users.document(uid).collection("Friendship").snapshots()
    .map(_friendsListFromSnapshot);
  }

  Stream <List<Meeting>> get meeting {
    return meetups.document(uid).collection("Meetings").snapshots()
    .map(_meetingListFromSnapshot);
  }
  

}