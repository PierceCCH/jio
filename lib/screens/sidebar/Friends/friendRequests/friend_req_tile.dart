import "package:flutter/material.dart";
import 'package:jio/models/user.dart';
import 'package:jio/services/methods.dart';
import 'package:provider/provider.dart';

class FriendReqTile extends StatelessWidget {
  final Person friend;
  FriendReqTile({this.friend});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Person>(context);

    return Padding(
        padding: EdgeInsets.only(top: 8),
        child: Card(
            margin: EdgeInsets.fromLTRB(10, 6, 10, 0),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.pink,
                radius: 25,
              ),
              title: Text(friend.uid), //replace with friend username
              trailing: Container(
                width: 60,
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: IconButton(
                        onPressed: () {
                          acceptFriendRequest(friend.uid, user.uid);
                        },
                        icon: Icon(Icons.check),
                        iconSize: 20,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: IconButton(
                        onPressed: () {
                          denyFriendRequest(friend.uid, user.uid);
                        },
                        icon: Icon(Icons.clear),
                        iconSize: 20,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
