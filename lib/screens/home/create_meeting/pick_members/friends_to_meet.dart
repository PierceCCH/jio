import 'package:flutter/material.dart';
import 'package:jio/models/user.dart';
import 'package:provider/provider.dart';
import 'Friends_To_Meet_Tile.dart';

class FriendsToMeet extends StatefulWidget {

  final func;
  FriendsToMeet({this.func});

  @override
  _FriendsToMeetState createState() => _FriendsToMeetState();
}

class _FriendsToMeetState extends State<FriendsToMeet> {

  //list of selected friends user wants to meet
  List<String> friendsToMeet = [];
  //add friend to list if checked
  void toList(friend){
    if(friend != null){
      friendsToMeet.add(friend);
      widget.func(friendsToMeet);
    }
  }
  //remove friend from list if unchecked
  void offList(friend){
    friendsToMeet.remove(friend);
    widget.func(friendsToMeet);
  }

  @override
  Widget build(BuildContext context) {
    
    //list of all of user's friends
    final friends = Provider.of<List<User>>(context) ?? [];

    if (friends.length == 0) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            Text("You have no friends."),
          ]
        ),
      );
    } else {
    return Container(
      child: ListView.builder(
        itemCount: friends.length,
        itemBuilder: (context, index){
          return FriendsToMeetTile(friend: friends[index], toList: toList, offList: offList);
          }
        )
      );
    }
  }
  
  
}