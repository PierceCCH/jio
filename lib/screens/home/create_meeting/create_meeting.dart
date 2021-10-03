import "package:flutter/material.dart";
import 'package:jio/screens/home/create_meeting/pick_place.dart';

class CreateNewMeeting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Create a new meeting", 
                style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                ),
              ),
            ),
      body: PickPlace(),
    );
  }
} //end bracket




