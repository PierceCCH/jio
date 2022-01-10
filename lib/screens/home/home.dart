import "package:flutter/material.dart";
import 'package:jio/models/user.dart';
import 'package:jio/screens/home/create_meeting/create_meeting.dart';
import 'package:jio/screens/home/meeting_list/meeting_list.dart';
import 'package:jio/screens/sidebar/Friends/friendList/friends.dart';
import 'package:jio/screens/sidebar/profile.dart';
import 'package:jio/services/auth.dart';
import 'package:jio/services/database.dart';
import 'package:provider/provider.dart';

final AuthService _auth = AuthService();
final Color dashColor = Color(0xFFF8F8F8);
final Color sideBarColor = Color(0xFFFFFFFF);
final Color menuTabColor = Color(0xFF000000);

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isCollapsed = true;
  double screenWidth, screenHeight;
  Duration duration = const Duration(milliseconds: 100);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
      backgroundColor: dashColor,
      body: Stack(children: <Widget>[
        menuboard(context),
        mainboard(context),
      ]),
    );
  }

  Widget menuboard(context) {
    return Container(
      color: sideBarColor,
      child: Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              0.05 * screenWidth, 0.10 * screenHeight, 0, 0),
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                circularImage(),

                //Profile button
                SizedBox(height: 50),
                Row(children: <Widget>[
                  Icon(
                    Icons.person,
                    color: menuTabColor,
                  ),
                  FlatButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Profile()),
                        );
                      },
                      child: Text(
                        "Profile",
                        style: TextStyle(color: menuTabColor, fontSize: 20),
                      )),
                ]),
                //Contacts button
                SizedBox(height: 10),
                Row(children: <Widget>[
                  Icon(
                    Icons.contacts,
                    color: menuTabColor,
                  ),
                  FlatButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FriendsPage()),
                        );
                      },
                      child: Text(
                        "Contacts",
                        style: TextStyle(color: menuTabColor, fontSize: 20),
                      )),
                ]),
                //Groups button
                SizedBox(height: 10),
                Row(children: <Widget>[
                  Icon(
                    Icons.group,
                    color: menuTabColor,
                  ),
                  FlatButton(
                      onPressed: () {},
                      child: Text(
                        "Groups",
                        style: TextStyle(color: menuTabColor, fontSize: 20),
                      )),
                ]),
                //White line
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: SizedBox(
                    width: screenWidth,
                    height: 0.003 * screenHeight,
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: Colors.grey),
                    ),
                  ),
                ),

                //Settings button
                SizedBox(height: 10),
                Row(children: <Widget>[
                  Icon(
                    Icons.settings,
                    color: menuTabColor,
                  ),
                  FlatButton(
                      onPressed: () {
                        return null;
                      },
                      child: Text(
                        "Settings",
                        style: TextStyle(color: menuTabColor, fontSize: 20),
                      )),
                ]),

                //logout button
                SizedBox(height: 10),
                Row(children: <Widget>[
                  Icon(
                    Icons.exit_to_app,
                    color: menuTabColor,
                  ),
                  FlatButton(
                      onPressed: () {
                        return _auth.signOut();
                      },
                      child: Text(
                        "Log Out",
                        style: TextStyle(color: menuTabColor, fontSize: 20),
                      )),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget mainboard(context) {
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.5 * screenWidth,
      right: isCollapsed ? 0 : -0.5 * screenWidth,
      child: Material(
        elevation: 8,
        color: dashColor,
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 16, top: 48),
          child: Column(children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  InkWell(
                    child: Icon(
                      Icons.menu,
                      color: Colors.black,
                    ),
                    onTap: () {
                      setState(() {
                        isCollapsed = !isCollapsed;
                      });
                    },
                  ),
                  Text(
                    "Menu",
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ),
                  InkWell(
                    child: Icon(
                      Icons.add_circle,
                      color: Colors.black,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateNewMeeting()),
                      );
                    },
                  )
                ]),
            SizedBox(height: 50),
            //List of meetings
            Container(height: 450, child: listOfMeetings())
          ]),
        ),
      ),
    );
  }

  Widget listOfMeetings() {
    Person user = Provider.of<Person>(context);
    return StreamProvider.value(
      value: DatabaseService(uid: user.uid).meeting,
      child: MeetingList(),
    );
  }

  Widget circularImage() {
    UserData userData = Provider.of<UserData>(context);

    return Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
      Container(
        width: 0.2 * screenWidth,
        height: 0.2 * screenWidth,
        decoration: new BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
                color: Colors.green, width: 5.0, style: BorderStyle.solid),
            image: new DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/bored.png"))),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Text(
          "Pierce",
          // "${userData.name}",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.green[800],
          ),
        ),
      )
    ]);
  }
}
