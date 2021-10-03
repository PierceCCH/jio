import "package:flutter/material.dart";
import 'package:jio/models/user.dart';

class FriendsToMeetTile extends StatefulWidget {

  final User friend;
  final toList;
  final offList;
  FriendsToMeetTile({ this.friend, this.toList, this.offList });

  @override
  _FriendsToMeetTileState createState() => _FriendsToMeetTileState();
}

class _FriendsToMeetTileState extends State<FriendsToMeetTile> {
  @override
  Widget build(BuildContext context) {

    String friend;
    bool checkedValue = false;

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState){
        return Padding(
        padding: EdgeInsets.only(top: 8),
        child: Card(
          margin: EdgeInsets.fromLTRB(10, 6, 10, 0),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.pink,
              //backgroundImage: AssetImage('profile pic'),
              radius: 25,
            ),
            title: Text(widget.friend.uid), //replace with friend username
            trailing: Checkbox(
              value: checkedValue,
              onChanged: (newValue) { 
                  setState(() {
                    checkedValue = newValue; 
                  }); 
                  if(checkedValue == true){
                    friend = widget.friend.uid;
                    widget.toList(friend);
                  }
                  else{
                    widget.offList(friend);
                  }
                  print("friends_to_meet_tile.dart: $friend");
                },
              ),
            )
          )
        );
      }
    );
  }
}