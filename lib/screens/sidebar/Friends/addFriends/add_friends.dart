import "package:flutter/material.dart";
import 'package:jio/models/user.dart';
import 'package:jio/services/methods.dart';
import 'package:provider/provider.dart';

class AddFriends extends StatefulWidget {
  @override
  _AddFriendsState createState() => _AddFriendsState();
}

class _AddFriendsState extends State<AddFriends> {

  double screenHeight;
  double screenWidth;
  String uidRecipient;
  
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    User user = Provider.of<User>(context) ?? [];
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Add a friend"),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: screenWidth*0.2,
              width: screenWidth*0.8,
              child: TextFormField(
                controller: _textController,
                onChanged: (val){
                  setState(() {
                    uidRecipient = val;
                  });
                },
                decoration: InputDecoration(hintText: "Type your friend's username here"),
              ),
            ),
            Container(
              child: FlatButton(
                onPressed: (){
                  sendFriendRequest(user.uid, uidRecipient);
                  _textController.clear();
                },
                child: Text("Add", style: TextStyle(fontSize: 20),),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.green,
                  boxShadow: [
                    BoxShadow(color: Colors.black, spreadRadius: 3),
                    ],
                  ),
            )
          ],
        ),
      )
    );
  }
}