import "package:flutter/material.dart";
import 'package:jio/models/user.dart';

class FriendTile extends StatelessWidget {
  final Person friend;
  FriendTile({this.friend});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8),
        child: Card(
            margin: EdgeInsets.fromLTRB(10, 6, 10, 0),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.green,
                //backgroundImage: AssetImage('profile pic'),
                radius: 25,
              ),
              title: Text(friend.uid), //replace with friend username
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: 30,
                    width: 30,
                    child: IconButton(
                      onPressed: () {
                        //unimportant possible private chat
                      },
                      icon: Icon(Icons.message),
                      iconSize: 20,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            )));
  }
}
