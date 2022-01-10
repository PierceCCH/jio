import 'package:flutter/material.dart';
import 'package:jio/models/user.dart';
import 'package:provider/provider.dart';
import 'friend_req_tile.dart';

class FriendReqList extends StatefulWidget {
  @override
  _FriendRequestsListState createState() => _FriendRequestsListState();
}

class _FriendRequestsListState extends State<FriendReqList> {
  @override
  Widget build(BuildContext context) {
    final friendRequests = Provider.of<List<Person>>(context) ?? [];

    if (friendRequests.length == 0) {
      return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("No one wants to be friends with you :C"),
            ]),
      );
    } else {
      return Container(
          //else build friends list
          child: ListView.builder(
              itemCount: friendRequests.length,
              itemBuilder: (context, index) {
                return FriendReqTile(friend: friendRequests[index]);
              }));
    }
  }
}
