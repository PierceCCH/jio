import 'package:flutter/material.dart';
import 'package:jio/models/user.dart';
import 'package:provider/provider.dart';
import 'friend_list_tile.dart';

class FriendList extends StatefulWidget {
  @override
  _FriendListState createState() => _FriendListState();
}

class _FriendListState extends State<FriendList> {
  @override
  Widget build(BuildContext context) {
    final friends = Provider.of<List<Person>>(context) ?? [];

    if (friends.length == 0) {
      return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("You have no friends."),
            ]),
      );
    } else {
      return Container(
          child: ListView.builder(
              itemCount: friends.length,
              itemBuilder: (context, index) {
                return FriendTile(friend: friends[index]);
              }));
    }
  }
}
