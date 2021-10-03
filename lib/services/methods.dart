import 'package:cloud_firestore/cloud_firestore.dart';

final databaseReference = Firestore.instance.collection("Users");
final meetingsReference = Firestore.instance.collection("Meetings");

//when a user sends a friend request, they are putting their userdata into the recipient's collection
void sendFriendRequest(requester, uidRecipient) async {

  await databaseReference.document(uidRecipient).collection("FriendRequests").document(requester)
  .setData({
    'uid': requester,
  });
  print("friend request sent");
}

//after accepted, each user will have the other's data added to their list, and removed from the friendrequest db
void acceptFriendRequest(requester, accepter) async { 
  await databaseReference.document(requester).collection("Friendship").document(accepter)
  .setData({
    'uid': accepter,
  });
  await databaseReference.document(accepter).collection("Friendship").document(requester)
  .setData({
    'uid': requester,
  });
  await databaseReference.document(accepter).collection("FriendRequests").document(requester)
  .delete();
  print("friend added");
}

//to deny request, remove it from the requests collection.
void denyFriendRequest(requester, uidRecipient) async {
  await databaseReference.document(uidRecipient).collection("FriendRequests").document(requester)
  .delete();
  print("friend request denied");
  
}

//create a meeting after all information has been received
void createMeeting(address, dateAndTime, host, friends, name) async {
  await meetingsReference.document(host).collection("Meetings").document("$address + $dateAndTime")
  .setData({
    "address": address,
    "time": dateAndTime,
    "friends": friends,
    "name": name
  });
  
  print("meeting created");
}

//delete a meeting
void deleteMeeting(address, dateAndTime, host) async {
  await meetingsReference.document(host).collection("Meetings").document("$address + $dateAndTime")
  .delete();
  
  print("$address + $dateAndTime deleted");
}
