import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jio/models/meetings.dart';
import 'package:jio/models/user.dart';
import 'package:jio/screens/travelling/travel_view.dart';
import 'package:jio/services/methods.dart';
import 'package:provider/provider.dart';

class MeetingInformation extends StatefulWidget {

  final Meeting meeting;
  MeetingInformation({ this.meeting, });

  @override
  _MeetingInformationState createState() => _MeetingInformationState();
}

class _MeetingInformationState extends State<MeetingInformation> {
  
  double screenWidth, screenHeight;
  final Set<Marker> markers = {};
  GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    List<String> dateAndTimeSplit = widget.meeting.time.split("     ");
    String address = widget.meeting.address;
    String meetingName = widget.meeting.name;
    List<String> friends = widget.meeting.friends;
    int numberOfFriends = friends.length;
    User user = Provider.of<User>(context);
    
    final CameraPosition location = CameraPosition(
      target: LatLng(1.3521, 103.8198),
      zoom: 12,
    );
    
    return Scaffold(
      appBar: AppBar(
        title: Text("$meetingName"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Center(
            heightFactor: 1.3,
            child: Container(
              width: screenWidth*0.9,
              height: screenHeight*0.3,
              child: GoogleMap(
                scrollGesturesEnabled: false,
                zoomControlsEnabled: false,
                onMapCreated: onMapCreated,
                onCameraIdle: (){
                  searchandNavigate(address);
                },
                initialCameraPosition: location,
                markers: markers,
              ),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(color: Colors.black, spreadRadius: 3),
                  ],
                ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: screenHeight*0.35),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Date | Time", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                  Text("${dateAndTimeSplit[1]} | ${dateAndTimeSplit[0]}",
                    style: TextStyle(fontSize: 30),
                  ),
                ],
              ),
            ),
            Text("Participants: $numberOfFriends are coming"),
            Center(
              heightFactor: 1,
              child: Container(
                width: screenWidth*0.9,
                height: screenWidth*0.3,
                child: ListView.builder(
                  itemCount: numberOfFriends,
                  itemBuilder: (context, index){
                    return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            friends[index], 
                            style: TextStyle(fontSize: 15),
                          ),
                      );
                    }
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black)
                  ),
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    width: screenWidth*0.4,
                    height: screenWidth*0.1,
                    child: FlatButton(
                      color: Colors.transparent,
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => TravelView(markers: markers)),);
                      },
                      child: Text(
                        "GO",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      )
                    ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.green,
                    boxShadow: [
                      BoxShadow(color: Colors.black, spreadRadius: 3),
                      ],
                    ),
                  ),
                Container(
                    width: screenWidth*0.4,
                    height: screenWidth*0.1,
                    child: FlatButton(
                      color: Colors.transparent,
                      onPressed: (){
                        deleteMeeting(address, widget.meeting.time, user.uid);
                        Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
                      },
                      child: Text(
                        "CANCEL",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      )
                    ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.red,
                    boxShadow: [
                      BoxShadow(color: Colors.black, spreadRadius: 3),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      );
    }

    searchandNavigate(String address) async {
      final query = address;
      var addresses = await Geocoder.local.findAddressesFromQuery(query);
      var first = addresses.first;
      double lat = first.coordinates.latitude;
      double lng = first.coordinates.longitude;

      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
          target: LatLng(lat, lng),
          zoom: 17.0)));

      if (!mounted) return;

      setState(() {
        if(markers != null){
          markers.removeWhere((item) => item.markerId == MarkerId("last"));
        }
        markers.add(Marker(
        markerId: MarkerId("last"),
        infoWindow: InfoWindow(title: "$address"),
        position: LatLng(lat, lng),
        icon: BitmapDescriptor.defaultMarker,
          ));
        });
    }

    void onMapCreated(controller) {
      setState(() {
        mapController = controller;
      });
    }

}