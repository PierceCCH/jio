import "package:flutter/material.dart";
import 'package:jio/models/user.dart';
import 'package:jio/services/database.dart';
import 'package:provider/provider.dart';

import 'friend_req_list.dart';

class FriendRequests extends StatefulWidget {
  @override
  _FriendRequestsState createState() => _FriendRequestsState();
}

class _FriendRequestsState extends State<FriendRequests> {
  @override
  Widget build(BuildContext context) {

    User user = Provider.of<User>(context);
    
    return StreamProvider.value(
      value: DatabaseService(uid: user.uid).requests,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Friend Requests"),
          centerTitle: true,
          backgroundColor: Colors.orange,
        ),
        body: FriendReqList()
      ),
    );
  }
}