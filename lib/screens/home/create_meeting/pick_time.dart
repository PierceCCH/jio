import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import 'package:jio/screens/home/create_meeting/pick_members/pick_members.dart';

class PickTime extends StatefulWidget {
  final String address;
  PickTime({this.address});

  @override
  State<StatefulWidget> createState() => _PickTimeState();
}

class _PickTimeState extends State<PickTime> {
  
  double screenWidth;
  double screenHeight;
  final timeFormat = DateFormat("HH:mm");
  final dateFormat = DateFormat("dd:MM:yyyy");
  TimeOfDay chosenTime;
  DateTime chosenDate;
  bool datePicked;
  bool timePicked;
  

  @override
  Widget build(BuildContext context) {
    
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.blue[99], Colors.blue[300]]
              )
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenWidth*0.2,
                ),
                Text(
                  "Pick a date and time",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30
                  ),
                ),
                SizedBox(
                  height: screenWidth*0.05,
                ),
                Container(
                  height: screenHeight*0.1,
                  width: screenWidth*0.8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.place, color: Colors.red, size: 40,),
                      Container(
                        width: screenWidth*0.7,
                        child: Text(widget.address, 
                        style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                        )
                      )
                    ]
                  )
                ),
                SizedBox(
                  height: screenWidth*0.1,
                ),
 //////////////////DateTime Buttons////////////////////////
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Date:",
                      style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                        ),
                      ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.blue,
                        boxShadow: [
                          BoxShadow(color: Colors.black, spreadRadius: 3),
                          ],
                        ),
                      height: screenHeight*0.05,
                      width: screenWidth*0.3,
                      child: DateTimeField(
                        format: dateFormat,
                        onShowPicker: (context, currentValue) async {
                          final date = await showDatePicker(
                              context: context,
                              fieldHintText: "Date: ",
                              firstDate: DateTime.now(),
                              initialDate: currentValue ?? DateTime.now(),
                              lastDate: DateTime(2100));
                          if (date != null){
                            setState(() {
                              chosenDate = date;
                            });
                          }
                          return currentValue;
                          },
                        ),
                      ),
                  ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Time:",
                        style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.blue,
                          boxShadow: [
                            BoxShadow(color: Colors.black, spreadRadius: 3),
                            ],
                          ),
                        height: screenHeight*0.05,
                        width: screenWidth*0.3,
                        child: DateTimeField(
                          format: timeFormat,
                          onShowPicker: (context, currentValue) async {
                            final time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                            );
                          setState(() {
                            chosenTime = time;
                          });
                          return currentValue;
                          }
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                    height: screenHeight*0.2,
                    width: screenHeight*0.2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.blue[50],
                        boxShadow: [
                          BoxShadow(color: Colors.black, spreadRadius: 3),
                          ],
                        ),
                      child: Center(
                        child: Text(
                        "${formatDate(chosenDate)}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: screenHeight*0.2,
                      width: screenHeight*0.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.blue[50],
                        boxShadow: [
                          BoxShadow(color: Colors.black, spreadRadius: 3),
                          ],
                        ),
                      child: Center(
                        child: Text(
                        "${formatTime(chosenTime)}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight*0.1
                ),
                goButton(context, datePicked, timePicked, chosenDate, chosenTime),
              ]
            ),
          )
        ],
      )
    );
  }
  
  Widget goButton(context, datePicked, timePicked, chosenDate, chosenTime){

    String address = widget.address;
    String dateTime; 
    
    if(datePicked == true){
      if(timePicked == true){
        return Container(
          width: screenWidth*0.5,
          height: screenWidth*0.1,
          child: FlatButton(
            color: Colors.transparent,
            onPressed: (){
              setState(() {
                dateTime = dateAndTime(chosenDate, chosenTime);
              });
              Navigator.push(context, MaterialPageRoute(builder: (context) => PickMembers(address: address, dateAndTime: dateTime)),);
            },
            child: Text(
              "Invite participants",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            )
          ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.orange[300],
          boxShadow: [
            BoxShadow(color: Colors.black, spreadRadius: 3),
            ],
          ),
        );
      }
    }
    return Container(
      width: 0,
      height: 0,
    );
    
  }

  String dateAndTime(chosenDate, chosenTime){
    return "${formatDate(chosenDate)}" + "     " + "${formatTime(chosenTime)}";
  }

  String formatDate(DateTime chosenDate){
    setState(() {
      datePicked = true;
    });
    if (chosenDate == null){
      return "Pick a date";
    }
    return DateFormat('dd-MM-yy').format(chosenDate);
  }

  String formatTime(TimeOfDay chosenTime){
    setState(() {
      timePicked = true;
    });
    if (chosenTime == null){
      return "Pick a time";
    }
    return chosenTime.format(context).toString();
  }

}
