import 'package:flutter/material.dart';

class Done extends StatefulWidget {
  @override
  _DoneState createState() => _DoneState();
}

class _DoneState extends State<Done> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          "Complete"
        ),
        centerTitle: true
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Meeting Created",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                ),
              ),
              FlatButton(
                onPressed: (){
                  Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
                },
                child: Text(
                  "Return"
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}