import "package:flutter/material.dart";
import 'package:jio/models/user.dart';
import 'package:jio/screens/home/create_meeting/pick_members/friends_to_meet.dart';
import 'package:jio/services/database.dart';
import 'package:jio/services/methods.dart';
import 'package:provider/provider.dart';

import '../done.dart';

class PickMembers extends StatefulWidget {

  final String address;
  final String dateAndTime;
  PickMembers({this.address, this.dateAndTime});

  @override
  _PickMembersState createState() => _PickMembersState();
}

class _PickMembersState extends State<PickMembers> {
  
  Color listTileColor = Color(0x00FFF7);
  double screenWidth;
  double screenHeight;
  String name;

  //list of friends selected from friends_to_meet
  List<String> friendsToMeet = [];
  void toList(list) {
    friendsToMeet = list;
    print("pick members page: $friendsToMeet");
  }

  @override
  Widget build(BuildContext context) {
    
    User user = Provider.of<User>(context);
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return StreamProvider.value(
      value: DatabaseService(uid: user.uid).friends,
      child: Scaffold(
      appBar: AppBar(
        title: Text("Pick your friends"),
        backgroundColor: Colors.orange
      ),
      body: Container( //background
          decoration: BoxDecoration(gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.orange[100], Colors.orange[300]]
            )
          ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

//////////////TIME AND ADDRESS INFORMATION////////////////////////////
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text("The meeting will be on", style: TextStyle(fontSize: 20,)
              ),
            ),
            Center(
              child: Text(
                widget.dateAndTime,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)
              )
            ),
            Text("at", style: TextStyle(fontSize: 20,)),
            Center(
              child: Text(
                widget.address,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30, fontWeight: FontWeight.bold,
                )
              ),
            ),
/////////////////////////////////////////////////////////////////////////////////
            SizedBox(
              height: screenHeight*0.05,
            ),
            Container(
              height: screenHeight*0.3,
              width: screenWidth*0.95,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.black, spreadRadius: 3),
                  ],
                ),
              child: FriendsToMeet(func: toList)
            ),
            Container(
              width: screenWidth*0.6,
              padding: EdgeInsets.all(10),
              child: TextFormField(
                  onChanged: (val){
                    setState(() => name = val);
                  },
                  validator: (val) => val!=null ? null : "Please input a name",
                  decoration: InputDecoration(
                    hintText: "Event name"
                  )
                ),
            ),
            Builder(
                builder: (context)=> Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                width: screenWidth*0.5,
                height: screenWidth*0.1,
                  child: FlatButton(
                    color: Colors.transparent,
                    onPressed: (){
                      print(friendsToMeet);
                      if(friendsToMeet.length != 0)
                      {
                      print("Creating meeting......");
                      createMeeting(widget.address, widget.dateAndTime, user.uid, friendsToMeet, name);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Done()),);
                      }
                      else{
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please pick at least 1 member'),
                            duration: Duration(seconds: 3),
                            )
                          );
                        }
                      },
                      child: Text(
                        "Complete",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      )
                    ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.green[600],
                  boxShadow: [
                    BoxShadow(color: Colors.black, spreadRadius: 3),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}