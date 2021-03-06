import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jio/models/user.dart';
import 'package:jio/services/database.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class TravelView extends StatefulWidget {
  TravelView({Key key, this.title, this.markers}) : super(key: key);
  final String title;
  final Set<Marker> markers;

  @override
  _TravelViewState createState() => _TravelViewState();
}

class _TravelViewState extends State<TravelView> {
  StreamSubscription _locationSubscription;
  Location _locationTracker = Location();
  Circle circle;
  GoogleMapController _controller;
  String profilePic = "assets/images/bored.png";

  //initial camera position
  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(1.3521, 103.8198),
    zoom: 13,
  );

  //drawing profile pic as bitmap
  Future<Uint8List> getBytesFromAsset(String profilePic, int width) async {
    ByteData data = await rootBundle.load(profilePic);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

  void updateMarkerAndCircle(LocationData newLocalData, Uint8List imageData) {
    LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);
    this.setState(() {
      Set<Marker> markers = widget.markers;
      markers.add(Marker(
          markerId: MarkerId("home"),
          position: latlng,
          rotation: newLocalData.heading,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imageData)));
      circle = Circle(
          circleId: CircleId("Person"),
          radius: newLocalData.accuracy,
          zIndex: 1,
          strokeColor: Colors.blue,
          center: latlng,
          fillColor: Colors.blue.withAlpha(70));
    });
  }

  void getCurrentLocation(Person user) async {
    try {
      Uint8List imageData = await getBytesFromAsset(profilePic, 100);
      var location = await _locationTracker.getLocation();

      updateMarkerAndCircle(location, imageData);

      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }

      _locationSubscription =
          _locationTracker.onLocationChanged.listen((newLocalData) {
        if (_controller != null) {
          _controller.animateCamera(CameraUpdate.newCameraPosition(
              new CameraPosition(
                  bearing: 192.8334901395799,
                  target: LatLng(newLocalData.latitude, newLocalData.longitude),
                  tilt: 0,
                  zoom: 18.00)));
          updateMarkerAndCircle(newLocalData, imageData);

          //update current user location to firebase
          try {
            DatabaseService(uid: user.uid).updateUserLocation(
                user.uid, newLocalData.latitude, newLocalData.longitude);
            print("${newLocalData.latitude}");
            print("${newLocalData.longitude}");
          } catch (e) {
            print(e.toString());
            return null;
          }
        }
      });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }

  @override
  void dispose() {
    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Set<Marker> markers = widget.markers;
    final user = Provider.of<Person>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Meeting Name"),
        centerTitle: true,
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: initialLocation,
        markers: markers,
        circles: Set.of((circle != null) ? [circle] : []),
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(right: 300),
        child: FloatingActionButton(
            child: Icon(Icons.location_searching),
            onPressed: () {
              getCurrentLocation(user);
            }),
      ),
    );
  }
}
