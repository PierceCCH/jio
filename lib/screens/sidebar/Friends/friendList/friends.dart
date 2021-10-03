import 'package:flutter/material.dart';
import 'package:jio/models/user.dart';
import 'package:jio/screens/sidebar/Friends/addFriends/add_friends.dart';
import 'package:jio/services/database.dart';
import 'package:provider/provider.dart';
import 'friend_list.dart';
import '../friendRequests/friend_requests.dart';

class FriendsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    User user = Provider.of<User>(context);

    return StreamProvider<List<User>>.value(
          value: DatabaseService(uid: user.uid).friends,
          child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            title: Text("Friends"),
            backgroundColor: Colors.orange,
            actions: [
              IconButton(
                onPressed: (){
                  Navigator.push(context, new MaterialPageRoute(
                  builder: (context) => FriendRequests()));
                }, 
                icon: Icon(Icons.notifications),
                iconSize: 20,
              ),
              IconButton(
                onPressed: (){
                  Navigator.push(context, new MaterialPageRoute(
                  builder: (context) => AddFriends()));
                }, 
                icon: Icon(Icons.person_add),
                iconSize: 20,
              ),
            ],
          ),
          body: Container(
            child: FriendList()), 
          )
    );
  }
}