import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var screenHeight = size.height;
    var screenWidth = size.width;

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: (){
              //go to setting page
            },
            icon: Icon(Icons.settings, color: Colors.white,)
          ,)
        ],
      ),
      
      body: Container(
        color: Colors.blue[50],
        child: Padding(
          padding: EdgeInsets.fromLTRB(0,20,0,20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              circularImage(),
              Text("MyName",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black),
              ),
              
              //black line
              Padding(
                padding: EdgeInsets.all(30.0),
                child: SizedBox(
                  width: screenWidth,
                  height: 0.003*screenHeight,
                  child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.black
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 8),
                child: SizedBox(
                  width: screenWidth,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: FlatButton.icon(
                        onPressed: (){
                        },
                        label: Text("Notifications", style: TextStyle(fontSize: 30),),
                        icon: Icon(Icons.notifications, size: 30,),
                    ),
                      ),
                  ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 8),
                child: SizedBox(
                  width: screenWidth,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: FlatButton.icon(
                        onPressed: (){
                        },
                        label: Text("Devices", style: TextStyle(fontSize: 30),),
                        icon: Icon(Icons.notifications, size: 30,),
                    ),
                      ),
                  ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 8),
                child: SizedBox(
                  width: double.infinity,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: FlatButton.icon(
                        onPressed: (){
                        },
                        label: Text("Privacy and Security", style: TextStyle(fontSize: 30),),
                        icon: Icon(Icons.notifications, size: 30,),
                    ),
                      ),
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget circularImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 100,
          height: 100,
          decoration: new BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.green, width: 5.0, style: BorderStyle.solid),
              image: new DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/bored.png")
            )
          ),
        ),
      ]
    );
  }



}