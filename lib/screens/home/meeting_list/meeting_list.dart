import 'package:flutter/material.dart';
import 'package:jio/models/meetings.dart';
import 'package:jio/screens/home/meeting_list/meeting_information.dart';
import 'package:jio/screens/home/meeting_list/meeting_list_tile.dart';
import 'package:provider/provider.dart';

class MeetingList extends StatefulWidget {

  @override
  _MeetingListState createState() => _MeetingListState();
}

class _MeetingListState extends State<MeetingList> {

  @override
  Widget build(BuildContext context) {
    
    //list of all of user's meetings
    final meetings = Provider.of<List<Meeting>>(context) ?? [];

    if (meetings.length == 0) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            Text("You have no meetings yet."),
          ]
        ),
      );
    } else {
    return Container(
      child: ListView.builder(
        itemCount: meetings.length,
        itemBuilder: (context, index){
          return GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => MeetingInformation(meeting: meetings[index])),);
            },
            child: MeetingListTile(meeting: meetings[index])
            );
          }
        )
      );
    }
  }
  
  
}