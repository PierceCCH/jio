import "package:flutter/material.dart";
import 'package:jio/models/meetings.dart';

class MeetingListTile extends StatefulWidget {

  final Meeting meeting;
  MeetingListTile({ this.meeting, });

  @override
  _MeetingListTileState createState() => _MeetingListTileState();
}

class _MeetingListTileState extends State<MeetingListTile> {
  
  double screenWidth, screenHeight;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    List<String> dateAndTimeSplit = widget.meeting.time.split("     ");
    List<String> friends = widget.meeting.friends;
    String meetingName = widget.meeting.name;
    String numberOfFriends = friends.length.toString();

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState){
        return Container(
          height: screenHeight*0.20,
          width: screenWidth*0.9,
          child: Stack(
              children: <Widget>[
                informationCard(dateAndTimeSplit, numberOfFriends, meetingName),
                profilePicture()
            ] 
          ),
        );
      }
    );
  }

  Widget informationCard(dateAndTimeSplit, numberOfFriends, meetingName){
    return Container(
      height: 120.0,
      width: screenWidth*0.8,
      margin: new EdgeInsets.only(left: 46.0),
      decoration: new BoxDecoration(
        color: new Color(0xFF000066),
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(  
            color: Colors.black12,
            blurRadius: 10.0,
            offset: new Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(meetingName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20
                ),
              ),
            Text("${dateAndTimeSplit[1]} | ${dateAndTimeSplit[0]}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 200),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(Icons.people, color: Colors.white,),
                  ),
                  Text(numberOfFriends,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15
                    ),
                  ),
                ],
              ),
            ),
          ]
        ),
      ),
    );
  }

  Widget profilePicture(){
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 20.0,
      ),
      alignment: FractionalOffset.centerLeft,
      child: CircleAvatar(
        backgroundColor: Colors.yellow,
        radius: 40,
        //backgroundImage: Image(image: null),
      ),
    );
  }


}