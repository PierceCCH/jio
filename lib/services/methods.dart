import 'package:cloud_firestore/cloud_firestore.dart';

final databaseReference = FirebaseFirestore.instance.collection("Users");
final meetingsReference = FirebaseFirestore.instance.collection("Meetings");

//when a user sends a friend request, they are putting their userdata into the recipient's collection
void sendFriendRequest(requester, uidRecipient) async {
  await databaseReference
      .doc(uidRecipient)
      .collection("FriendRequests")
      .doc(requester)
      .set({
    'uid': requester,
  });
  print("friend request sent");
}

//after accepted, each user will have the other's data added to their list, and removed from the friendrequest db
void acceptFriendRequest(requester, accepter) async {
  await databaseReference
      .doc(requester)
      .collection("Friendship")
      .doc(accepter)
      .set({
    'uid': accepter,
  });
  await databaseReference
      .doc(accepter)
      .collection("Friendship")
      .doc(requester)
      .set({
    'uid': requester,
  });
  await databaseReference
      .doc(accepter)
      .collection("FriendRequests")
      .doc(requester)
      .delete();
  print("friend added");
}

//to deny request, remove it from the requests collection.
void denyFriendRequest(requester, uidRecipient) async {
  await databaseReference
      .doc(uidRecipient)
      .collection("FriendRequests")
      .doc(requester)
      .delete();
  print("friend request denied");
}

//create a meeting after all information has been received
void createMeeting(address, dateAndTime, host, friends, name) async {
  await meetingsReference
      .doc(host)
      .collection("Meetings")
      .doc("$address + $dateAndTime")
      .set({
    "address": address,
    "time": dateAndTime,
    "friends": friends,
    "name": name
  });

  print("meeting created");
}

//delete a meeting
void deleteMeeting(address, dateAndTime, host) async {
  await meetingsReference
      .doc(host)
      .collection("Meetings")
      .doc("$address + $dateAndTime")
      .delete();

  print("$address + $dateAndTime deleted");
}
